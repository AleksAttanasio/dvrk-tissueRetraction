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
cv::Mat depth_mat;
cv::Mat depth_mat_8;

void disparityCallback(const stereo_msgs::DisparityImage msg){

    double minVal;
    double maxVal;
    cv::Point minLoc;
    cv::Point maxLoc;

    minMaxLoc( depth_mat, &minVal, &maxVal, &minLoc, &maxLoc );

    depth_mat=cv_bridge::toCvCopy(msg.image)->image;
    depth_mat.convertTo(depth_mat,CV_32FC1,1.0/255.0);
    depth_mat.convertTo(depth_mat_8, CV_8UC1, 255.0/(maxVal-minVal),-255.0*minVal/(maxVal-minVal));

    cv::imshow("Direct Stream", depth_mat_8);
    cv::waitKey(15);
}

int main (int argc, char** argv){

    // ROS init, subs and pubs
    ros::init(argc, argv, "flap_detection");
    ros::NodeHandle nh;
    ros::Subscriber sub_disp_map= nh.subscribe("/stereo/disparity", 1, &disparityCallback);
    ros::Rate loop_rate(24);

    // K-mean parameters
    int K = 3;
    std::vector<int> labels;
    cv::Mat1f colors;
    cv::Mat data;
    cv::Mat reduced;


    while(ros::ok()){

        if(!depth_mat.empty()) {

            data = cv::Mat(depth_mat.size(), depth_mat.type());
            data = depth_mat.reshape(1, depth_mat.rows * depth_mat.cols);
            kmeans(data, K, labels, cv::TermCriteria(), 1, cv::KMEANS_PP_CENTERS, colors);

            for (int i = 0; i < depth_mat.cols * depth_mat.rows; ++i)
            {
                data.at<float>(i, 0) = colors(labels[i], 0);
                data.at<float>(i, 1) = colors(labels[i], 1);
                data.at<float>(i, 2) = colors(labels[i], 2);
            }


            reduced = data.reshape(1, depth_mat.rows);
//            reduced.convertTo(reduced, CV_8U);
            cv::imshow("reduced", reduced);
        }



        loop_rate.sleep();
        ros::spinOnce();
    }

    return 0;
}