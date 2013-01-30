#include "lodepng.h"
#include <tiffio.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

#define ERROR 0.7

#define WRONG_NUMBER_OF_ARGUMENTS "Error: wrong number of arguments."
#define ERROR_READING_FILE "Error: could not read file."
#define ERROR_WRITING_FILE "Error: could not write png."
#define PIVOT_NOT_FOUND "Error: pivot not found."

#define get_index(file, x, y) (((y) * (file).width + (x))*4)
#define is_in_file(file, x, y) ((x) >= 0 && (y) >= 0 && (x) < (file).width && (y) < (file).height)
#define is_pixel_filled(file, x, y) ((file).raster[(get_index((file), (x), (y)))] == 0)
#define is_approximately(a, b) ((float)(a) <= (float)((b)/ERROR) && (float)(a) >= (float)((b)*ERROR))

typedef struct {
  int number_of_groups;
  int space_between_groups;
  int questions_per_group;
  char alternatives[20];
  int option_width;
  int option_height;
  int group_x;
  int group_y;
  double horizontal_space_between_options;
  double vertical_space_between_options;
} Zone;

typedef struct {
  char source_path[200];
  char destination_path[200];
  double threshold;

  int pivot_default_x;
  int pivot_default_y;
  int mark_width;
  int mark_height;
  int default_card_width;
  int default_card_height;

  Zone student_zone;
  Zone questions_zone;
} Configuration;

typedef struct {
  int number_of_questions;
  char answers[200];

  unsigned char *raster;
  int height;
  int width;
} File;

typedef struct {
  int x;
  int y;
} Pixel;

void stop(int, const char*);
void read_configuration(int, char**);

File read_file();
int has_format(const char*);
File read_png();
File read_tif();

File rotate180(File);
int is_upside_down(File);

File rotate(File);
double get_tangent(File);

File move(File);
Pixel get_pivot(File);
int is_in_mark(File, int, int);

void process_file(File *);
void process_zone(File *, Zone);
void process_question(File *, Zone, int, int);
double process_option(File, int, int, int, int);

void print_answers(File);
void write_png(File *);

File create_empty_file(int, int);
void copy_pixel(File *, int, int, File *, int, int);
double get_column_density(File, int);


Configuration conf;

int main(int argc, char* argv[]) {
  read_configuration(argc, argv);

  File file = read_file();
  File rotated_180_file = rotate180(file);
  File rotated_file = rotate(rotated_180_file);
  File moved_file = move(rotated_file);

  process_file(&moved_file);
  print_answers(moved_file);
  write_png(&moved_file);

  return 0;
}

