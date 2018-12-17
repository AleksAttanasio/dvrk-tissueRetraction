//
// Created by aleks on 10/12/18.
//

#include <stdio.h>
#include <ros/ros.h>

// ROS messages
#include <sensor_msgs/JointState.h>

// Namespaces
using namespace std;

int main(int argc, char **argv){

    // Variable Init
    int topic_rate = 30;
    int kin_data_dimension = 7;
    double raw_joint_pos[kin_data_dimension] = {0, 0, 0, 0, 0, 0, 0};
    string node_name = "joint_state_dummy";
    string topic_name = "/dvrk/PSM1/io/joint_position";

    // ROS init
    ros::init(argc, argv, node_name);
    ros::NodeHandle nh;
    ros::Publisher kin_data_sub = nh.advertise<sensor_msgs::JointState>(topic_name, 1);
    ros::Rate rate(topic_rate);
    sensor_msgs::JointState joint_msg = sensor_msgs::JointState();

    // Ackonwledgement
    ROS_INFO("### KINEMATIC DATA DUMMY\n"
             "Publishing on topic %s at %d Hz", topic_name.c_str(), topic_rate);

    while(ros::ok()){

        // Populating vector for message with joint_position
        vector<double> joint_pos(raw_joint_pos, raw_joint_pos+7);
        joint_msg.position = joint_pos;
        kin_data_sub.publish(joint_msg);

        // Update values
        raw_joint_pos[0] = raw_joint_pos[0] + 0.123123;
        raw_joint_pos[1] = raw_joint_pos[1] + 0.245245;
        raw_joint_pos[2] = raw_joint_pos[2] + 0.345345;
        raw_joint_pos[3] = raw_joint_pos[3] + 0.123123;
        raw_joint_pos[4] = raw_joint_pos[4] + 0.123123;
        raw_joint_pos[5] = raw_joint_pos[5] + 0.345345;
        raw_joint_pos[6] = raw_joint_pos[6] + 0.123123;

        // Ros spin and sleep
        ros::spinOnce();
        rate.sleep();
    }

    return 0;
}