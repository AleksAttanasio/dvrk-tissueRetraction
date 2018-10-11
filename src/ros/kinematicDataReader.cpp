//
// Created by aleks on 10/9/18.
//

// ROS
#include <stdio.h>
#include <ros/ros.h>
#include <iostream>
#include <fstream>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <curses.h>

// ROS Messages
#include <sensor_msgs/JointState.h>
using namespace std;

double joint_values[7] ={0, 0, 0, 0, 0, 0, 0};

int keyHit(void)
{
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
}

void kinDataCallback(const sensor_msgs::JointState msg){

    joint_values[0] = msg.position[0];
    joint_values[1] = msg.position[1];
    joint_values[2] = msg.position[2];
    joint_values[3] = msg.position[3];
    joint_values[4] = msg.position[4];
    joint_values[5] = msg.position[5];
    joint_values[6] = msg.position[6];
}


int main(int argc, char **argv){

    // initialize window
    initscr();
    nocbreak();
    echo();

    // Welcome message
    printw("**** KINEMATIC DATA RECORDER ****\n");

    // Variable initialization
    int sample_count = 0;
    int interval_sample_print = 20;
    string node_name = "kinematic_data_reader";
    string kin_data_source_topic_name = "/dvrk/PSM1/io/joint_position";
    char file_name[100];
    ofstream collection_txt;
    stringstream ss;

    // Ask the user the name of the file he wants to print on
    do{

        printw("Enter now the file name to save your trial. NOTE: the suggested format is <file_name> + \".txt\"\n");
        getstr(file_name);
    }while(file_name[0] == '\0');
    
    collection_txt.open(file_name);

    // Reset keyboard settings
    cbreak();
    noecho();
    nodelay(stdscr, TRUE);
    scrollok(stdscr, TRUE);

    // Node Init
    ros::init(argc, argv, node_name);
    ros::NodeHandle nh;
    ros::Subscriber kin_data_sub = nh.subscribe(kin_data_source_topic_name, 1, &kinDataCallback);
    ros::Rate rate(30);
    sleep(1);

    printw("To start record a trial press \"A\". To quit press \"Q\". Trials will be saved automatically once finished. \n");

    while(ros::ok()){

        sleep(1);

        // If user pressed "A" button
        if(keyHit() == 1){

            printw("---> STARTED NEW RECORDING SESSION\n");

            while(keyHit() != 0) {

                // Output number of samples recorded with interval given by interval_sample_print
                if(sample_count % interval_sample_print == 0) {printw("Recorded: %d samples\n", sample_count);}

                // Save joint_values[]
                ss << sample_count;

                collection_txt << ss.str().c_str() << "\t" <<
                               joint_values[0] << "\t" <<
                               joint_values[1] << "\t" <<
                               joint_values[2] << "\t" <<
                               joint_values[3] << "\t" <<
                               joint_values[4] << "\t" <<
                               joint_values[5] << "\t" <<
                               joint_values[6] << "\n";

                sample_count++;
                ss.str(std::string());
                ros::spinOnce();
                rate.sleep();
            }
        }

        // If user press "Q"
        if (keyHit() == 0){

            ROS_INFO("*** TRIAL TERMINATED: %d samples were recorded.", sample_count);
            collection_txt.close();
            sleep(5);
            endwin();
            break;
        }

        ros::spinOnce();
    }

    return 0;

}