void read_configuration(int argc, char* argv[]) {
  if(argc != 30) 
    stop(1, WRONG_NUMBER_OF_ARGUMENTS);
  
  strcpy(conf.source_path, argv[1]);
  strcpy(conf.destination_path, argv[2]);
  sscanf(argv[3], "%lf", &conf.threshold);

  sscanf(argv[4], "%d", &conf.pivot_default_x);
  sscanf(argv[5], "%d", &conf.pivot_default_y);
  sscanf(argv[6], "%d", &conf.mark_width);
  sscanf(argv[7], "%d", &conf.mark_height);
  sscanf(argv[8], "%d", &conf.default_card_width);
  sscanf(argv[9], "%d", &conf.default_card_height);

  int number_of_options, horizontal_group_size, number_of_questions, vertical_group_size;

  sscanf(argv[10], "%d", &conf.student_zone.number_of_groups);
  sscanf(argv[11], "%d", &conf.student_zone.space_between_groups);
  sscanf(argv[12], "%d", &conf.student_zone.questions_per_group);
  strcpy(conf.student_zone.alternatives, argv[13]);
  sscanf(argv[14], "%d", &conf.student_zone.option_width);
  sscanf(argv[15], "%d", &conf.student_zone.option_height);
  sscanf(argv[16], "%d", &conf.student_zone.group_x);
  sscanf(argv[17], "%d", &conf.student_zone.group_y);

  number_of_options = strlen(conf.student_zone.alternatives);
  sscanf(argv[18], "%d", &horizontal_group_size);
  conf.student_zone.horizontal_space_between_options = 
    (double)(horizontal_group_size - conf.student_zone.option_width*number_of_options)/
    (double)(number_of_options - 1);

  number_of_questions = conf.student_zone.questions_per_group;
  sscanf(argv[19], "%d", &vertical_group_size);
  conf.student_zone.vertical_space_between_options = 
    (double)(vertical_group_size - conf.student_zone.option_height*number_of_questions)/
    (double)(number_of_questions - 1);

  sscanf(argv[20], "%d", &conf.questions_zone.number_of_groups);
  sscanf(argv[21], "%d", &conf.questions_zone.space_between_groups);
  sscanf(argv[22], "%d", &conf.questions_zone.questions_per_group);
  strcpy(conf.questions_zone.alternatives, argv[23]);
  sscanf(argv[24], "%d", &conf.questions_zone.option_width);
  sscanf(argv[25], "%d", &conf.questions_zone.option_height);
  sscanf(argv[26], "%d", &conf.questions_zone.group_x);
  sscanf(argv[27], "%d", &conf.questions_zone.group_y);

  number_of_options = strlen(conf.questions_zone.alternatives);
  sscanf(argv[28], "%d", &horizontal_group_size);
  conf.questions_zone.horizontal_space_between_options = 
    (double)(horizontal_group_size - conf.questions_zone.option_width*number_of_options)/
    (double)(number_of_options - 1);

  number_of_questions = conf.questions_zone.questions_per_group;
  sscanf(argv[29], "%d", &vertical_group_size);
  conf.questions_zone.vertical_space_between_options = 
    (double)(vertical_group_size - conf.questions_zone.option_height*number_of_questions)/
    (double)(number_of_questions - 1);
}

File read_file() {
  if(has_format("png"))
    return read_png();
  else if(has_format("tif"))
    return read_tif();
  stop(2, ERROR_READING_FILE);
}

int has_format(const char* format) {
  int path_length = strlen(conf.source_path);
  int format_length = strlen(format);
  for(int i = 0; i < format_length; i++)
    if(conf.source_path[path_length - format_length + i] != format[i])
      return 0;
  return 1;
}

File read_png() {
  File file;
  unsigned error = lodepng_decode32_file(&file.raster, &file.width, &file.height, conf.source_path);
  if(error) 
    stop(2, ERROR_READING_FILE);

  return file;
}

File read_tif() {
  int width, height;
  TIFF *tif = TIFFOpen(conf.source_path, "r");
  if(tif) {
    TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &width);
    TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &height);
 
    if((width > 0) && (height > 0)) {
      uint32 *raster = (uint32*) _TIFFmalloc(width * height * sizeof (uint32));
      if (raster) { 
        if (TIFFReadRGBAImage(tif, width, height, raster, 0)) {
          File file = create_empty_file(height, width);
          for(int y = 0; y < height; y++) {
            for(int x = 0; x < width; x++) { 
              int j = get_index(file, x, y);
              int i = (height - y - 1) * width + x;
              file.raster[j] = (char) TIFFGetR(raster[i]);
              file.raster[j+1] = (char) TIFFGetG(raster[i]);
              file.raster[j+2] = (char) TIFFGetB(raster[i]);
              file.raster[j+3] = (char) TIFFGetA(raster[i]);
            }
          } 
          TIFFClose(tif);
          return file;
        }
      }
    }
  }
  stop(2, ERROR_READING_FILE);
}

