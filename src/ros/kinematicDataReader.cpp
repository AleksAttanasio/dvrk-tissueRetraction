//
// Created by aleks on 10/9/18.
//

// ROS
#include <stdio.h>
#include <ros/ros.h>

// ROS Messages
#include <sensor_msgs/JointState.h>
using namespace std;

double joint_values[7];

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

    string node_name = "kinematic_data_reader";
    string kin_data_source_topic_name = "/dvrk/PSM1/io/joint_position";

    ros::init(argc, argv, node_name);
    ros::NodeHandle nh;

    ros::Subscriber kin_data_sub = nh.subscribe(kin_data_source_topic_name, 1, &kinDataCallback);

}