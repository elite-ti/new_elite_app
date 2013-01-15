#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <tiffio.h>
#include <math.h>

typedef struct {
  uint32 *raster;
  int height;
  int width;
} File;

typedef struct {
  char path[200];
  int mark_width;
  int mark_height;
} Configuration;

void ReadFile(File *);
double GetAngle(File);
int IsFileAligned(File);
void FindPivot(File, int, int, int *, int *);
int IsPixelFilled(File, int, int);
int FindRasterIndex(File, int, int);

Configuration conf;

int main(int argc, char* argv[])
{
  if(argc != 4) {
    perror("Wrong number of arguments!");
    return 1;
  }

  strcpy(conf.path, argv[1]);
  sscanf(argv[2], "%d", &conf.mark_width);
  sscanf(argv[3], "%d", &conf.mark_height);

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
  if(IsFileAligned(file))
    return (double) 0;

  int x0, y0, x1, y1;
  FindPivot(file, 0, 0, &x0, &y0);
  FindPivot(file, x0, y0, &x1, &y1);
  // printf("x0: %d\ny0: %d\nx1: %d\ny1: %d\n", x0, y0, x1, y1);

  return atan((double)(x1 - x0) / (double)(y1 - y0))*180.0/3.141592653589793;
}

int IsFileAligned(File file) {
  int counter, i;
  for(i = 0; i < file.height; i++)
    if(IsPixelFilled(file, 0, i))
      counter++;

  if(counter > 50*conf.mark_height*0.9)
    return 1;
  else
    return 0;
}

void FindPivot(File file, int x0, int y0, int *x1, int *y1) {
  int x;
  for(x = 0; x < file.width; x++) {
    int y;
    for(y = (file.height - 1); y >= 0; y--) {
      if(IsPixelFilled(file, x, y)) {
        if(x > x0 && y > y0) {
          (*x1) = x;
          (*y1) = y;
          return;
        }
      }
    }
  }
  perror("File is blank");
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