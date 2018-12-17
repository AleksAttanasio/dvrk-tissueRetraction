//
// Created by osboxes on 10/10/18.
//
#include <stdio.h>
#include <curses.h>
#include <ros/ros.h>

int kbhit(void)
{
    int ch = getch();

    if (ch == 113) {
        ungetch(ch);
        return 0;
    }
    else if (ch == 97){
        return 1;
    }
}

int main(int argc, char **argv)
{
    const int dir_err = mkdir("foo", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
    if (-1 == dir_err)
    {
        printf("Error creating directory!n");
        exit(1);
    }
}