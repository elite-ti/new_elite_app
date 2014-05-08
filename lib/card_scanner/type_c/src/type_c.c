#include "lodepng.h"
#include <tiffio.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

#define ERROR 0.7
#define DEBUG // Comment out if not debug version
// #define MAP_PERCENTAGE

#define WRONG_NUMBER_OF_ARGUMENTS "Error: wrong number of arguments."
#define ERROR_READING_FILE "Error: could not read file."
#define ERROR_WRITING_FILE "Error: could not write png."
#define MARK_NOT_FOUND "Could not find all marks."

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
  Zone exam_zone;
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

File locate_marks(File);
int find_mark(File, int, int, double);

File rotate180(File);
int is_upside_down(File);

File rotate(File);
File create_whites_file(File);
File rotate_again(File);
double get_tangent(File);
double get_tangent2(File);
int test_rotation(File);
int test_rotation2(File);

File move(File);
File fine_move(File);

File interpolate(File);

// File stretch(File);
int get_clock_locations(File file);

void process_file(File *);
void process_zone(File *, Zone, int);
void process_question(File *, Zone, int, int, int);
double process_option(File, int, int, int, int);

void print_answers(File);
void write_png(File *);

File create_empty_file(int, int);
void copy_pixel(File *, int, int, File *, int, int);
double get_column_density(File, int);
double get_line_density(File, int, int, int);
double get_segment_density(File, int, int, int);
void set_pixel_to_red(File, int, int);
void paint_pixel(File, int, int, int, int, int);
int adjust_configuration(File);

Configuration conf;
int mark_position_x[2][2];
int mark_position_y[2][2];
int mark_radius[2][2];
int *clock_locations;
int use_customized_clocks;

int main(int argc, char* argv[]) {
  read_configuration(argc, argv);

  File file = read_file();

  file = locate_marks(file);

  File rotated_180_file = rotate180(file);

  // File blank_file = create_whites_file(file);
  // write_png(&blank_file);
  // return 0;

  File rotated_file = rotate(rotated_180_file);

  File moved_file = move(rotated_file);

  File intepolated_file = interpolate(moved_file);

  // write_png(&intepolated_file);
  File intepolated_file2 = fine_move(intepolated_file);
  // File intepolated_file2 = stretch(intepolated_file1);

  get_clock_locations(intepolated_file2);
  process_file(&intepolated_file2);
  print_answers(intepolated_file2);
  write_png(&intepolated_file2);
  free(intepolated_file2.raster);

  return 0;
}

