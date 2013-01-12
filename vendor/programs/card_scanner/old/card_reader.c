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
    char path[200];
    int number_of_questions;
    char answers[200];

    uint32 *raster;
    int height;
    int width;
} File;

typedef struct {
    char path[200];
    int number_of_files;
    File files[2000];
} Directory;

void ReadConfiguration();
void FindFiles(Directory *);
void PrintFiles(Directory);
void PrintAnswers(Directory);

void ProcessDirectory(Directory *dir);
void ReadFile(char* path, File *file) ;
void ProcessFile(File *file);
void ProcessZone(File *file, Zone zone);
void ProcessGroup(File *file, Zone zone, int group_number);
void ProcessQuestion(File *file, Zone zone, int group_number, int question_number);
double ProcessOption(int start_x, int start_y, int width, int height, File *file);

Configuration conf;

int main(int argc, char* argv[])
{
    Directory dir;
    gets (dir.path);
    FindFiles(&dir);

    ReadConfiguration();
    ProcessDirectory(&dir);    
    PrintAnswers(dir);

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

void ProcessDirectory(Directory *dir)
{
    int file_number;
    for(file_number = 0; file_number < dir->number_of_files; file_number++)
    {
        File *file = &(dir->files[file_number]);
        ReadFile(dir->path, file);
        ProcessFile(file);
        _TIFFfree(file->raster);
    }
}

void ReadFile(char* path, File *file) 
{
    char full_file_path[300];
    strcpy(full_file_path, path);
    strcat(full_file_path, "/");
    strcat(full_file_path, (*file).path);

    TIFF* tif = TIFFOpen(full_file_path, "r");
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

void ProcessFile(File *file)
{
    int zone_number;
    for(zone_number = 0; zone_number < conf.number_of_zones; zone_number++)
        ProcessZone(file, conf.zones[zone_number]);
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
    double options_values[10];

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

void FindFiles(Directory *dir) 
{
    DIR *dp;
    struct dirent *ep;
    dp = opendir (dir->path);

    if (dp != NULL) 
    {
        while (ep = readdir (dp)) 
        {
            if(strcmp(ep->d_name, "..") != 0 && strcmp(ep->d_name, ".") != 0) 
            {
                strcpy(dir->files[dir->number_of_files].path, (ep->d_name));
                dir->number_of_files++;
            }
        }
        (void) closedir (dp);
    }
    else
    {
        perror ("Couldn't open the directory");
    }
}

void PrintFiles(Directory dir)
{
    printf("Files:\n");
    int i;
    for (i = 0; i < dir.number_of_files; i++)
    {
        printf("\t%s\n", dir.files[i].path);
    } 
}

void PrintAnswers(Directory dir) 
{
    int i;
    for (i = 0; i < dir.number_of_files; i++)
    {
        printf("%s ", dir.files[i].path);
        int j;
        for (j = 0; j < dir.files[i].number_of_questions; j++)
        {
            printf("%c", dir.files[i].answers[j]);
        }
        printf("\n");
    }
}