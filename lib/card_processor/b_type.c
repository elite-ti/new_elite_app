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

#define PIVOT_DEFAULT_X 60
#define PIVOT_DEFAULT_Y 540
#define MARK_WIDTH 80
#define MARK_HEIGHT 40
#define DEFAULT_CARD_HEIGHT 4847
#define DEFAULT_CARD_WIDTH 1284


#define get_index(file, x, y) (((y) * (file).width + (x))*4)
#define is_in_file(file, x, y) ((x) >= 0 && (y) >= 0 && (x) < (file).width && (y) < (file).height)
#define is_pixel_filled(file, x, y) ((file).raster[(get_index((file), (x), (y)))] == 0)
#define is_approximately(a, b) ((float)(a) <= (float)((b)/ERROR) && (float)(a) >= (float)((b)*ERROR))


// TODO
// * remove struct configuration
// * load whole directory

typedef struct {
  int number_of_groups;
  int space_between_groups;
  int questions_per_group;
  char alternatives[20];
  int mark_width;
  int mark_height;
  int group_horizontal_position;
  int group_vertical_position;
  double horizontal_space_between_marks;
  double vertical_space_between_marks;
} Zone;

typedef struct {
  char source_path[200];
  char destination_path[200];

  int number_of_zones;
  double threshold;
  Zone zones[10];
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
  if(argc != 3) 
    stop(1, WRONG_NUMBER_OF_ARGUMENTS);
  
  strcpy(conf.source_path, argv[1]);
  strcpy(conf.destination_path, argv[2]);
  // char parameters[] = "0.4 2 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3454";

  conf.threshold = 0.4;
  conf.number_of_zones = 2;

  Zone zone1, zone2;
  int number_of_options, horizontal_group_size, number_of_questions, vertical_group_size;

  zone1.number_of_groups = 1;
  zone1.space_between_groups = 0;
  zone1.questions_per_group = 7;
  strcpy(zone1.alternatives, "0123456789");
  zone1.mark_width = 79;
  zone1.mark_height = 38;
  zone1.group_horizontal_position = 271;
  zone1.group_vertical_position = 540;

  number_of_options = strlen(zone1.alternatives);
  horizontal_group_size = 964;
  zone1.horizontal_space_between_marks = 
    (double)(horizontal_group_size - zone1.mark_width*number_of_options)/
    (double)(number_of_options - 1);

  number_of_questions = zone1.questions_per_group;
  vertical_group_size = 453;
  zone1.vertical_space_between_marks = 
    (double)(vertical_group_size - zone1.mark_height*number_of_questions)/
    (double)(number_of_questions - 1);

  conf.zones[0] = zone1;

  zone2.number_of_groups = 2;
  zone2.space_between_groups = 600;
  zone2.questions_per_group = 50;
  strcpy(zone2.alternatives, "ABCDE");
  zone2.mark_width = 77;
  zone2.mark_height = 38;
  zone2.group_horizontal_position = 170;
  zone2.group_vertical_position = 1054;

  number_of_options = strlen(zone2.alternatives);
  horizontal_group_size = 473;
  zone2.horizontal_space_between_marks = 
    (double)(horizontal_group_size - zone2.mark_width*number_of_options)/
    (double)(number_of_options - 1);

  number_of_questions = zone2.questions_per_group;
  vertical_group_size = 3454;
  zone2.vertical_space_between_marks = 
    (double)(vertical_group_size - zone2.mark_height*number_of_questions)/
    (double)(number_of_questions - 1);

  conf.zones[1] = zone2;
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
  int delta_x = PIVOT_DEFAULT_X - pivot.x;
  int delta_y = PIVOT_DEFAULT_Y - pivot.y;

  if(delta_x == 0 && delta_y == 0)
    return file;

  File moved_file = create_empty_file(DEFAULT_CARD_HEIGHT, DEFAULT_CARD_WIDTH);
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
  file->raster[get_index(*file, PIVOT_DEFAULT_X, PIVOT_DEFAULT_Y)] = 255;
  file->raster[get_index(*file, PIVOT_DEFAULT_X, PIVOT_DEFAULT_Y) + 1] = 255;
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

    if(!is_approximately(max_x-min_x, MARK_WIDTH)) {
      if(max_y == y)
        return 0;
      break;
    }

    max_y++;
  }
  if(is_approximately(max_y - y, MARK_HEIGHT))
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
  for(int zone_number = 0; zone_number < conf.number_of_zones; zone_number++) {
    Zone zone = conf.zones[zone_number];
    for(int group_number = 0; group_number < zone.number_of_groups; group_number++) {
      for(int question_number = 0; question_number < zone.questions_per_group; question_number++)
        process_question(file, zone, group_number, question_number);
    }
  }
}

void process_question(File *file, Zone zone, int group_number, int question_number) {
  char answer = 'Z';

  for(int option_number = 0; option_number < strlen(zone.alternatives); option_number++) {
    int start_x = zone.group_horizontal_position + 
      option_number * (zone.mark_width + zone.horizontal_space_between_marks) + 
      group_number * zone.space_between_groups;
    int start_y = zone.group_vertical_position + 
      question_number * (zone.mark_height + zone.vertical_space_between_marks);
    int width = zone.mark_width;
    int height = zone.mark_height;

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
