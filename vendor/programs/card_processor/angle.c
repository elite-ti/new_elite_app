#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <tiffio.h>
#include <math.h>

#define PI 3.141592653589793

typedef struct {
  uint32 *raster;
  int height;
  int width;
} File;

typedef struct {
  char path[200];
  int mark_width;
  int mark_height;
  float error;
} Configuration;

void ReadFile(File *);
double GetAngle(File);
void FindFirstPivot(File);
void FindSecondPivot(File);
int IsPixelFilled(File, int, int);
int FindRasterIndex(File, int, int);
double LineDensity(File file, int x1, int y1, int x2, int y2);

Configuration conf;
int xx, yy, xxx;

int main(int argc, char* argv[])
{

  if(argc != 4) {
    perror("Wrong number of arguments!");
    return 1;
  }

  xx = 0;
  yy = 0;
  xxx = 0;

  strcpy(conf.path, argv[1]);
  sscanf(argv[2], "%d", &conf.mark_width);
  sscanf(argv[3], "%d", &conf.mark_height);
  conf.error = 0.8;

  File file;
  ReadFile(&file);

  printf("%lf", GetAngle(file));
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

double GetAngle(File file) {
  while(xxx == 0) {
    FindFirstPivot(file);
    FindSecondPivot(file);
  }

  double min = 1.0;
  int x_min = 0;
  int bottom = 0;
  double density;
  int boolean = 1;
  while(boolean) {
    density = LineDensity(file, yy, xxx + 5, yy + 3000, bottom);
    if(density < min) {
      min = density;
      x_min = bottom;
    } else {
      if(min < 0.1) {
        boolean = 0;
      } else {
        // do nothing
      }
    }
    // printf("Density: %lf\n", density);
    // printf("x0: %d, y0: %d, x1: %d, y1: %d\n", xxx, yy, bottom, yy + 3000);
    bottom++;
  }
  // printf("x: %d, y:%d\n", bottom, yy+3000);

  return atan((double)(bottom - xxx - 5) / (double)(yy + 3000 - yy))*180.0/PI;
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
  while(IsPixelFilled(file, xx + counter, yy)) {
    counter++;
  }

  if(IsAproximatelly(counter, conf.mark_width)) {
    xxx = xx + counter;
  }
}

int IsAproximatelly(int actual, int expected) {
  float expected_top = (float) expected / conf.error;
  float expected_bottom = (float) expected * conf.error;
  float actual_float = (float) actual;

  if(actual_float < expected_top && actual_float > expected_bottom)
    return 1;
  else
    return 0;
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