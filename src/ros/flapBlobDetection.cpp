// ROS LIBRARIES
#include <ros/ros.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

// ROS MESSAGES
#include <sensor_msgs/Image.h>
#include <sensor_msgs/RegionOfInterest.h>
#include <stereo_msgs/DisparityImage.h>

cv_bridge::CvImagePtr cv_disp_map (new cv_bridge::CvImage);

void disparityCallback(const stereo_msgs::DisparityImage msg) {
    try {
//        Visualize images
        cv::imshow("Depth Map", cv_bridge::toCvCopy(msg.image, "bgr8")->image);
        cv_disp_map = cv_bridge::toCvCopy(msg.image, "bgr8");
        cv::waitKey(30);
    }
    catch (cv_bridge::Exception& e) {

        ROS_ERROR("Could not convert disparity map to 'bgr8'.");

    }
}

using namespace ros;
using namespace std;

int main (int argc, char** argv){

    ros::init(argc, argv, "flap_detection");
    ros::NodeHandle nh_;
    ros::Subscriber left_img_sub = nh_.subscribe("/camera/disparity", 1, &disparityCallback);

    return 0;
}