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
    double raw_joint_pos[7] = {0, 0, 0, 0, 0, 0, 0};

    sensor_msgs::JointState joint_msg = sensor_msgs::JointState();

    while(ros::ok()){

        vector<double> joint_pos(raw_joint_pos, raw_joint_pos+7);
        joint_msg.position = joint_pos;
        kin_data_sub.publish(joint_msg);

        raw_joint_pos[0] = raw_joint_pos[0] + 0.123123;
        raw_joint_pos[1] = raw_joint_pos[1] + 0.245245;
        raw_joint_pos[2] = raw_joint_pos[2] + 0.345345;
        raw_joint_pos[3] = raw_joint_pos[3] + 0.123123;
        raw_joint_pos[4] = raw_joint_pos[4] + 0.123123;
        raw_joint_pos[5] = raw_joint_pos[5] + 0.345345;
        raw_joint_pos[6] = raw_joint_pos[6] + 0.123123;

        ros::spinOnce();
        rate.sleep();
    }

    return 0;
}