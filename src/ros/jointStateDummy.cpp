//
// Created by osboxes on 10/12/18.
//

#include <stdio.h>
#include <ros/ros.h>

// ROS messages
#include <sensor_msgs/JointState.h>

using namespace std;

int main(int argc, char **argv){

    string node_name = "joint_state_dummy";
    string topic_name = "/dvrk/PSM1/io/joint_position";

    ros::init(argc, argv, node_name);
    ros::NodeHandle nh;
    ros::Publisher kin_data_sub = nh.advertise<sensor_msgs::JointState>(topic_name, 1);
    ros::Rate rate(30);

}