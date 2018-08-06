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
    img_left = imread("resources/test_images/test_left.png");
    img_right = imread("resources/test_images/test_right.png");

    // Check size of images
    if ( img_right.empty() || img_left.empty()) {
        cout << "Cannot read image file" << endl;
        return -1;
    }

    imshow("left",img_left);
    imshow("right",img_right);


    // Conversion to grayscale images to ease the process
    cvtColor(img_left, g_left, CV_BGR2GRAY);
    cvtColor(img_right, g_right, CV_BGR2GRAY);

    // Create Stereo filter
    int numDisparities = 5;
    int P1 = 8*numDisparities*numDisparities;
    int P2 = 32*numDisparities*numDisparities+3000;
    Ptr<StereoBM> sbm = StereoBM::create(0, // int numDisparities = 0
                                         21); // int blockSize = 21

    // H. Hirschmuller algorithm
    Ptr<StereoSGBM> sgbm = StereoSGBM::create(0,    //int minDisparity /0
                                              32,     //int numDisparities / 96
                                              numDisparities,      //int SADWindowSize / 5
                                              P1,    //int P1 = 0 / 600
                                              P2,   //int P2 = 0 / 2400
                                              0,     //int disp12MaxDiff = 0 / 10
                                              16,     //int preFilterCap = 0 / 16
                                              2,      //int uniquenessRatio = 0 / 2
                                              20,    //int speckleWindowSize = 0 / 20
                                              30,     //int speckleRange = 0 / 30
                                              true);  //bool fullDP = false / true

    // Applying stereo filter and normalize
    sgbm->compute(g_left, g_right, disp);
    normalize(disp, disp8, 0, 255, CV_MINMAX, CV_8U);

    // Show disparity map
    imshow("Disparity Map", disp8);

    waitKey(0);
    return 0;
}