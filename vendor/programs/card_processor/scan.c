#include <stdio.h>
#include <string.h>
#include <tiffio.h>

typedef struct {
  int number_of_groups;
  int space_between_groups;
  int questions_per_group;
  char alternatives[20];
  int marks_horizontal_diameter;
  int marks_vertical_diameter;
  int group_horizontal_position;
  int group_vertical_position;
  double horizontal_space_between_marks;
  double vertical_space_between_marks;
} Zone;

typedef struct {
  char path[200];
  int number_of_zones;
  double threshold;
  Zone zones[10];
} Configuration;

typedef struct {
  int number_of_questions;
  char answers[200];

  uint32 *raster;
  int height;
  int width;
} File;

void ReadFile(File *);
void ProcessFile(File *);
void ProcessZone(File *, Zone);
void ProcessGroup(File *, Zone, int);
void ProcessQuestion(File *, Zone, int, int);
double ProcessOption(File, int, int, int, int);
int IsPixelFilled(File, int, int);
int FindRasterIndex(File, int, int);
void PrintAnswers(File);

Configuration conf;

int main(int argc, char* argv[])
{
  if(argc < 4) {
    perror("Wrong number of arguments!");
    return 1;
  }

  strcpy(conf.path, argv[1]);
  sscanf(argv[2], "%lf", &conf.threshold);
  sscanf(argv[3], "%i", &conf.number_of_zones);

  if(argc != (4 + conf.number_of_zones*10)) {
    perror("Wrong number of arguments!");
    return 1;
  }

  int zone_number;
  for(zone_number = 0; zone_number < conf.number_of_zones; zone_number++) {
    Zone zone;
    int i = 4 + 10*zone_number;
    sscanf(argv[i], "%i", &zone.number_of_groups);
    sscanf(argv[i+1], "%i", &zone.space_between_groups);
    sscanf(argv[i+2], "%i", &zone.questions_per_group);
    strcpy(zone.alternatives, argv[i+3]);
    sscanf(argv[i+4], "%i", &zone.marks_horizontal_diameter);
    sscanf(argv[i+5], "%i", &zone.marks_vertical_diameter);
    sscanf(argv[i+6], "%i", &zone.group_horizontal_position);
    sscanf(argv[i+7], "%i", &zone.group_vertical_position);

    int number_of_options = strlen(zone.alternatives);
    int horizontal_group_size;
    sscanf(argv[i+8], "%i", &horizontal_group_size);
    zone.horizontal_space_between_marks = 
      (double)(horizontal_group_size - zone.marks_horizontal_diameter*number_of_options)/
      (double)(number_of_options - 1);

    int number_of_questions = zone.questions_per_group;
    int vertical_group_size;
    sscanf(argv[i+9], "%i", &vertical_group_size);
    zone.vertical_space_between_marks = 
      (double)(vertical_group_size - zone.marks_vertical_diameter*number_of_questions)/
      (double)(number_of_questions - 1);

    conf.zones[zone_number] = zone;
  }

  File file;
  file.number_of_questions = 0;

  ReadFile(&file);
  ProcessFile(&file);
  PrintAnswers(file);

  return 0;    
}

void ReadFile(File *file) {
  TIFF* tif = TIFFOpen(conf.path, "r");
  if(tif) {
    TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &file->width);
    TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &file->height);
 
    if((file->width > 0) && (file->height > 0)) {
      uint32 *raster = (uint32*) _TIFFmalloc(file->width * file->height * sizeof (uint32));
      if (raster) { 
        if (TIFFReadRGBAImage(tif, file->width, file->height, raster, 0))
          file->raster = raster;
        else 
          perror("Couldn't open file.");
      }
      else 
        perror("Couldn't open file.");
    }
    else 
      perror("Couldn't open file.");
  }
  TIFFClose(tif);
}

void ProcessFile(File *file) {
  int zone_number;
  for(zone_number = 0; zone_number < conf.number_of_zones; zone_number++)
    ProcessZone(file, conf.zones[zone_number]);

  _TIFFfree(file->raster);
}

void ProcessZone(File *file, Zone zone) {
  int group_number;
  for(group_number = 0; group_number < zone.number_of_groups; group_number++)
    ProcessGroup(file, zone, group_number);
}

void ProcessGroup(File *file, Zone zone, int group_number)  {
  int question_number;
  for(question_number = 0; question_number < zone.questions_per_group; question_number++)
    ProcessQuestion(file, zone, group_number, question_number);
}

void ProcessQuestion(File *file, Zone zone, int group_number, int question_number) {
  char answer = 'Z';

  int option_number;
  for(option_number = 0; option_number < strlen(zone.alternatives); option_number++) {
    int start_x = zone.group_horizontal_position + 
      option_number * (zone.marks_horizontal_diameter + zone.horizontal_space_between_marks) + 
      group_number * zone.space_between_groups;
    int start_y = zone.group_vertical_position + 
      question_number * (zone.marks_vertical_diameter + zone.vertical_space_between_marks);
    int width = zone.marks_horizontal_diameter;
    int height = zone.marks_vertical_diameter;

    if(ProcessOption(*file, start_x, start_y, width, height) > conf.threshold) {
      if(answer == 'Z')
          answer = zone.alternatives[option_number];
      else
          answer = 'W';
    }
  }

  file->answers[file->number_of_questions] = answer;
  file->number_of_questions++;
}

double ProcessOption(File file, int start_x, int start_y, int width, int height) {
  int match = 0;

  int y;
  for(y = start_y; y <= height + start_y; y++) {
    int x;
    for(x = start_x; x <= width + start_x; x++) {
      if(IsPixelFilled(file, x, y))
        match++;
    }
  }

  return (double)match / (double)(width*height);
}

int IsPixelFilled(File file, int x, int y) {
  int i = FindRasterIndex(file, x, y);
  int a = (int) TIFFGetA(file.raster[i]);
  int r = (int) TIFFGetR(file.raster[i]);
  int g = (int) TIFFGetG(file.raster[i]);
  int b = (int) TIFFGetB(file.raster[i]);
  if(a == 255 && r + g + b == 0)
    return 1;
  else
    return 0;
}

int FindRasterIndex(File file, int x, int y) {
  return (file.height - y) * file.width + x;
}

void PrintAnswers(File file) {
  int i;
  for(i = 0; i < file.number_of_questions; i++)
    printf("%c", file.answers[i]);
}