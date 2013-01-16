#include "lodepng.h"
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
  int size;
} File;

typedef struct {
  char path[200];
  char destination_path[200];
  double tg;
} Configuration;

void ReadFile(File *);
void WritePng(File);
int FindRasterIndexTif(File, int, int);
int FindRasterIndexPng(File, int, int);
File Rotate(File);

Configuration conf;

int main(int argc, char* argv[])
{

  if(argc != 4) {
    perror("Wrong number of arguments!");
    return 1;
  }

  strcpy(conf.path, argv[1]);
  strcpy(conf.destination_path, argv[2]);
  sscanf(argv[3], "%lf", &conf.tg);


  File file;
  ReadFile(&file);
  WritePng(Rotate(file));
  // free(file.raster);

  return 0;    
}

void ReadFile(File *file) {
  TIFF* tif = TIFFOpen(conf.path, "r");
  if(tif) {
    TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &file->width);
    TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &file->height);
 
    if((file->width > 0) && (file->height > 0)) {
      file->size = file->width * file->height;
      uint32 *raster = (uint32*) _TIFFmalloc(file->width * file->height * sizeof(uint32));
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

void WritePng(File file) {
  unsigned char* image = (unsigned char*) malloc(file.size * 4 * sizeof(unsigned char*));

  int i;
  for(i = 0; i < file.size * 4; i++) {
    if(i % 4 == 3)
      image[i] = 0;
    else
      image[i] = 255;
  }

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
  free(file.raster);

  // unsigned error = lodepng_encode32_file(conf.destination_path, image, file.width, file.height);
  // if(error) printf("error %u: %s\n", error, lodepng_error_text(error));
  free(image);
}

int FindRasterIndexTif(File file, int x, int y) {
  return (file.height - y - 1) * file.width + x;
}

int FindRasterIndexPng(File file, int x, int y) {
  return y * file.width + x;
}

File Rotate(File file) {
  double tg2 = conf.tg*conf.tg;
  double s = sqrt((tg2)/(1.0 + tg2));
  double c = sqrt(1.0/(1.0 + tg2));
  // printf("s: %lf, c: %lf\n", s, c);

  File rotated_file;
  rotated_file.height = file.height;
  rotated_file.width = file.width;
  rotated_file.size = file.size;
  rotated_file.raster = (uint32*) malloc(file.size * sizeof(uint32));
  int i;
  for(i = 0; i < file.size; i++) {
    rotated_file.raster[i] = 4294967295;
  }

  int x;
  for(x = 0; x < file.width; x++) {
    int y;
    for(y = 0; y < file.height; y++) {
      int xx = (int) floor(c*x - s*y);
      int yy = (int) floor(s*x + c*y);
      if(xx > 0 && xx < file.width && yy > 0 && yy < file.height) {
        // printf("xx: %d, yy: %d\n", xx, yy);
        // printf("%Lu\n", file.raster[FindRasterIndexTif(file, x, y)]);
        rotated_file.raster[FindRasterIndexTif(file, xx, yy)] = file.raster[FindRasterIndexTif(file, x, y)];
      }
    }
  }
  return rotated_file;
}