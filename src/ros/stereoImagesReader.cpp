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

cv_bridge::CvImagePtr cv_left_ptr (new cv_bridge::CvImage);
cv_bridge::CvImagePtr cv_right_ptr (new cv_bridge::CvImage);


void rightImageCallback(const sensor_msgs::ImageConstPtr msg) {

    try {
//        Visualize images
//         cv::imshow("view", cv_bridge::toCvCopy(msg, "bgr8")->image);
        cv_right_ptr = cv_bridge::toCvCopy(msg, "bgr8");
        cv::waitKey(30);
    }
    catch (cv_bridge::Exception& e) {

        ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());

    }
}

void leftImageCallback(const sensor_msgs::ImageConstPtr msg) {

    try {
//        Visualize images
//         cv::imshow("view", cv_bridge::toCvCopy(msg, "bgr8")->image);
         cv_left_ptr = cv_bridge::toCvCopy(msg, "bgr8");
         cv::waitKey(30);
    }
    catch (cv_bridge::Exception& e) {

        ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());

    }
}

int main(int argc, char **argv){

    // Variables
    int image_cnt = 0;
    string left_img_sub_topic_name = "/camera_dummy/image_left";
    string right_img_sub_topic_name = "camera_dummy/image_right";
    stringstream ss_left;
    stringstream ss_right;

    // Ros node, subs and pubs initialization
    ros::init(argc, argv, "stereo_img_reader");
    ros::NodeHandle nh;
    image_transport::ImageTransport it(nh);
    image_transport::Subscriber left_img_sub = it.subscribe(left_img_sub_topic_name, 1, &leftImageCallback);
    image_transport::Subscriber right_img_sub = it.subscribe(right_img_sub_topic_name, 1, &rightImageCallback);
    ros::Rate loop_rate(10);

    // If image is correctly read from topic print this
    if(cv_left_ptr->image.size > 0){ ROS_INFO("Image read successfully from topic %s", left_img_sub_topic_name.c_str()); }
    if(cv_right_ptr->image.size > 0){ ROS_INFO("Image read successfully from topic %s", right_img_sub_topic_name.c_str()); }

    // Instruction
    ROS_INFO("Enter \"A\" and ENTER to aqcuire streo pair or \"Q\" to quit.");

    // Node loop
    while(ros::ok()){

        // Variables init
        int entered_char = getchar(); // wait for user to type a char
        cv::waitKey(30);

        // If button pressed is "A" then save stereo pair.
        if(entered_char == 97) {
            if (!cv_left_ptr->image.empty()) {

                //Create new image name and save it
                ss_left << "resources/stereo_pairs/img_L_" << image_cnt << ".bmp";
                ss_right << "resources/stereo_pairs/img_R_" << image_cnt << ".bmp";

                cv::imwrite(ss_left.str().c_str(), cv_left_ptr->image);
                cv::imwrite(ss_right.str().c_str(), cv_right_ptr->image);
                image_cnt++;

                ROS_INFO("---> Image correctly saved with name:\n"
                         "%s\n"
                         "%s\n",
                         ss_left.str().c_str(), ss_right.str().c_str());

                ss_left.str(std::string());
                ss_right.str(std::string());
            }
        }

        // If button pressed is "Q" then quit routine and exit ROS while
        if (entered_char == 113){

            ROS_INFO("QUITTING...");
            break;
        }

        loop_rate.sleep();
        ros::spinOnce();
    }

    return 0;
}