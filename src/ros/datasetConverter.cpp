//
// Created by aleks on 29/01/19.
//

// ROS LIBRARIES
#include <ros/ros.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <sensor_msgs/image_encodings.h>
#include <opencv2/features2d/features2d.hpp>
#include <sstream>


// ROS MESSAGES
#include <sensor_msgs/Image.h>
#include <sensor_msgs/RegionOfInterest.h>
#include <stereo_msgs/DisparityImage.h>

using namespace ros;
using namespace std;

cv_bridge::CvImagePtr cv_disp_ptr (new cv_bridge::CvImage);
cv::Mat depth_mat;
cv::Mat depth_mat_8;
cv_bridge::CvImagePtr cv_left_ptr (new cv_bridge::CvImage);
cv_bridge::CvImagePtr cv_right_ptr (new cv_bridge::CvImage);

void leftImageCallback(const sensor_msgs::ImageConstPtr msg) {

    try {
        cv_left_ptr = cv_bridge::toCvCopy(msg, "bgr8");
        cv::waitKey(30);
    }
    catch (cv_bridge::Exception& e) {

        ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());

    }
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

void disparityCallback(const stereo_msgs::DisparityImage msg){

    double minVal;
    double maxVal;
    cv::Point minLoc;
    cv::Point maxLoc;

    minMaxLoc( depth_mat, &minVal, &maxVal, &minLoc, &maxLoc );
    cv_disp_ptr = cv_bridge::toCvCopy(msg.image);
    depth_mat = cv_bridge::toCvCopy(msg.image)->image;
    depth_mat.convertTo(depth_mat,CV_32FC1,1.0/255.0);
    depth_mat.convertTo(depth_mat_8, CV_8UC1, 255.0/(maxVal-minVal),-255.0*minVal/(maxVal-minVal));

    cv::imshow("Direct Stream", depth_mat);
    cv::waitKey(15);
}

int main (int argc, char** argv) {

    // ROS init, subs and pubs
    string left_img_topic = "/stereo/left/image_rect_color";
    string right_img_topic = "/stereo/right/image_rect_color";
    string disp_map_topic = "/decompressed/disparity";
    int image_cnt = 0;                                                  // count of images
    string disp_map_path = "/home/aleks/rosbag_lobe/disp";
    string right_img_rect_path = "/home/aleks/rosbag_lobe/right";
    string left_img_rect_path = "/home/aleks/rosbag_lobe/left";
    stringstream ss_disp_map;
    stringstream ss_right_img;
    stringstream ss_left_img;

    ros::init(argc, argv, "flap_detection");
    ros::NodeHandle nh;
    image_transport::ImageTransport it(nh);
    image_transport::Subscriber left_img_sub = it.subscribe(left_img_topic, 1, &leftImageCallback);
    image_transport::Subscriber right_img_sub = it.subscribe(right_img_topic, 1, &rightImageCallback);
    image_transport::Publisher pub_disp_map = it.advertise("/decompressed/disparity", 1);
    ros::Subscriber sub_disp_map = nh.subscribe("/stereo/disparity", 1, &disparityCallback);
    ros::Rate loop_rate(24);


    while (ros::ok()) {

        if (!depth_mat.empty()) {

            ss_disp_map << disp_map_path << "/" << "disp_" << image_cnt << ".jpeg";
            ss_left_img << right_img_rect_path << "/" << "right_" << image_cnt << ".jpeg";
            ss_right_img << left_img_rect_path << "/" << "left_" << image_cnt << ".jpeg";

            image_cnt++;

            cv::imwrite(ss_disp_map.str().c_str(), cv_disp_ptr->image);
            cv::imwrite(ss_left_img.str().c_str(), cv_left_ptr->image);
            cv::imwrite(ss_right_img.str().c_str(), cv_right_ptr->image);

            ss_disp_map.str(std::string());
            ss_left_img.str(std::string());
            ss_right_img.str(std::string());
        }


        loop_rate.sleep();
        ros::spinOnce();
    }

    return 0;
}