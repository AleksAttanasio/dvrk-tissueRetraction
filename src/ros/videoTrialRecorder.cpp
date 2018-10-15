//
// Created by aleks on 10/15/18.
//

// ROS and OpenCV
#include <stdio.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <cv_bridge/cv_bridge.h>
#include <sstream>
#include <iostream>
#include <fstream>
#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <curses.h>

// Namespaces
using namespace std;

cv_bridge::CvImagePtr cv_left_ptr (new cv_bridge::CvImage);
cv_bridge::CvImagePtr cv_right_ptr (new cv_bridge::CvImage);

int keyHit(void){
    int ch = getch();

    // If "Q" pressed (113)
    if (ch == 113) {
        ungetch(ch);
        return 0;
    }
        // If "A" pressed (97)
    else if (ch == 97){
        return 1;
    }
    else{ return 2; }
}

void rightImageCallback(const sensor_msgs::ImageConstPtr msg) {

    try {
        cv_right_ptr = cv_bridge::toCvCopy(msg, "bgr8");
        cv::waitKey(30);
    }
    catch (cv_bridge::Exception& e) {

        ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());

    }
}

void leftImageCallback(const sensor_msgs::ImageConstPtr msg) {

    try {
        cv_left_ptr = cv_bridge::toCvCopy(msg, "bgr8");
        cv::waitKey(30);
    }
    catch (cv_bridge::Exception& e) {

        ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());

    }
}

int main(int argc, char **argv){

    // Initialize window
    initscr();
    nocbreak();
    echo();
    start_color();

    // Color pairs initialization
    init_pair(1, COLOR_BLACK, COLOR_RED);
    init_pair(2, COLOR_BLACK, COLOR_GREEN);
    init_pair(3, COLOR_BLACK, COLOR_CYAN);
    init_pair(4, COLOR_YELLOW, COLOR_BLACK);

    // Welcome message
    attron(COLOR_PAIR(3));
    printw("**** VIDEO TRIAL RECORDER ****\n");
    attroff(COLOR_PAIR(3));

    // Variable initialization
    int pub_rate = 30;
    int interval_sample_print = 30;                                     // interval to print number of recorded samples
    int image_cnt = 0;                                                  // count of images
    char cwd[1024];                                                     // working directory
    char folder_name[100] = "";                                         // name of the file where to save kinematic data
    string node_name = "video_trial_recorder";                          // name of ROS node
    string left_img_sub_topic_name = "/camera_dummy/image_left";        // LEFT image topic name
    string right_img_sub_topic_name = "/camera_dummy/image_right";      // RIGHT image topic name
    stringstream ss_left;                                               // string stream for left image name
    stringstream ss_right;                                              // string stream for left image name
    stringstream path;                                                  // trials path
    stringstream file_name;                                             // Name of the file
    getcwd(cwd, sizeof(cwd));                                           // getting the working directory

    // Ask the user the name of the file he wants to print on
    do{

        printw("Your trials will be saved in %s/resources/trials. Create a sub-folder in here to store images inside.\n\n", cwd);
        printw("Enter now the name of the sub-directory where to save your trial. NOTE: images will be saved in %s with name L_<number_of_sample>.jpeg and R_<sample_number>.jpeg\n", cwd);
        printw("Otherwise, press Q to close.");
        getstr(folder_name);

        if (folder_name[0] == '\0'){
            attron(COLOR_PAIR(1));
            printw("The folder name must be defined!\n");
            attroff(COLOR_PAIR(1));
        }

    }while(folder_name[0] == '\0');

    path << cwd << "/resources/trials/" << folder_name;

    attron(COLOR_PAIR(2));
    printw("Your trial will be saved in:");
    attroff(COLOR_PAIR(2));
    printw(" %s\n", path.str().c_str());

    // Reset keyboard settings
    cbreak();
    noecho();
    nodelay(stdscr, TRUE);
    scrollok(stdscr, TRUE);

    // Ros node, subs and pubs initialization
    ros::init(argc, argv, "video_trial_recorder");
    ros::NodeHandle nh;
    image_transport::ImageTransport it(nh);
    image_transport::Subscriber left_img_sub = it.subscribe(left_img_sub_topic_name, 1, &leftImageCallback);
    image_transport::Subscriber right_img_sub = it.subscribe(right_img_sub_topic_name, 1, &rightImageCallback);
    ros::Rate loop_rate(pub_rate);

    printw("To start record a trial press \"A\". To stop or quit pressing \"Q\" twice. Trials will be saved automatically once finished. \n");

    while(ros::ok()){

        sleep(1);

        // If user pressed "A" button
        if(keyHit() == 1){

            attron(COLOR_PAIR(4));
            printw("---> STARTED NEW RECORDING SESSION\n");
            attroff(COLOR_PAIR(4));


            while(keyHit() != 0) {

                // Output number of samples recorded with interval given by interval_sample_print
                if(image_cnt % interval_sample_print == 0) {printw("Recorded: %d samples\n", image_cnt);}

                ss_left << path.str().c_str() << "/L_" << image_cnt << ".jpeg";
                ss_right << path.str().c_str() << "/R_" << image_cnt << ".jpeg";

                cv::imwrite(ss_left.str().c_str(), cv_left_ptr->image);
                cv::imwrite(ss_right.str().c_str(), cv_right_ptr->image);
                image_cnt++;

                ss_left.str(std::string());
                ss_right.str(std::string());

                ros::spinOnce();
                loop_rate.sleep();
            }

            attron(COLOR_PAIR(2));
            printw("*** TRIAL TERMINATED: %d samples were recorded. ", image_cnt);
            attroff(COLOR_PAIR(2));

        }

        // If user press "Q"
        if (keyHit() == 0){

            // Ask for confirm to close the window
            int entered_char = getchar();
            if(entered_char == 113) {
                // close file and window
                endwin();
                break;
            }
        }

        ros::spinOnce();
    }

    return 0;
}
