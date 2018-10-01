//
// Created by aleks on 8/3/18.
//

#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "ImageProcessing.h"
#include <iostream>

#define CLUSTER_K 5
#define KMEANS_ATTEMPTS 5

using namespace cv;
using namespace std;

int main( )
{
    ImageProcessing IP;
    Mat img = imread( "resources/test_images/laparoscopy.jpg"); // Input image
    Mat equalized_img;                                          // Equalized image
    Mat cluster_image( img.size(), img.type() );                // Image represented by clusters
    Mat samples(img.rows * img.cols, 3, CV_32F);                // Sorted pixel Mat
    Mat labels;                                                 // Cluster labels
    Mat centers;                                                // Centers of means
    int K = CLUSTER_K;                                          // Number of clusters
    int attempts = KMEANS_ATTEMPTS;                             // Number of executions

    imshow("Original", img);
    imshow("Equalized", IP.equalizeRGBImage(img));

    // Reshaping pixels
    for( int y = 0; y < img.rows; y++ )
        for( int x = 0; x < img.cols; x++ )
            for( int z = 0; z < 3; z++) {

                samples.at<float>(y + x*img.rows, z) = img.at<Vec3b>(y,x)[z];

            }

    // Evaluating K-means
    kmeans( samples,
            K,
            labels,
            TermCriteria(CV_TERMCRIT_ITER|CV_TERMCRIT_EPS, 100, 0.01),
            attempts,
            KMEANS_PP_CENTERS  ,
            centers );

    // Colorize clusters
    for( int y = 0; y < img.rows; y++ )
        for( int x = 0; x < img.cols; x++ )
        {
            int cluster_idx = labels.at<int>(y + x*img.rows,0);
            cluster_image.at<Vec3b>(y,x)[0] = centers.at<float>(cluster_idx, 0);
            cluster_image.at<Vec3b>(y,x)[1] = centers.at<float>(cluster_idx, 1);
            cluster_image.at<Vec3b>(y,x)[2] = centers.at<float>(cluster_idx, 2);
        }

    imshow( "Clustered Image", cluster_image );
    imshow( "Clustered Equalized Image", IP.equalizeRGBImage(cluster_image) );


    waitKey( 0 );
}