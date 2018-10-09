//
// Created by aleks on 10/9/18.
//

// ROS
#include <stdio.h>
#include <ros/ros.h>
#include <iostream>
#include <fstream>

// ROS Messages
#include <sensor_msgs/JointState.h>
using namespace std;

double joint_values[7] ={0, 0, 0, 0, 0, 0, 0};

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

    int sample_count = 0;
    string node_name = "kinematic_data_reader";
    string kin_data_source_topic_name = "/dvrk/PSM1/io/joint_position";
    ofstream collection_txt;
    stringstream ss;
    collection_txt.open("trial_0.txt");

    ros::init(argc, argv, node_name);
    ros::NodeHandle nh;

    ros::Subscriber kin_data_sub = nh.subscribe(kin_data_source_topic_name, 1, &kinDataCallback);

    while(ros::ok()){

        ss << sample_count;

        collection_txt << ss.str().c_str() << "\t" <<
            joint_values[0] << "\t" <<
            joint_values[1] << "\n";

        sample_count++;
        ss.str(std::string());

        ros::spinOnce();

    }

    ROS_INFO("*** TRIAL TERMINATED: %d samples were recorded.", sample_count);

    return 0;

}