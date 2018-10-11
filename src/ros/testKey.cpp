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
    initscr();

    cbreak();
    noecho();
    nodelay(stdscr, TRUE);
    scrollok(stdscr, TRUE);
    sleep(1);
    
    int n = 0;
    while (true) {
        if (kbhit() == 1) {
            printw("REGISTRO COSE DIO PORCO");
            while(kbhit() != 0){
                printw("DIOMERDA CAINO %d\n", n);
                refresh();
            }
        } else if (kbhit() == 0){
            printw("No key pressed yet...\n");
            refresh();
//            sleep(1);
            printw("CLOSING");
            endwin();
            break;
        }
    }
}