void read_configuration(int argc, char* argv[]) {
  // TODO: hard code this paremeters
  // 0.4 60 540 80 40 1284 4847 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3454
  use_customized_clocks = 0;

  if(argc != 40) 
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

  // Student Zone
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

  // Questions Zone
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

  // Exam Zone
  sscanf(argv[30], "%d", &conf.exam_zone.number_of_groups);
  sscanf(argv[31], "%d", &conf.exam_zone.space_between_groups);
  sscanf(argv[32], "%d", &conf.exam_zone.questions_per_group);
  strcpy(conf.exam_zone.alternatives, argv[33]);
  sscanf(argv[34], "%d", &conf.exam_zone.option_width);
  sscanf(argv[35], "%d", &conf.exam_zone.option_height);
  sscanf(argv[36], "%d", &conf.exam_zone.group_x);
  sscanf(argv[37], "%d", &conf.exam_zone.group_y);

  number_of_options = strlen(conf.exam_zone.alternatives);
  sscanf(argv[38], "%d", &horizontal_group_size);
  conf.exam_zone.horizontal_space_between_options = 
    (double)(horizontal_group_size - conf.exam_zone.option_width*number_of_options)/
    (double)(number_of_options - 1);

  number_of_questions = conf.exam_zone.questions_per_group;
  sscanf(argv[39], "%d", &vertical_group_size);
  conf.exam_zone.vertical_space_between_options = 
    (double)(vertical_group_size - conf.exam_zone.option_height*number_of_questions)/
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
  {
    for (int coord_x = 0; coord_x <= 1; ++coord_x)
      for (int coord_y = 0; coord_y <= 1; ++coord_y)
        for (int i = -5; i <= 5; ++i)
          for (int j = -5; j <= 5; ++j)
            if(mark_position_x[coord_x][coord_y] + i > 0 && mark_position_x[coord_x][coord_y] + i < file.width && mark_position_y[coord_x][coord_y] + j > 0 && mark_position_y[coord_x][coord_y] + j < file.height)
              paint_pixel(file, mark_position_x[coord_x][coord_y] + i, mark_position_y[coord_x][coord_y] + j, 0, 0, 255);    
    return file;    
  }

  // Change mark positions
  int buffer;
  buffer = mark_position_x[0][0];
  mark_position_x[0][0] = file.width - mark_position_x[1][1];
  mark_position_x[1][1] = file.width - buffer;
  buffer = mark_position_x[1][0];
  mark_position_x[1][0] = file.width - mark_position_x[0][1];
  mark_position_x[0][1] = file.width - buffer;
  buffer = mark_position_y[0][0];
  mark_position_y[0][0] = file.height - mark_position_y[1][1];
  mark_position_y[1][1] = file.height - buffer;
  buffer = mark_position_y[1][0];
  mark_position_y[1][0] = file.height - mark_position_y[0][1];
  mark_position_y[0][1] = file.height - buffer;
  buffer = mark_radius[0][0];
  mark_radius[0][0] = mark_radius[1][1];
  mark_radius[1][1] = buffer;
  buffer = mark_radius[0][1];
  mark_radius[0][1] = mark_radius[1][0];
  mark_radius[1][0] = buffer;

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

  for (int coord_x = 0; coord_x <= 1; ++coord_x)
    for (int coord_y = 0; coord_y <= 1; ++coord_y)
      for (int i = -5; i <= 5; ++i)
        for (int j = -5; j <= 5; ++j)
          if(mark_position_x[coord_x][coord_y] + i > 0 && mark_position_x[coord_x][coord_y] + i < file.width && mark_position_y[coord_x][coord_y] + j > 0 && mark_position_y[coord_x][coord_y] + j < file.height)
            paint_pixel(rotated_180_file, mark_position_x[coord_x][coord_y] + i, mark_position_y[coord_x][coord_y] + j, 0, 0, 255);

  return rotated_180_file;
}

File locate_marks(File file) {
  for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 2; ++j)
    {
      mark_position_x[i][j] = 0;
      mark_position_y[i][j] = 0;
      mark_radius[i][j] = 0;
    }

  int number_of_marks = 0;
  number_of_marks += find_mark(file, 0, 0, 0.7);
  number_of_marks += find_mark(file, 0, 1, 0.7);
  number_of_marks += find_mark(file, 1, 1, 0.7);

  if(number_of_marks < 3)
    number_of_marks += find_mark(file, 1, 0, 0.7);

  if(number_of_marks < 3)
  {
    for (int i = 0; i < 2; ++i)
      for (int j = 0; j < 2; ++j)
      {
        mark_position_x[i][j] = 0;
        mark_position_y[i][j] = 0;
        mark_radius[i][j] = 0;
      }
    number_of_marks = 0;
    number_of_marks += find_mark(file, 0, 0, 0.5);
    number_of_marks += find_mark(file, 0, 1, 0.5);
    number_of_marks += find_mark(file, 1, 0, 0.5);
    number_of_marks += find_mark(file, 1, 1, 0.5);

    #ifdef DEBUG
      printf("nMarks: %d\n", number_of_marks);
    #endif
    if(number_of_marks != 3)
      stop(3, MARK_NOT_FOUND);
  }

  #ifdef DEBUG
    // if(mark_position_x[1][0] == 0 && mark_position_y[1][0] == 0)
    // {
    //   int radius = 110;
    //   int x = mark_position_x[0][0] + mark_position_x[1][1] - mark_position_x[0][1];
    //   int y = mark_position_y[0][0] + mark_position_y[1][1] - mark_position_y[0][1];
    //   for(int i = 0; i < radius; i++)
    //     paint_pixel(file, x + i, y, 0, 0, 255);
    //   for(int i = 0; i <= radius; i++)
    //     paint_pixel(file, x + i, y + radius, 0, 0, 255);
    //   for(int i = 0; i < radius; i++)
    //     paint_pixel(file, x, y + i, 0, 0, 255);
    //   for(int i = 0; i < radius; i++)
    //     paint_pixel(file, x + radius, y + i, 0, 0, 255);      
    // }
    printf("mark00: %d %d\n", mark_position_x[0][0], mark_position_y[0][0]);
    printf("mark01: %d %d\n", mark_position_x[0][1], mark_position_y[0][1]);
    printf("mark10: %d %d\n", mark_position_x[1][0], mark_position_y[1][0]);
    printf("mark11: %d %d\n", mark_position_x[1][1], mark_position_y[1][1]);
  #endif

  return file;
}

