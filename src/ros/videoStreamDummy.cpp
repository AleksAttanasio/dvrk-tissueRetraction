// ROS and OpenCV
#include <ros/ros.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <unistd.h>
#include <stdio.h>

// ROS Messages
#include "std_msgs/String.h"
#include <sensor_msgs/image_encodings.h>

using namespace std;

int main(int argc, char **argv){

    int pub_rate = 10;
    string topic_name = "/camera_dummy/image";
    string path = "resources/images/dummies_test/laparoscopy.jpg";

    ros::init(argc, argv, "camera_dummy");
    ros::NodeHandle nh;

    image_transport::ImageTransport it(nh);
    image_transport::Publisher img_pub = it.advertise(topic_name, 1);

    cv_bridge::CvImage cv_image;
    cv::Mat image = cv::imread(path, CV_LOAD_IMAGE_COLOR);
    cv::waitKey(30);
    sensor_msgs::ImagePtr msg = cv_bridge::CvImage(std_msgs::Header(), "bgr8", image).toImageMsg();

    ros::Rate loop_rate(pub_rate);

    char cwd[1024];
    getcwd(cwd, sizeof(cwd));

    ROS_INFO("Publishing sample image on %s at %d Hz \nFile: %s \nCWS: %s", topic_name.c_str(), pub_rate, path.c_str(), cwd);

    while (nh.ok())
    {
        img_pub.publish(msg);
        ros::spinOnce();
        loop_rate.sleep();
    }


    return 0;
}
