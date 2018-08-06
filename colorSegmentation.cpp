//
// Created by aleks on 8/3/18.
//

#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <iostream>
using namespace cv;
using namespace std;

int main( )
{
    Mat img = imread( "resources/test_images/laparoscopy.jpg"); // Input image
    Mat clulster_image( img.size(), img.type() ); // Image represented by clusters
    Mat samples(img.rows * img.cols, 3, CV_32F); // Sorted pixel Mat
    Mat labels;
    Mat centers;
    int K = 5; // Number of clusters
    int attempts = 5; // Number of executions

    imshow("Original", img);

    // Reshaping pixels
    for( int y = 0; y < img.rows; y++ )
        for( int x = 0; x < img.cols; x++ )
            for( int z = 0; z < 3; z++) {
                samples.at<float>(y + x*img.rows, z) = img.at<Vec3b>(y,x)[z];
            }

    // Evaluating K-means
    kmeans( samples, K, labels, TermCriteria(CV_TERMCRIT_ITER|CV_TERMCRIT_EPS, 100, 0.01), attempts, KMEANS_PP_CENTERS, centers );



    for( int y = 0; y < img.rows; y++ )
        for( int x = 0; x < img.cols; x++ )
        {
            int cluster_idx = labels.at<int>(y + x*img.rows,0);
            clulster_image.at<Vec3b>(y,x)[0] = centers.at<float>(cluster_idx, 0);
            clulster_image.at<Vec3b>(y,x)[1] = centers.at<float>(cluster_idx, 1);
            clulster_image.at<Vec3b>(y,x)[2] = centers.at<float>(cluster_idx, 2);
        }
    imshow( "Clustered Image", clulster_image );
    waitKey( 0 );
}