int find_mark(File file, int coord_x, int coord_y, double mark_threshold) {
  int signal_x = coord_x ? -1 : 1;
  int signal_y = coord_y ? -1 : 1;
  int start_x = coord_x ? file.width : 0;
  int start_y = coord_y ? file.height : 0;

  int break_flag = 0;
  for(int sum = 0; sum < 1100 && !break_flag; sum++)
    for(int x = 1; x < sum && !break_flag; x++)
    {
      if(is_pixel_filled(file, start_x + signal_x * x, start_y + signal_y * (sum - x)))
      {
        int radius = 0;
        int pixels_filled = 1;
        do
        {
          radius++;
          pixels_filled = 0;
          for(int i = 0; i <= radius; i++)
            if(is_pixel_filled(file, start_x + signal_x * (x + radius), start_y + signal_y * (sum - x + i)))
              pixels_filled++;
          for(int i = 0; i < radius; i++)
            if(is_pixel_filled(file, start_x + signal_x * (x + i), start_y + signal_y * (sum - x + radius)))
              pixels_filled++;
        }while(((double) pixels_filled) > mark_threshold * ((double) 2 * radius - 1) && radius < 180);

        if(radius > 90)
        {
          mark_position_x[coord_x][coord_y] = start_x + signal_x * (x + radius/2);
          mark_position_y[coord_x][coord_y] = start_y + signal_y * (sum - x + radius/2);
          mark_radius[coord_x][coord_y] = radius;
          for (int i = -5; i <= 5; ++i)
            for (int j = -5; j <= 5; ++j)
              paint_pixel(file, mark_position_x[coord_x][coord_y] + i, mark_position_y[coord_x][coord_y] + j, 0, 0, 255);
          for(int i = 0; i < radius; i++)
            paint_pixel(file, start_x + signal_x * (x + i), start_y + signal_y * (sum - x), 0, 0, 255);
          for(int i = 0; i <= radius; i++)
            paint_pixel(file, start_x + signal_x * (x + i), start_y + signal_y * (sum - x + radius), 0, 0, 255);
          for(int i = 0; i < radius; i++)
            paint_pixel(file, start_x + signal_x * x, start_y + signal_y * (sum - x + i), 0, 0, 255);
          for(int i = 0; i < radius; i++)
            paint_pixel(file, start_x + signal_x * (x + radius), start_y + signal_y * (sum - x + i), 0, 0, 255);
          paint_pixel(file, start_x + signal_x * x, start_y + signal_y * (sum - x), 0, 255, 0);
          break_flag = 1;
          return 1;
          break;
        }
      }
    }
  return 0;
}


File rotate(File file) {
  if(test_rotation(file) == 1) return file;

  double tg = get_tangent(file);
  if(tg == 0)
    return file;

  double tg2 = tg*tg;
  double s = sqrt((tg2)/(1.0 + tg2));
  if(tg < 0)
    s = -s;
  double c = sqrt(1.0/(1.0 + tg2));

  // DEBUG: paint green tangent
  #ifdef DEBUG
    printf("tg: %f\n", tg);
    printf("s: %f\n", s);
    printf("c: %f\n", c);
    for (int y = 0; y < file.height; ++y){
      // printf("%d %d\n", (int) floor(tg*y), y);
      paint_pixel(file, 100 + floor(tg*y), y, 0, 255, 0);
    }
  #endif

  File rotated_file = create_empty_file(file.height, file.width);
  for(int x = 0; x < file.width; x++) {
    for(int y = 0; y < file.height; y++) {
      if(is_pixel_filled(file,x,y))
      {
        int new_x = floor(c*x - s*y);
        int new_y = floor(s*x + c*y);
        copy_pixel(&file, x, y, &rotated_file, new_x, new_y);
      }
    }
  }
  free(file.raster);
  return rotated_file;
}

