#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>
#include <string.h>
#include <tiffio.h>

typedef struct {
    int number_of_groups;
    int space_between_groups;
    int questions_per_group;
    int horizontal_space_between_marks;
    int vertical_space_between_marks;
    int marks_horizontal_diameter;
    int marks_vertical_diameter;
    char alternatives[20];
    int group_horizontal_position;
    int group_vertical_position;
} Zone;

typedef struct {
    int is_clocked;
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

void ReadConfiguration();
void ReadFile(char *, File *);
void ProcessFile(File *);
void ProcessZone(File *, Zone);
void ProcessGroup(File *, Zone , int);
void ProcessQuestion(File *, Zone , int , int);
double ProcessOption(int , int , int , int , File *);
void PrintAnswers(File);

Configuration conf;

int main(int argc, char* argv[])
{
    if(argc != 2)
        return 1;

    ReadConfiguration();

    File file;
    file.number_of_questions = 0;
    ReadFile(argv[1], &file);
    ProcessFile(&file);
    PrintAnswers(file);

    return 0;    
}

void ReadConfiguration()
{

    scanf("%d", &conf.is_clocked);
    scanf("%d", &conf.number_of_zones);
    scanf("%lf", &conf.threshold);

    int zone_number;
    for(zone_number = 0; zone_number < conf.number_of_zones; zone_number++)
    {
        Zone zone;
        scanf("%d", &zone.number_of_groups);
        scanf("%d", &zone.space_between_groups);
        scanf("%d", &zone.questions_per_group);
        scanf("%d", &zone.horizontal_space_between_marks);
        scanf("%d", &zone.vertical_space_between_marks);
        scanf("%d", &zone.marks_horizontal_diameter);
        scanf("%d", &zone.marks_vertical_diameter);
        scanf("%s", zone.alternatives);
        scanf("%d", &zone.group_horizontal_position);
        scanf("%d", &zone.group_vertical_position);
        conf.zones[zone_number] = zone;
    }
}

void ProcessFile(File *file)
{
    int zone_number;
    for(zone_number = 0; zone_number < conf.number_of_zones; zone_number++)
        ProcessZone(file, conf.zones[zone_number]);

    _TIFFfree(file->raster);
}

void ReadFile(char* path, File *file) 
{
    TIFF* tif = TIFFOpen(path, "r");
    if (tif) {
        int w = 0, h = 0; 
        TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &w);
        TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &h);
     
        if ((w > 0) && (h > 0))
        {
            uint32 *raster = (uint32*) _TIFFmalloc(w * h * sizeof (uint32));
            if (raster)
            { 
                if (TIFFReadRGBAImage(tif, w, h, raster, 0)) {
                    file->raster = raster;
                    file->width = w;
                    file->height = h;
                }
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

void ProcessZone(File *file, Zone zone)
{
    int group_number;
    for (group_number = 0; group_number < zone.number_of_groups; group_number++)
        ProcessGroup(file, zone, group_number);
}

void ProcessGroup(File *file, Zone zone, int group_number) 
{
    int question_number;
    for (question_number = 0; question_number < zone.questions_per_group; question_number++)
        ProcessQuestion(file, zone, group_number, question_number);
}

void ProcessQuestion(File *file, Zone zone, int group_number, int question_number)
{
    char answer = 'Z';

    int option_number;
    for (option_number = 0; option_number < strlen(zone.alternatives); option_number++)
    {
        int start_x = zone.group_horizontal_position + option_number * (zone.marks_horizontal_diameter + zone.horizontal_space_between_marks) + group_number * zone.space_between_groups;
        int start_y = zone.group_vertical_position + question_number * (zone.marks_vertical_diameter + zone.vertical_space_between_marks);
        int width = zone.marks_horizontal_diameter;
        int height = zone.marks_vertical_diameter;

        if (ProcessOption(start_x, start_y, width, height, file) > conf.threshold)
        {
            if (answer == 'Z')
                answer = zone.alternatives[option_number];
            else
                answer = 'W';
        }
    }

    file->answers[file->number_of_questions] = answer;
    file->number_of_questions++;
}

double ProcessOption(int start_x, int start_y, int width, int height, File *file)
{
    int all = 0;
    int match = 0;

    int y;
    for (y = start_y; y <= height + start_y; y++)
    {
        int x;
        for (x = start_x; x <= width + start_x; x++)
        {
            all++;
            unsigned long int i = (file->height-y)*file->width + x;
            int a = (int) TIFFGetA(file->raster[i]);
            int r = (int) TIFFGetR(file->raster[i]);
            int g = (int) TIFFGetG(file->raster[i]);
            int b = (int) TIFFGetB(file->raster[i]);
            if (a > 128 && r < 128 && g < 128 && b < 128)
                match++;
        }
    }

    return all == 0 ? 0 : (double)match/(double)all;
}

void PrintAnswers(File file) 
{
    int i;
    for (i = 0; i < file.number_of_questions; i++)
        printf("%c ", file.answers[i]);
}