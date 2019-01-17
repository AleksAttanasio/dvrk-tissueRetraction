// ROS LIBRARIES
#include <ros/ros.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/features2d/features2d.hpp>


// ROS MESSAGES
#include <sensor_msgs/Image.h>
#include <sensor_msgs/RegionOfInterest.h>
#include <stereo_msgs/DisparityImage.h>

using namespace ros;
using namespace std;


stereo_msgs::DisparityImage disp_map = stereo_msgs::DisparityImage();
sensor_msgs::Image disp_map_img = sensor_msgs::Image();
cv_bridge::CvImage bridge;

double min_range_ = 5;
double max_range_ = 20;

void disparityCallback(const stereo_msgs::DisparityImage msg){

    try
    {
        bridge = cv_bridge::toCvCopy(msg.image, "32FC1");

    }
    catch (cv_bridge::Exception& e)
    {
        ROS_ERROR("Failed to transform depth image.");
        return;
    }

    // convert to something visible
//    cv::Mat img(bridge->image.rows, bridge->image.cols, CV_8UC1);
//    for(int i = 0; i < bridge->image.rows; i++)
//    {
//        float* Di = bridge->image.ptr<float>(i);
//        char* Ii = img.ptr<char>(i);
//        for(int j = 0; j < bridge->image.cols; j++)
//        {
//            Ii[j] = (char) (255*((Di[j]-min_range_)/(max_range_-min_range_)));
//        }
//    }

    // display
//    cv::imshow("Depth Map", img);
//    cv::waitKey(3);

}

int main (int argc, char** argv){

    ros::init(argc, argv, "flap_detection");
    ros::NodeHandle nh;
    ros::Subscriber sub_disp_map= nh.subscribe("/stereo/disparity", 1, &disparityCallback);
    ros::Rate loop_rate(24);

    cv::SimpleBlobDetector blob_detector;

    while(ros::ok()){
        
        std::vector<cv::KeyPoint> keypoints;
//        imshow("DM", bridge->image);
        cout << "runnin" << endl;
        loop_rate.sleep();
        ros::spinOnce();
    }

    return 0;
}