File move(File file) {
  int delta_x = mark_position_x[0][0];
  int delta_y = mark_position_y[0][0];

  int calculated_card_width = mark_position_x[1][1] - mark_position_x[0][0];
  int calculated_card_height = mark_position_y[0][1] - mark_position_y[0][0];

  if(delta_x == 0 && delta_y == 0)
    return file;

  File moved_file = create_empty_file(calculated_card_height, calculated_card_width);
  for(int x = 0; x < calculated_card_width - 1; x++) {
    for(int y = 0; y < calculated_card_height - 1; y++) {
      int old_x = x + delta_x;
      int old_y = y + delta_y;
      copy_pixel(&file, old_x, old_y, &moved_file, x, y);
    }
  }
  free(file.raster);
  return moved_file;
}

File fine_move(File file) {
  int start_y = ceil(
    (double) conf.student_zone.group_y + 
    conf.student_zone.questions_per_group * 
      (conf.student_zone.option_height + 
      conf.student_zone.vertical_space_between_options)
    ) + conf.student_zone.option_height;
  int found_y = 0;
  for (int i = 0; i < 200; ++i){
    double density = get_line_density(file, 0, file.width - 1, start_y + i);
    if(found_y == 0 && density > 0.05){
      for (int j = 0; j < file.width; ++j)
        paint_pixel(file, j, start_y + i, 0, 255, 0);
      found_y = start_y + i;
      break;
    }
  }

  int start_x = (double) conf.questions_zone.group_x - 100;

  #ifdef DEBUG 
  for (int i = -250; i < 150; ++i){
    double density = get_segment_density(file, start_x + i, found_y, file.height - 380);
    if(density > 0.3){
      for (int j = 4000; j < file.height; ++j)
        paint_pixel(file, start_x + i, j, 255, 0, 255);      
    } else if(density > 0.2){
      for (int j = 4000; j < file.height; ++j)
        paint_pixel(file, start_x + i, j, 255, 255, 0);
    } else if(density > 0.1){
      for (int j = 4000; j < file.height; ++j)
        paint_pixel(file, start_x + i, j, 0, 255, 255);
    }

  }  
  #endif

  // Apply Smooth Method MAX-MIN
  double densities[file.width - start_x + 150];
  for (int i = 0; i < file.width - start_x + 150; ++i)
    densities[i] = get_segment_density(file, start_x + i - 150, found_y, file.height - 380);

  double min_densities[file.width - start_x + 150];
  double temp;
  for (int i = 0; i < file.width - start_x + 150; ++i){
    temp = 1000;
    for (int j = i - 25; j <= i + 25; ++j){
      if(j >= 0 && j < file.width - start_x + 150 && densities[j] < temp)
        temp = densities[j];
    }
    min_densities[i] = temp;
  }

  double max_min_densities[file.width - start_x + 150];
  for (int i = 0; i < file.width - start_x + 150; ++i){
    temp = -1;
    for (int j = i - 25; j <= i + 25; ++j){
      if(j >= 0 && j < file.width - start_x + 150 && min_densities[j] > temp)
        temp = min_densities[j];
    }
    max_min_densities[i] = temp;
  }

  // printf("|||");
  // for (int i = 0; i < file.width - start_x + 150; ++i)
  //   printf("%g,", max_min_densities[i]);  
  // printf("|||");

  for (int i = 1; i < file.width - start_x + 150; ++i){
    // printf("%g,", max_min_densities[i] - max_min_densities[i-1]);
    if(fabs(max_min_densities[i] - max_min_densities[i-1]) > 0.04){
      i = i + 5;
      // printf("%g,", max_min_densities[i] - max_min_densities[i-1]);
      // for (int j = 0; j < file.height; ++j)
      //   paint_pixel(file, start_x - 150 + i, j, 255, 0, 0);      
    }
  }

  int found_x = -2;
  int count = 0;

  for (int i = -250; i < 150; ++i){
    double density = get_segment_density(file, start_x + i, found_y, file.height - 380);

    if(density > 0.2){
      int misses = 0; // count blank lines
      for (int delta_x = 1; delta_x < 40; ++delta_x){
        if(get_segment_density(file, start_x + i + delta_x, found_y, file.height - 380) < 0.1)
          misses += 1;
      }
      if(misses < 10){
        found_x = start_x + i + 77;
        #ifdef DEBUG 
        for (int j = 0; j < file.height; ++j)
          paint_pixel(file, found_x, j, 0, 255, 0);
        #endif
        break;
      }
    }
  }

  int delta_y = found_y == 0 ? 0 : conf.questions_zone.group_y - found_y;
  int delta_x = found_x == 0 ? 0 : conf.questions_zone.group_x - found_x;
  
  if(delta_y == 0 && delta_x == 0 )
    return file;

  File moved_file = create_empty_file(file.height, file.width);
  for(int x = 0; x < file.width - 1; x++) {
    for(int y = 0; y < file.height - 1; y++) {
      int new_x = x + delta_x;
      int new_y = y + delta_y;
      copy_pixel(&file, x, y, &moved_file, new_x, new_y);
    }
  }
  free(file.raster);
  return moved_file;
}

