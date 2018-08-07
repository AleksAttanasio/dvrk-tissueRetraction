//
// Created by osboxes on 8/7/18.
//

#include "ImageProcessing.h"

#include <opencv2/imgproc/imgproc.hpp>
#include "opencv2/highgui/highgui.hpp"

Mat ImageProcessing::equalizeRGBImage(Mat src) {

    if(src.channels() >= 3)
    {
        Mat ycrcb;

        cvtColor(src,ycrcb,CV_BGR2YCrCb);

        vector<Mat> channels;
        split(ycrcb,channels);

        equalizeHist(channels[0], channels[0]);

        Mat result;
        merge(channels,ycrcb);

        cvtColor(ycrcb,result,CV_YCrCb2BGR);

        return result;
    }
    return Mat();
}