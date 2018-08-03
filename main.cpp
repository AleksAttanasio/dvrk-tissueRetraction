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
    img_left = imread("resources/test_images/ambush_5_left.jpg");
    img_right = imread("resources/test_images/ambush_5_right.jpg");

    // Check size of images
    if ( img_right.empty() || img_left.empty())
    {
        cout << "Cannot read image file" << endl;
        return -1;
    }

    // Conversion to grayscale images to ease the process
    cvtColor(img_left, g_left, CV_BGR2GRAY);
    cvtColor(img_right, g_right, CV_BGR2GRAY);

    // Create Stereo filter
    Ptr<StereoBM> sbm = StereoBM::create(0, // int numDisparities = 0
                                         21); // int blockSize = 21

    // H. Hirschmuller algorithm
    Ptr<StereoSGBM> sgbm = StereoSGBM::create(0,    //int minDisparity /0
                                              96,     //int numDisparities / 96
                                              5,      //int SADWindowSize / 5
                                              600,    //int P1 = 0 / 600
                                              2400,   //int P2 = 0 / 2400
                                              10,     //int disp12MaxDiff = 0 / 10
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