File interpolate(File file) {
  int difference_card_width = abs(file.width - conf.default_card_width);
  int difference_card_height = abs(file.height - conf.default_card_height);

  if(difference_card_width + difference_card_height < 5)
    return file;

  File interpolated_file = create_empty_file(conf.default_card_height, conf.default_card_width);
  for(int x = 0; x < conf.default_card_width - 1; x++) {
    for(int y = 0; y < conf.default_card_height - 1; y++) {
      int new_x = abs(((double)x * file.width) / (double) conf.default_card_width);
      int new_y = abs(((double)y * file.height) / (double) conf.default_card_height);
      copy_pixel(&file, new_x, new_y, &interpolated_file, x, y);
    }
  }
  free(file.raster);
  return interpolated_file;
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
  unsigned error = lodepng_encode32_file(conf.destination_path, file->raster, file->width, file->height);
  if(error) 
    stop(3, ERROR_WRITING_FILE);
  
}

int is_upside_down(File file) {
  if(mark_position_x[0][1] == 0 && mark_position_y[0][1] == 0)
  {
    // mark_position_x[0][1] == 0
    // mark_position_y[0][1] == 0
    return 1;
  }
  else
    return 0;
}

void paint_big_pixel(File file, int x, int y, int R, int G, int B, int radius) {
  for (int temp_x = x-radius; temp_x < x + radius; ++temp_x)
  {
    for (int temp_y = y - radius; temp_y < y + radius; ++temp_y)
    {
      paint_pixel(file, temp_x, temp_y, R, G, B);
    }
  }
}

