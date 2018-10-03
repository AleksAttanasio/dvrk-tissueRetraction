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

//         cv::imshow("view", cv_bridge::toCvCopy(msg, "bgr8")->image);
         cv_ptr = cv_bridge::toCvCopy(msg, "bgr8");
         cv::waitKey(30);
    }
    catch (cv_bridge::Exception& e) {

        ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());

    }
}

int main(int argc, char **argv){

    // Variables
    int image_cnt = 0;
    string sub_topic_name = "/camera_dummy/image";
    stringstream ss;

    // Ros node, subs and pubs initialization
    ros::init(argc, argv, "stereo_img_reader");
    ros::NodeHandle nh;
    image_transport::ImageTransport it(nh);
    image_transport::Subscriber images_sub = it.subscribe("/camera_dummy/image", 1, &imageCallback);
    ros::Rate loop_rate(10);

    // If image is correctly read from topic print this
    if(cv_ptr->image.size > 0){ ROS_INFO("Image read successfully from topic %s", sub_topic_name.c_str()); }

    // Node loop
    while(ros::ok()){

        getchar(); // wait for user to type a char
        cv::waitKey(30);

        if(!cv_ptr->image.empty()){

            //Create new image name and save it
            ss << "test_" << image_cnt << ".bmp";
            cv::imwrite( ss.str().c_str(),  cv_ptr->image);
            image_cnt++;
            ROS_INFO("---> Image correctly saved with name: %s", ss.str().c_str());
            ss.str(std::string());
        }
        loop_rate.sleep();
        ros::spinOnce();

    }

    return 0;
}