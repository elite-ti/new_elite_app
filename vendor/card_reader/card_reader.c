#include<stdio.h>
#include <sys/types.h>
#include <dirent.h>
#include <string.h>

// Models
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
    char* answers;
} File;

typedef struct {
    char path[200];
    int number_of_files;
    File files[2000];
} Directory;

// Functions
void FindFiles(Directory);
void PrintFiles(char *);
double VerifyRectangle(int start_x, int start_y, int len_x, int len_y);
void DrawRectangle(int start_x, int start_y, int len_x, int len_y);

int main(int argc, char* argv[])
{
    Directory dir;
    Configuration conf;
    int debug = 1;

    printf("Starting program...\n");

    // Gets directory
    gets (dir.path);
    FindFiles(dir);

    // Reads configuration
    scanf("%d", &conf.is_clocked);
    scanf("%d", &conf.number_of_zones);
    scanf("%lf", &conf.threshold);


    if(debug)
    {
        printf("Directory: %s\n", dir.path);
        printf("Uses Clock: %s\n", conf.is_clocked == 1 ? "Yes" : "No");
        printf("Number of zones: %d\n", conf.number_of_zones);
        printf("Threshold: %f\n", conf.threshold);

        PrintFiles(dir.path);
    }

    int zone;
    for(zone = 0; zone < conf.number_of_zones; zone++)
    {
        Zone z;

        // Reads group properties
        scanf("%d", &z.number_of_groups);
        scanf("%d", &z.space_between_groups);
        scanf("%d", &z.questions_per_group);
        scanf("%d", &z.horizontal_space_between_marks);
        scanf("%d", &z.vertical_space_between_marks);
        scanf("%d", &z.marks_horizontal_diameter);
        scanf("%d", &z.marks_vertical_diameter);
        scanf("%s", z.alternatives);
        scanf("%d", &z.group_horizontal_position);
        scanf("%d", &z.group_vertical_position);

        conf.zones[zone] = z;

        if(debug)
        {
            printf("Zone #%d\n", zone);
            printf("\tnumber_of_groups: %d\n", conf.zones[zone].number_of_groups);
            printf("\tspace_between_groups: %d\n", conf.zones[zone].space_between_groups);
            printf("\tquestions_per_group: %d\n", conf.zones[zone].questions_per_group);
            printf("\thorizontal_space_between_marks: %d\n", conf.zones[zone].horizontal_space_between_marks);
            printf("\tvertical_space_between_marks: %d\n", conf.zones[zone].vertical_space_between_marks);
            printf("\tmarks_horizontal_diameter: %d\n", conf.zones[zone].marks_horizontal_diameter);
            printf("\tmarks_vertical_diameter: %d\n", conf.zones[zone].marks_vertical_diameter);
            printf("\talternatives: %s\n", conf.zones[zone].alternatives);
            printf("\tgroup_horizontal_position: %d\n", conf.zones[zone].group_horizontal_position);
            printf("\tgroup_vertical_position: %d\n", conf.zones[zone].group_vertical_position);
            printf("\n");
        }
    }

    // Process files
    int file_number;
    for(file_number = 0; file_number < dir.number_of_files; file_number++)
    {
        char ans[200];
        int question = 0;
        for(zone = 0; zone < conf.number_of_zones; zone++)
        {
            int k;
            for (k = 0; k < conf.zones[zone].number_of_groups; k++)
            {
                int i;
                for (i = 0; i < conf.zones[zone].questions_per_group; i++)
                {
                    char answer = 'Z';

                    int j;
                    for (j = 0; j < strlen(conf.zones[zone].alternatives); j++)
                    {
                        int start_x = conf.zones[zone].group_horizontal_position + j * (conf.zones[zone].marks_horizontal_diameter + conf.zones[zone].horizontal_space_between_marks) + k * conf.zones[zone].space_between_groups;
                        int start_y = conf.zones[zone].group_vertical_position + i * (conf.zones[zone].marks_vertical_diameter + conf.zones[zone].vertical_space_between_marks);
                        int width = conf.zones[zone].marks_horizontal_diameter;
                        int height = conf.zones[zone].marks_vertical_diameter;

                        if (VerifyRectangle(start_x, start_y, width, height) > conf.threshold)
                        {
                            DrawRectangle(start_x, start_y, width, height);
                            if (answer == 'Z')
                                answer = conf.zones[zone].alternatives[j];
                            else
                                answer = 'W';
                        }
                    }
                    ans[question] = answer;
                    question++;
                }
            }
        }
        dir.files[file_number].answers = ans;
    }

    return 0;
}

double VerifyRectangle(int start_x, int start_y, int width, int height)
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
            //if (GetPixel(x, y).A == 255 && bmp.GetPixel(x, y).R < 128)
            if(1)
                match++;
        }
    }

    return all == 0 ? 0 : (double)match/(double)all;
}

void DrawRectangle(int start_x, int start_y, int len_x, int len_y)
{
    printf("Drawing rectangle: (%d, %d, %d, %d)\n", start_x, start_y, len_x, len_y);
}

void FindFiles(Directory dir)
{
    DIR *dp;
    struct dirent *ep;
    dp = opendir (dir.path);

    if (dp != NULL)
    {
        while (ep = readdir (dp))
        {
            if(strcmp(ep->d_name, "..") != 0 && strcmp(ep->d_name, ".") != 0)
            {
                strcpy(dir.files[dir.number_of_files].path, (ep->d_name));
                dir.number_of_files++;
            }
        }
        (void) closedir (dp);
    }
    else
        perror ("Couldn't open the directory");
}

void PrintFiles(char * directory)
{
    DIR *dp;
    struct dirent *ep;
    dp = opendir (directory);

    if (dp != NULL)
    {
        printf("Files:\n");
        while (ep = readdir (dp))
        {
            if(strcmp(ep->d_name, "..") != 0 && strcmp(ep->d_name, ".") != 0)
                printf("\t%s\n", ep->d_name);
        }
        (void) closedir (dp);
    }
    else
        perror ("Couldn't open the directory");
}