double get_tangent(File file) {
  // Method using 
  int SUMxx = mark_position_x[0][1] + mark_radius[0][1] - (mark_position_x[0][0] + mark_radius[0][0]);
  int SUMxy = mark_position_y[0][1] - mark_radius[0][1] - (mark_position_y[0][0] + mark_radius[0][0]);
  double tg_real = ((double)SUMxx/(double)SUMxy);

  // More precise method
  // 100 = error margin
  // 175 = mark center position (we are before crop)
  int start_x = conf.questions_zone.group_x + 
      (conf.questions_zone.number_of_groups - 1) * conf.questions_zone.space_between_groups +
      strlen(conf.questions_zone.alternatives) * (conf.questions_zone.option_width + conf.questions_zone.horizontal_space_between_options) + 175 + 100;

  int start_y = conf.questions_zone.group_y + 175 + 100;

  // printf("|||");
  // printf("%d|", start_x);
  // printf("%d|", start_y);

  // int size = 0;
  // int border[size];
  // int i, j;
  // printf("|%d|||", file.width);
  // for (j = start_y; j < start_y + size; j++){
  //   for (i = file.width - 1000; i > file.width - 1200; i--){
  //     if (is_pixel_filled(file, i, j))
  //       printf("%d,%d|", i, j);
  //       break;
  //   }
  //   border[j - found_y - 100] = i;
  // }
  // printf("|||");
  // printf("|||");  



  // int border[file.height - found_y - 100];
  // int i, j;
  // printf("|%d|||", file.width);
  // for (j = found_y + 100; j < file.height; j++){
  //   for (i = file.width - 1000; i > file.width - 1200; i--){
  //     if (is_pixel_filled(file, i, j))
  //       printf("%d,%d|", i, j);
  //       break;
  //   }
  //   border[j - found_y - 100] = i;
  // }
  // printf("|||");

  // for (int i = 0; i < file.height - found_y - 100; ++i)
  //   printf("%g,", border[i]);

  return tg_real;
  // return 0.010732791;
}

double get_line_density(File file, int start_x, int end_x, int y) {
  int match = 0;
  for(int x = start_x; x < end_x; x++) 
    if(is_pixel_filled(file, x, y))
        match++;
  return (double)match / (double)(end_x - start_x);
}

// double get_column_density(File file, int x, int start_y, int end_y) {
double get_column_density(File file, int x) {
  int match = 0;
  int count = 0;
  // for(int y = start_y; y < file.height && y < end_y; y++) {
  for(int y = 0; y < file.height; y++) {
    if(is_pixel_filled(file, x, y))
        match++;
      count++;
  }
  return (double)match / (double)count;
}

double get_segment_density(File file, int x, int start_y, int end_y) { 
  int match = 0; 
  int count = 0; 
  // for(int y = start_y; y < file.height && y < end_y; y++) { 
  for(int y = start_y; y < end_y; y++) { 
    if(is_pixel_filled(file, x, y)) 
        match++; 
      count++; 
  } 
  return (double)match / (double)count; 
} 


// File stretch(File file) {
//   int success = get_clock_locations(file);

//   if(!success)
//     return file;

//   File stretched_file = create_empty_file(conf.default_card_height, conf.default_card_width);

//   int height1 = conf.student_zone.group_y+1;
//   int height2 = height1 + conf.student_zone.questions_per_group*conf.student_zone.option_height + conf.student_zone.vertical_space_between_options*(conf.student_zone.questions_per_group-1);
//   int height3 = conf.questions_zone.group_y;
//   int height4 = height3 + conf.questions_zone.questions_per_group*conf.questions_zone.option_height + (int)conf.questions_zone.vertical_space_between_options*(conf.questions_zone.questions_per_group-1);
//   printf("h1:%d|h2:%d|h3:%d|h4:%d\n", height1, height2, height3, height4);
  
//   int original_y, blank = 0;
//   for(int y = 0; y < stretched_file.height; y++) {
//     for(int x = 0; x < stretched_file.width; x++) {
//       if(x==0){
//         if(y < height2 + 10){
//           blank = 0;
//           original_y = y;//round(((double)clock_locations[0]/(double)height1)*(double)y);
//         }
//         else if(y < height3 - 10)
//         {
//           blank = 1;
//         }
//         else if(y < height4)
//         {
//           blank = 0;
//           int n1 = (y-height3)/((int)conf.questions_zone.option_height+(int)conf.questions_zone.vertical_space_between_options);
//           int d1 = y - height3 - n1*((int)conf.questions_zone.option_height+(int)conf.questions_zone.vertical_space_between_options);
//           int n2 = d1 >= conf.questions_zone.option_height ? 1 : 0;
//           d1 = (n2 == 1) ? (d1 - conf.questions_zone.option_height) : d1;
//           int n = 2*n1 + n2;

