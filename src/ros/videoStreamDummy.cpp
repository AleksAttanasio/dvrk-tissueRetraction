// ROS and OpenCV
#include <ros/ros.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <cv_bridge/cv_bridge.h>

// ROS Messages
#include "std_msgs/String.h"
#include <sensor_msgs/image_encodings.h>

using namespace std;

int main(int argc, char **argv){

    int pub_rate = 10;
    std_msgs::String topic_name;
    topic_name.data = "/camera_dummy";
    ros::init(argc, argv, "dummies");
    ros::NodeHandle nh;
    cv_bridge::CvImage cv_image;

    cv_image.image = cv::imread("../resources/images/dummies_test/dvrk.jpg",CV_LOAD_IMAGE_COLOR);
    cv_image.encoding = "bgr8";
    sensor_msgs::Image ros_image;
    cv_image.toImageMsg(ros_image);

    ros::Publisher pub = nh.advertise<sensor_msgs::Image>(topic_name.data, 1);
    ros::Rate loop_rate(pub_rate);
    ROS_INFO("Publishing sample image on %s at %d", topic_name.data.c_str(), pub_rate);

    while (nh.ok())
    {
        pub.publish(ros_image);
        loop_rate.sleep();
    }

    return 0;
}
