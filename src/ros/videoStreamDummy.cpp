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

    using namespace cv;

    int main( int argc, char** argv )
    {
        Mat src = imread( argv[1], 1 );
        Mat samples(src.rows * src.cols, 3, CV_32F);
        for( int y = 0; y < src.rows; y++ )
            for( int x = 0; x < src.cols; x++ )
                for( int z = 0; z < 3; z++)
                    samples.at<float>(y + x*src.rows, z) = src.at<Vec3b>(y,x)[z];


        int clusterCount = 15;
        Mat labels;
        int attempts = 5;
        Mat centers;
        kmeans(samples, clusterCount, labels, TermCriteria(CV_TERMCRIT_ITER|CV_TERMCRIT_EPS, 10000, 0.0001), attempts, KMEANS_PP_CENTERS, centers );


        Mat new_image( src.size(), src.type() );
        for( int y = 0; y < src.rows; y++ )
            for( int x = 0; x < src.cols; x++ )
            {
                int cluster_idx = labels.at<int>(y + x*src.rows,0);
                new_image.at<Vec3b>(y,x)[0] = centers.at<float>(cluster_idx, 0);
                new_image.at<Vec3b>(y,x)[1] = centers.at<float>(cluster_idx, 1);
                new_image.at<Vec3b>(y,x)[2] = centers.at<float>(cluster_idx, 2);
            }
        imshow( "clustered image", new_image );
        waitKey( 0 );
    }
    int pub_rate = 10;
    char cwd[1024];
    getcwd(cwd, sizeof(cwd));
    string node_name = "camera_dummy";
    string left_camera_topic_name = "/camera_dummy/image_left";
    string right_camera_topic_name = "/camera_dummy/image_right";
    string left_img_path = "resources/images/dummies_test/dvrk_2.png";
    string right_img_path = "resources/images/dummies_test/tree.jpg";

    ros::init(argc, argv, node_name);
    ros::NodeHandle nh;
    image_transport::ImageTransport it(nh);
    image_transport::Publisher left_img_pub = it.advertise(left_camera_topic_name, 1);
    image_transport::Publisher right_img_pub = it.advertise(right_camera_topic_name, 1);

    cv::Mat left_image = cv::imread(left_img_path, CV_LOAD_IMAGE_COLOR);
    cv::Mat right_image = cv::imread(right_img_path, CV_LOAD_IMAGE_COLOR);
    cv::waitKey(30);

    sensor_msgs::ImagePtr left_img_msg = cv_bridge::CvImage(std_msgs::Header(), "bgr8", left_image).toImageMsg();
    sensor_msgs::ImagePtr right_img_msg = cv_bridge::CvImage(std_msgs::Header(), "bgr8", right_image).toImageMsg();

    ros::Rate loop_rate(pub_rate);

    // Information and confirm
    ROS_INFO("Publishing sample images at %d Hz on:\n"
             "%s\n"
             "%s\n"
             "Image Right (R): %s\n"
             "Image Left (L): %s\n"
             "CWS: %s\n",
             pub_rate, left_camera_topic_name.c_str(), right_camera_topic_name.c_str() , right_img_path.c_str(),
             left_img_path.c_str(), cwd);

    while (nh.ok())
    {
        // Publishing images on two different topics
        left_img_pub.publish(left_img_msg);
        right_img_pub.publish(right_img_msg);
        ros::spinOnce();
        loop_rate.sleep();
    }

    return 0;
}