File rotate180(File file) {
  if(!is_upside_down(file))
    return file;

  File rotated_180_file = create_empty_file(file.height, file.width);
  int j, size = file.height * file.width;
  for(int i = 0; i < size; i++) {
    j = size - 1 - i;
    rotated_180_file.raster[4*j] = file.raster[4*i];
    rotated_180_file.raster[4*j + 1] = file.raster[4*i + 1];
    rotated_180_file.raster[4*j + 2] = file.raster[4*i + 2];
    rotated_180_file.raster[4*j + 3] = file.raster[4*i + 3];
  }
  free(file.raster);
  return rotated_180_file;
}

File rotate(File file) {
  double tg = get_tangent(file);
  if(tg == 0)
    return file;

  double tg2 = tg*tg;
  double s = sqrt((tg2)/(1.0 + tg2));
  if(tg < 0)
    s = -s;
  double c = sqrt(1.0/(1.0 + tg2));

  File rotated_file = create_empty_file(file.height, file.width);
  for(int x = 0; x < file.width; x++) {
    for(int y = 0; y < file.height; y++) {
      int new_x = floor(c*x - s*y);
      int new_y = floor(s*x + c*y);
      copy_pixel(&file, x, y, &rotated_file, new_x, new_y);
    }
  }
  free(file.raster);
  return rotated_file;
}

File move(File file) {
  Pixel pivot = get_pivot(file);
  int delta_x = conf.pivot_default_x - pivot.x;
  int delta_y = conf.pivot_default_y - pivot.y;

  if(delta_x == 0 && delta_y == 0)
    return file;

  File moved_file = create_empty_file(conf.default_card_height, conf.default_card_width);
  for(int x = 0; x < file.width; x++) {
    for(int y = 0; y < file.height; y++) {
      int new_x = x + delta_x;
      int new_y = y + delta_y;
      copy_pixel(&file, x, y, &moved_file, new_x, new_y);
    }
  }
  free(file.raster);
  return moved_file;
}

File create_empty_file(int height, int width) {
  File file;
  file.height = height;
  file.width = width;
  file.raster = (unsigned char*) malloc(4 * height * width * sizeof(unsigned char));

  for(int i = 0; i < 4 * height * width; i++) 
    file.raster[i] = 255;

  return file;
}

void copy_pixel(File *from, int from_x, int from_y, File *to, int to_x, int to_y) {
  if(is_in_file(*to, to_x, to_y)) {
    int from_index = get_index(*from, from_x, from_y);
    int to_index = get_index(*to, to_x, to_y);

    to->raster[to_index] = from->raster[from_index];
    to->raster[to_index + 1] = from->raster[from_index + 1];
    to->raster[to_index + 2] = from->raster[from_index + 2];
    to->raster[to_index + 3] = from->raster[from_index + 3];
  }
}  

void write_png(File *file) {
  file->raster[get_index(*file, conf.pivot_default_x, conf.pivot_default_y)] = 255;
  file->raster[get_index(*file, conf.pivot_default_x, conf.pivot_default_y) + 1] = 255;
  unsigned error = lodepng_encode32_file(conf.destination_path, file->raster, file->width, file->height);
  if(error) 
    stop(3, ERROR_WRITING_FILE);
  
  free(file->raster);
}

int is_upside_down(File file) {
  for(int x = file.width - 1; x >= file.width/4; x--)
    if(get_column_density(file, x) > 0.4)
      return 1;
  return 0;
}

double get_tangent(File file) {
  int *xx = (int*) malloc(file.height * sizeof(int));
  int *yy = (int*) malloc(file.height * sizeof(int));
  int size = 0, x, y, counter;
  double average = 0;
  for(y = 0; y < file.height; y++) {
    x = 0;
    while(is_in_file(file, x, y) && !is_pixel_filled(file, x, y))
      x++;
    counter = 0;
    while(is_in_file(file, x, y) && is_pixel_filled(file, x + counter, y))
      counter++;
    if(counter > 50) {
      xx[size] = x + counter;
      yy[size] = y;
      average += xx[size];
      size++;
    }
  }
  average = average/size;
  
  int discarded = 0;
  double SUMx = 0, SUMy = 0, SUMxy = 0, SUMxx = 0;
  for(int i = 0; i < size; i++) {
    if(xx[i] > average - 40 && xx[i] < average + 40) {
      SUMx = SUMx + xx[i];
      SUMy = SUMy + yy[i];
      SUMxy = SUMxy + xx[i]*yy[i];
      SUMxx = SUMxx + xx[i]*xx[i];
    } 
    else
      discarded++;  
  }
  free(xx);
  free(yy);

  return (double)(SUMx*SUMx - (size-discarded)*SUMxx) / (double)(SUMx*SUMy - (size-discarded)*SUMxy);
}

