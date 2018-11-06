//
// Created by aleks 11/5/18
//

#include <ros/ros.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <image_transport/image_transport.h>

using namespace std;

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

int main (int argc, char** argv){

    string left_img_sub_topic_name = "/camera_dummy/image_left";
    string right_img_sub_topic_name = "camera_dummy/image_right";

    // Ros node, subs and pubs initialization
    ros::init(argc, argv, "stereo_img_reader");
    ros::NodeHandle nh;
    image_transport::ImageTransport it(nh);
    image_transport::Subscriber left_img_sub = it.subscribe(left_img_sub_topic_name, 1, &leftImageCallback);
    image_transport::Subscriber right_img_sub = it.subscribe(right_img_sub_topic_name, 1, &rightImageCallback);
    ros::Rate loop_rate(10);

    while(ros::ok()){

        ros::spinOnce();
        loop_rate.sleep();
    }
}