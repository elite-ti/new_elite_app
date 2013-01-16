#include "lodepng.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <tiffio.h>
#include <math.h>

#define TIFF_WHITE_PIXEL 4294967295
#define DELTA_Y 3400
#define SHIFT_X 5
#define MINIMUM_DENSITY 0.1
#define ERROR 0.8

typedef struct {
  uint32 *raster;
  int height;
  int width;
  int size;
} File;

typedef struct {
  char path[200];
  char destination_path[200];
  int mark_width;
  int mark_height;
  double tg;
} Configuration;

File ReadFile();
double GetAngle(File);
void FindFirstPivot(File);
void FindSecondPivot(File);
double LineDensity(File file, int, int, int, int);
File Rotate(File);
File CreateEmptyFile(int, int);
void WritePng(File);
int FindRasterIndexTif(File, int, int);
int FindRasterIndexPng(File, int, int);
int IsInFile(File, int, int);
int IsPixelFilled(File, int, int);

Configuration conf;
int xx = 0, yy = 0, xxx = 0;

int main(int argc, char* argv[]) {
  if(argc != 5) {
    perror("Wrong number of arguments!");
    return 1;
  }
  strcpy(conf.path, argv[1]);
  strcpy(conf.destination_path, argv[2]);
  sscanf(argv[3], "%d", &conf.mark_width);
  sscanf(argv[4], "%d", &conf.mark_height);

  File file = ReadFile();
  conf.tg = GetAngle(file);
  File rotated_file = Rotate(file);
  WritePng(rotated_file);

  free(file.raster);
  free(rotated_file.raster);

  return 0;
}

File ReadFile() {
  File file;
  TIFF* tif = TIFFOpen(conf.path, "r");
  if(tif) {
    TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &file.width);
    TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &file.height);
 
    if((file.width > 0) && (file.height > 0)) {
      file.size = file.width * file.height;
      uint32 *raster = (uint32*) malloc(file.size * sizeof(uint32));
      if (raster) { 
        if (TIFFReadRGBAImage(tif, file.width, file.height, raster, 0))
          file.raster = raster;
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
  return file;
}

double GetAngle(File file) {
  while(xxx == 0) {
    FindFirstPivot(file);
    FindSecondPivot(file);
  }

  double current_min = 1.0, density;
  int x_current_min = 0, bottom = 0, running = 1;
  while(running) {
    density = LineDensity(file, yy, xxx + SHIFT_X, yy + DELTA_Y, bottom);

    if(density < current_min) {
      current_min = density;
      x_current_min = bottom;
    } else if(current_min < MINIMUM_DENSITY)
      running = 0;

    bottom++;
  }

  // Improve parameters (maybe substitute bottom by x_current_min)
  return (double)(bottom - xxx - SHIFT_X) / (double)(yy + DELTA_Y - yy);
}

void FindFirstPivot(File file) {
  int x;
  for(x = xx; x < file.width; x++) {
    int y;
    for(y = yy + 1; y < file.height; y++) {
      if(IsPixelFilled(file, x, y)) {
        xx = x;
        yy = y;
        return;
      }
    }
  }
  perror("File is blank");
}

void FindSecondPivot(File file) {
  int counter = 0;
  while(IsPixelFilled(file, xx + counter, yy))
    counter++;

  if(IsAproximatelly(counter, conf.mark_width))
    xxx = xx + counter;
}

double LineDensity(File file, int x1, int y1, int x2, int y2) {
  int counter = 0;
  int slope;
  int dx, dy, incE, incNE, d, x, y;

  if (x1 > x2)
    return LineDensity(file, x2, y2, x1, y1);
  
  dx = x2 - x1;
  dy = y2 - y1;

  if (dy < 0) {            
    slope = -1;
    dy = -dy;
  }
  else {            
    slope = 1;
  }

  incE = 2 * dy;
  incNE = 2 * dy - 2 * dx;
  d = 2 * dy - dx;
  y = y1;       
  for (x = x1; x <= x2; x++) {
    if(IsPixelFilled(file, y, x))
      counter++;

    if (d <= 0) {
      d += incE;
    }
    else {
      d += incNE;
      y += slope;
    }
  }

  return (double) counter / (double) (x2 - x1 + 1);
}

File Rotate(File file) {
  double tg2 = conf.tg*conf.tg;
  double s = sqrt((tg2)/(1.0 + tg2));
  double c = sqrt(1.0/(1.0 + tg2));

  File rotated_file = CreateEmptyFile(file.height, file.width);

  int x;
  for(x = 0; x < file.width; x++) {
    int y;
    for(y = 0; y < file.height; y++) {
      int xx = (int) floor(c*x - s*y);
      int yy = (int) floor(s*x + c*y);
      if(IsInFile(file, xx, yy))
        rotated_file.raster[FindRasterIndexTif(file, xx, yy)] = file.raster[FindRasterIndexTif(file, x, y)];
    }
  }
  return rotated_file;
}

File CreateEmptyFile(int height, int width) {
  File file;
  file.height = height;
  file.width = width;
  file.size = height * width;
  file.raster = (uint32*) malloc(file.size * sizeof(uint32));

  int i;
  for(i = 0; i < file.size; i++) 
    file.raster[i] = TIFF_WHITE_PIXEL;

  return file;
}

void WritePng(File file) {
  unsigned char* image = (unsigned char*) malloc(file.size * 4 * sizeof(unsigned char*));
  int i;
  for(i = 0; i < file.size * 4; i++)
    image[i] = 0;

  int x;
  for(x = 0; x < file.width; x++) {
    int y;
    for(y = 0; y < file.height; y++) {
      int i = FindRasterIndexTif(file, x, y);
      int j = FindRasterIndexPng(file, x, y);

      image[4*j] = (char) TIFFGetR(file.raster[i]);
      image[4*j+1] = (char) TIFFGetG(file.raster[i]);
      image[4*j+2] = (char) TIFFGetB(file.raster[i]);
      image[4*j+3] = (char) TIFFGetA(file.raster[i]);
    }
  }

  unsigned error = lodepng_encode32_file(conf.destination_path, image, file.width, file.height);
  if(error) perror(lodepng_error_text(error));
  free(image);
}

int IsAproximatelly(int actual, int expected) {
  float expected_top = (float) expected / ERROR;
  float expected_bottom = (float) expected * ERROR;
  float actual_float = (float) actual;

  return actual_float < expected_top && actual_float > expected_bottom;
}

int IsPixelFilled(File file, int x, int y) {
  int i = FindRasterIndexTif(file, x, y);
  int a = (int) TIFFGetA(file.raster[i]);
  int r = (int) TIFFGetR(file.raster[i]);
  int g = (int) TIFFGetG(file.raster[i]);
  int b = (int) TIFFGetB(file.raster[i]);

  return a == 255 && r + g + b == 0;
}

int IsInFile(File file, int x, int y) {
  return x > 0 && x < file.width && y > 0 && y < file.height;
}

int FindRasterIndexTif(File file, int x, int y) {
  return (file.height - y - 1) * file.width + x;
}

int FindRasterIndexPng(File file, int x, int y) {
  return y * file.width + x;
}