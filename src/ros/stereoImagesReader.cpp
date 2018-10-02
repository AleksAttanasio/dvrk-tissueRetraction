// ROS and OpenCV
#include <ros/ros.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>

// ROS Messages
#include "std_msgs/String.h"
#include <sensor_msgs/image_encodings.h>

using namespace std;

void imageCallback(const sensor_msgs::ImageConstPtr& msg) {

}

int main(int argc, char **argv){

    ros::NodeHandle nh;
    image_transport::ImageTransport it(nh);
    image_transport::Subscriber sub_images = it.subscribe("/camera_dummy", 1, imageCallback);




    return 0;
}