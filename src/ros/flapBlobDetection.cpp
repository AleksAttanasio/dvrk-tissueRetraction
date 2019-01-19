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

    cv::imshow("Right View", depth_mat_8);
    cv::waitKey(15);
}

int main (int argc, char** argv){

    ros::init(argc, argv, "flap_detection");
    ros::NodeHandle nh;
    ros::Subscriber sub_disp_map= nh.subscribe("/stereo/disparity", 1, &disparityCallback);
    ros::Rate loop_rate(24);

    cv::Mat centers;
    cv::Mat labels;
    cv::Mat output_labels( depth_mat.size(), depth_mat.type() );
    std::vector<cv::KeyPoint> keypoints;
    int kmean_attempts = 5;

    while(ros::ok()){

        if(!depth_mat.empty()) {

            // segmented map to show at the end
            cv::Mat segmented_map(depth_mat.size(), depth_mat.type());

            try {
                // show image
                imshow("Depth Map (8bit)", depth_mat_8);

                // K-mean over the depth map
                cv::kmeans(depth_mat, 5, labels,
                           cv::TermCriteria(CV_TERMCRIT_ITER | CV_TERMCRIT_EPS, 10000, 0.0001),
                           kmean_attempts,
                           cv::KMEANS_PP_CENTERS,
                           centers);

                cout << labels.size << endl;
                for( int y = 0; y < depth_mat.rows; y++ )
                    for( int x = 0; x < depth_mat.cols; x++ )
                    {
                        int cluster_idx = labels.at<int>(y,0);
                        segmented_map.at<float>(y,x) = centers.at<float>(cluster_idx);
                    }
                imshow( "clustered image", segmented_map );

            }
            catch (cv::Exception e) {
                ROS_INFO("Exception thrown!");
            }
        }
        loop_rate.sleep();
        ros::spinOnce();
    }

    return 0;
}