//           original_y = clock_locations[n]+round((double)d1*(double)(clock_locations[n+1]-clock_locations[n])/(double)(n2==1 ? (int)conf.questions_zone.vertical_space_between_options : conf.questions_zone.option_height));
//         }
//         else
//         {
//           blank = 0;
//           original_y++;
//         }
//       }
//       if(original_y<file.height && x<file.width && !blank && is_pixel_filled(file, x, original_y))
//         copy_pixel(&file, x, original_y, &stretched_file, x, y);
//     }
//   }

//   free(file.raster);
//   return stretched_file;
// }

int get_clock_locations(File file) {
  int status = 0; // 0: outside, 1: inside
  int index = 0;
  int *temporary_clock_locations = (int*)malloc(2*conf.questions_zone.questions_per_group*sizeof(int));
  int group_end_y = conf.questions_zone.group_y + conf.questions_zone.questions_per_group * (conf.questions_zone.vertical_space_between_options + conf.questions_zone.option_height) - conf.questions_zone.vertical_space_between_options;
  int tolerance = 0;
  for (int i = conf.questions_zone.group_y + 1; i < group_end_y + 100; ++i){
    double density = get_line_density(file, conf.questions_zone.group_x - 80, conf.questions_zone.group_x - 30, i);
    if(status == 0 && density > 0.05){
      #ifdef DEBUG
      for (int j = conf.questions_zone.group_x - 85; j < conf.questions_zone.group_x - 30; ++j)
        paint_pixel(file, j, i, 0, 0, 255);
      #endif
      status = 1;
      temporary_clock_locations[index] = i - 3;
      index++;
    }
    if(status == 1 && density < 0.05){
      if(tolerance < 5)
      {
        #ifdef DEBUG
        for (int j = conf.questions_zone.group_x - 85; j < conf.questions_zone.group_x - 30; ++j)
          paint_pixel(file, j, i - 1, 255, 0, 255);
        #endif
        tolerance++;
      }
      else
      {
        tolerance = 0;
        #ifdef DEBUG
        for (int j = conf.questions_zone.group_x - 85; j < conf.questions_zone.group_x - 30; ++j)
          paint_pixel(file, j, i - 4, 0, 0, 255);
        #endif
        status = 0;
        temporary_clock_locations[index] = i - 4;
        index++;
      }
    }
  }
  if(index == 2*conf.questions_zone.questions_per_group){
    clock_locations = temporary_clock_locations;
    use_customized_clocks = 1;
    return 1;
  } else{
    int number_of_questions = conf.questions_zone.questions_per_group;
    conf.questions_zone.vertical_space_between_options = 
      (double)((temporary_clock_locations[index - 1] - temporary_clock_locations[0]) - conf.questions_zone.option_height*number_of_questions)/
      (double)(number_of_questions - 1);

  }
  return 0;
}

void process_file(File *file) {
  file->number_of_questions = 0;

  process_zone(file, conf.student_zone, 0);
  process_zone(file, conf.exam_zone, 0);
  process_zone(file, conf.questions_zone, use_customized_clocks);
}

void process_zone(File *file, Zone zone, int customized_clocks) {
  for(int group_number = 0; group_number < zone.number_of_groups; group_number++) {
    for(int question_number = 0; question_number < zone.questions_per_group; question_number++)
      process_question(file, zone, group_number, question_number, customized_clocks);
  }
}

void process_question(File *file, Zone zone, int group_number, int question_number, int customized_clocks) {
  char answer = 'Z';
  double max_percentage= 0;
  int more_than_one = 0;  

  for(int option_number = 0; option_number < strlen(zone.alternatives); option_number++) {
    int start_x = ceil((double) zone.group_x + 
      option_number * (zone.option_width + zone.horizontal_space_between_options) + 
      group_number * zone.space_between_groups);
    int width = zone.option_width;
    int start_y;
    int height;
    if(customized_clocks){
      start_y = clock_locations[question_number*2];
      height = clock_locations[question_number*2 + 1] - clock_locations[question_number*2];
    }
    else{
      start_y = ceil((double) zone.group_y + 
        question_number * (zone.option_height + zone.vertical_space_between_options));
      height = zone.option_height;      
    }

    double percentage = process_option(*file, start_x, start_y, width, height);
    #ifdef MAP_PERCENTAGE
    printf("%d:%g|", option_number, percentage);
    #endif
    if(percentage > conf.threshold) {
      if(answer == 'Z'){
        answer = zone.alternatives[option_number];
        max_percentage = percentage;
      } else {
        if(!more_than_one && percentage - max_percentage > conf.threshold/2){
          answer = zone.alternatives[option_number]; // replace correct answer
          max_percentage = percentage;
          more_than_one = 1;
        } else if(!more_than_one && max_percentage - percentage > conf.threshold/2){
          // do nothing - the former was right
          more_than_one = 1;
        } else {
          answer = 'W';
          more_than_one = 1;
        }
      }
    }
  }

  file->answers[file->number_of_questions] = answer;
  file->number_of_questions++;
}

