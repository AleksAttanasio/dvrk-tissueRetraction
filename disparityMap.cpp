//
// Created by aleks on 8/3/18.
//

#include "opencv2/core/core.hpp"
#include "opencv2/calib3d/calib3d.hpp"
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <stdio.h>
#include <iostream>

using namespace cv;
using namespace std;

int main() {

    Mat img_left, img_right;
    Mat g_left, g_right;
    Mat disp, disp8;

    // Loading images
    img_left = imread("resources/test_images/dvrk/cap_left.png");
    img_right = imread("resources/test_images/dvrk/cap_right.png");

    // Check size of images
    if ( img_right.empty() || img_left.empty()) {
        cout << "Cannot read image file" << endl;
        return -1;
    }

//    imshow("left",img_left);
    imshow("right",img_right);


    // Conversion to grayscale images to ease the process
    cvtColor(img_left, g_left, CV_BGR2GRAY);
    cvtColor(img_right, g_right, CV_BGR2GRAY);

    // Create Stereo filter
    int numDisparities = 6;
    int P1 = 8*numDisparities*numDisparities;
    int P2 = 32*numDisparities*numDisparities;
    Ptr<StereoBM> sbm = StereoBM::create(96, // int numDisparities = 0
                                         35); // int blockSize = 21

    // H. Hirschmuller algorithm

    Ptr<StereoSGBM> sgbm = StereoSGBM::create(-70,      //int minDisparity /0
                                              48,     //int numDisparities / 96
                                              9,      //int blockSize = 3,
                                              P1,    //int P1 = 0 / 600
                                              P2,   //int P2 = 0 / 2400
                                              0,     //int disp12MaxDiff = 0 / 10
                                              12,     //int preFilterCap = 0 / 16
                                              7,      //int uniquenessRatio = 0 / 2 (range 5:15)
                                              5,    //int speckleWindowSize = 0 / 20 (range 50:200)
                                              1,     //int speckleRange = 0 / 30 (range 1:2)
                                              StereoSGBM::MODE_SGBM);

//    Ptr<StereoSGBM> sgbm = StereoSGBM::create(0,    //int minDisparity /0
//                                              16,     //int numDisparities / 96

//                                              numDisparities,      //int SADWindowSize / 5
//                                              P1,    //int P1 = 0 / 600
//                                              P2,   //int P2 = 0 / 2400
//                                              10,     //int disp12MaxDiff = 0 / 10
//                                              16,     //int preFilterCap = 0 / 16
//                                              8,      //int uniquenessRatio = 0 / 2 (range 5:15)
//                                              100,    //int speckleWindowSize = 0 / 20 (range 50:200)
//                                              10,     //int speckleRange = 0 / 30 (range 1:2)
//                                              true);  //bool fullDP = false / true

    // Applying stereo filter and normalize
    sgbm->compute(g_left, g_right, disp);
    normalize(disp, disp8, 0, 255, CV_MINMAX, CV_8U);

    // Show disparity map
    imshow("Disparity Map", disp8);

    waitKey(0);
    return 0;
}