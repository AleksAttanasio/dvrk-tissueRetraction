// ROS and OpenCV
#include <ros/ros.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <sstream>

// ROS Messages
#include "std_msgs/String.h"
#include <sensor_msgs/image_encodings.h>

using namespace std;

cv_bridge::CvImagePtr cv_ptr (new cv_bridge::CvImage);

void imageCallback(const sensor_msgs::ImageConstPtr msg) {

    try {

         cv::imshow("view", cv_bridge::toCvShare(msg, "bgr8")->image);
         cv::waitKey(30);
    }
    catch (cv_bridge::Exception& e) {

        ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());

    }
}

int main(int argc, char **argv){

    string sub_topic_name = "/camera_dummy/image";
    ros::init(argc, argv, "stereo_img_reader");
    ros::NodeHandle nh;
    cv::namedWindow("view");
    cv::startWindowThread();
    image_transport::ImageTransport it(nh);
    image_transport::Subscriber images_sub = it.subscribe("/camera_dummy/image", 1, &imageCallback);
    stringstream ss;

    if(cv_ptr->image.size > 0){

        ROS_INFO("Image read successfully from topic %s", sub_topic_name.c_str());
    }

    cv::imwrite( "1.jpg",  cv_ptr->image);
    ros::spin();
    return 0;
}