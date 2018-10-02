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

cv_bridge::CvImagePtr cv_ptr;

void imageCallback(const sensor_msgs::ImageConstPtr& msg) {

    try
    {
        cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
    }
    catch (cv_bridge::Exception& e)
    {
        ROS_ERROR("cv_bridge exception: %s", e.what());
        return;
    }

}

int main(int argc, char **argv){

    ros::NodeHandle nh;
    image_transport::ImageTransport it(nh);
    image_transport::Subscriber images_sub = it.subscribe("/camera_dummy", 1, &imageCallback);
    stringstream ss;

    ss << "1";

    ROS_ASSERT( cv::imwrite( ss.str(),  cv_ptr->image ) );
    
    return 0;
}