double process_option(File file, int start_x, int start_y, int width, int height) {
  int match = 0;
  start_x = start_x + 10;
  start_y = start_y + 5;
  width = width - 20;
  height = height - 10;


  for(int y = start_y; y < height + start_y; y++)
    for(int x = start_x; x < width + start_x; x++){
      if(is_pixel_filled(file, x, y))
        match++;
    }

  #ifdef DEBUG
    for(int y = start_y; y < height + start_y; y++) {
      paint_pixel(file, start_x, y, 255, 0, 0);
      paint_pixel(file, start_x + width, y, 255, 0, 0);
    }

    for(int x = start_x; x < width + start_x; x++) {
      paint_pixel(file, x, start_y, 255, 0, 0);
      paint_pixel(file, x, start_y + height, 255, 0, 0);
    }
  #endif

  return (double)match / (double)(width*height);
}

void set_pixel_to_red(File file, int x, int y) {
  file.raster[get_index(file, x, y)] = 255;
  file.raster[get_index(file, x, y) + 1] = 0;
  file.raster[get_index(file, x, y) + 2] = 0;
}

void print_answers(File file) {
  for(int i = 0; i < file.number_of_questions; i++)
  {
    // printf("Z");
    printf("%c", file.answers[i]);
  }
}

void stop(int code, const char* message) {
  printf("%s", message);
  exit(code);
}

//Código de prova real de rotação
int test_rotation(File file){
  if(abs(mark_position_x[0][0] - mark_position_x[0][1]) < 1)
    return 1;
  else
    return 0;
}

int get_division_between_zones(File file){
  int target_x = -1, target_xx = -1;
  int count;

  // Find start and end for clock in x
  for(int x = 0; x < file.width && target_xx < 0; x++) {
    if(target_x < 0) {
      if(get_column_density(file, x) > 0.3)
      {
        count = 1;
        while(x + count < file.width &&  get_column_density(file, x + count) > 0.3)
          count++;
        if(count > 40)
          target_x = x;
      }
    }
    else {
      if (get_column_density(file, x) < 0.3)
        target_xx = x;
    }
  }

  // Find pivot in y
  int y;
  for(y = 0; y < file.height; y++) {
    if(get_line_density(file, target_x, target_xx, y) > 0.7) {
      int matches = 0;
      for(int z = 0; z < 30; z++)
        if(get_line_density(file, target_x, target_xx, y + z) > 0.7)
          matches++;
      if(matches == 30)
        break;
    }
  }

  // Starting from pivot, search for blank of 45 lines
  int matches = 0, error = 0;
  for(; y < file.height; y++) {
    if(get_line_density(file, target_x, target_xx, y) < 0.2)
    {
      if(matches == 0) error = 0;
      matches++;
    }
    else
    {
      if(error == 3)
      { 
        matches = 0; 
        error = 0;
      }
      else
      {
        error++;
      }
    }
    // #ifdef DEBUG
    //   printf("matches: %d   error: %d\n", matches, error);
    // #endif
    if(matches == 45)
      return y - 44;
  }
}

void paint_pixel(File file, int x, int y, int R, int G, int B) {
  #ifdef DEBUG
  file.raster[(get_index(file, x, y))] = R;
  file.raster[(get_index(file, x, y)) + 1] = G;
  file.raster[(get_index(file, x, y)) + 2] = B;
  #endif
}
