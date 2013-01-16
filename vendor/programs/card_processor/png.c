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
} File;

typedef struct {
  char path[200];
  char destination_path[200];
} Configuration;

void ReadFile(File *);
void WritePng(File);
int FindRasterIndex(File, int, int);

Configuration conf;

int main(int argc, char* argv[])
{

  if(argc != 3) {
    perror("Wrong number of arguments!");
    return 1;
  }

  strcpy(conf.path, argv[1]);
  strcpy(conf.destination_path, argv[2]);

  File file;
  ReadFile(&file);
  WritePng(file);

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

void WritePng(File file) {
  int size = file.width * file.height;
  unsigned char* image = (unsigned char*) malloc(size * 4 * sizeof(unsigned char*));
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
  if(error) printf("error %u: %s\n", error, lodepng_error_text(error));
}

int FindRasterIndexTif(File file, int x, int y) {
  return (file.height - y - 1) * file.width + x;
}

int FindRasterIndexPng(File file, int x, int y) {
  return y * file.width + x;
}