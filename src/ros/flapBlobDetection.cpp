// ROS LIBRARIES
#include <ros/ros.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <sensor_msgs/image_encodings.h>
#include <opencv2/features2d/features2d.hpp>


// ROS MESSAGES
#include <sensor_msgs/Image.h>
#include <sensor_msgs/RegionOfInterest.h>
#include <stereo_msgs/DisparityImage.h>

using namespace ros;
using namespace std;


stereo_msgs::DisparityImage disp_map = stereo_msgs::DisparityImage();
sensor_msgs::ImageConstPtr disp_map_img;
cv_bridge::CvImagePtr cv_ptr (new cv_bridge::CvImage);
cv::Mat locImage;

void disparityCallback(const stereo_msgs::DisparityImage msg){
    locImage=cv_bridge::toCvCopy(msg.image)->image;
    locImage.convertTo(locImage,CV_32FC1,1.0/255.0);

    cv::imshow("Right View", locImage);
    cv::waitKey(30);
}

int main (int argc, char** argv){

    ros::init(argc, argv, "flap_detection");
    ros::NodeHandle nh;
    ros::Subscriber sub_disp_map= nh.subscribe("/stereo/disparity", 1, &disparityCallback);
    ros::Rate loop_rate(24);

    while(ros::ok()){

        cout << "runnin" << endl;


        loop_rate.sleep();
        ros::spinOnce();
    }

    return 0;
}