Pixel get_pivot(File file) {
  Pixel pivot;
  double density, max_density = 0;
  int target_x = -1, target_xx = -1; 
  for(int x = 0; x < file.width && target_xx < 0; x++) {
    if(target_x < 0) {
      if(get_column_density(file, x) > 0.4)
        target_x = x; 
    }
    else {
      if (get_column_density(file, x) < 0.4)
        target_xx = x;
    }
  }
  target_x = (target_x + target_xx)/2;

  for(int y = 0; y < file.height/2; y++) {
    if(is_pixel_filled(file, target_x, y) && is_in_mark(file, target_x, y)) {
      while(is_pixel_filled(file, target_x, y))
        target_x++;
      pivot.x = target_x--;
      pivot.y = y;
      return pivot;
    }
  }
  stop(4, PIVOT_NOT_FOUND);
}

int is_in_mark(File file, int x, int y) {
  int min_x, max_x, max_y = y;
  while(is_pixel_filled(file, x, max_y)) {
    min_x = x;
    while(is_pixel_filled(file, min_x, y))
      min_x--;
    min_x++;

    max_x = x;
    while(is_pixel_filled(file, max_x, y))
      max_x++;
    max_x--;

    if(!is_approximately(max_x-min_x, conf.mark_width)) {
      if(max_y == y)
        return 0;
      break;
    }

    max_y++;
  }
  if(is_approximately(max_y - y, conf.mark_height))
    return 1;
  return 0;
}

double get_column_density(File file, int x) {
  int match = 0;
  for(int y = 0; y < file.height; y++) 
    if(is_pixel_filled(file, x, y))
        match++;
  return (double)match / (double)file.height;
}


void process_file(File *file) {
  file->number_of_questions = 0;

  process_zone(file, conf.student_zone);
  process_zone(file, conf.questions_zone);
}

void process_zone(File *file, Zone zone) {
  for(int group_number = 0; group_number < zone.number_of_groups; group_number++) {
    for(int question_number = 0; question_number < zone.questions_per_group; question_number++)
      process_question(file, zone, group_number, question_number);
  }
}

void process_question(File *file, Zone zone, int group_number, int question_number) {
  char answer = 'Z';

  for(int option_number = 0; option_number < strlen(zone.alternatives); option_number++) {
    int start_x = zone.group_x + 
      option_number * (zone.option_width + zone.horizontal_space_between_options) + 
      group_number * zone.space_between_groups;
    int start_y = zone.group_y + 
      question_number * (zone.option_height + zone.vertical_space_between_options);
    int width = zone.option_width;
    int height = zone.option_height;

    if(process_option(*file, start_x, start_y, width, height) > conf.threshold) {
      if(answer == 'Z')
          answer = zone.alternatives[option_number];
      else
          answer = 'W';
    }
  }

  file->answers[file->number_of_questions] = answer;
  file->number_of_questions++;
}

double process_option(File file, int start_x, int start_y, int width, int height) {
  int match = 0;

  for(int y = start_y; y < height + start_y; y++)
    for(int x = start_x; x < width + start_x; x++)
      if(is_pixel_filled(file, x, y))
        match++;

  return (double)match / (double)(width*height);
}

void print_answers(File file) {
  for(int i = 0; i < file.number_of_questions; i++)
    printf("%c", file.answers[i]);
}

void stop(int code, const char* message) {
  printf("%s", message);
  exit(code);
}