//
// Created by osboxes on 8/7/18.
//

#ifndef TISSUERETRACTION_IMAGEPROCESSING_H
#define TISSUERETRACTION_IMAGEPROCESSING_H

#include <opencv2/opencv.hpp>

using namespace cv;
using namespace std;

class ImageProcessing {
public:
    Mat equalizeRGBImage(Mat src);
    Mat kmeansRGB(Mat src);
};


#endif //TISSUERETRACTION_IMAGEPROCESSING_H
