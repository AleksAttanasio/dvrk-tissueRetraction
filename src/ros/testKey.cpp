#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/ximgproc.hpp"
#include <ros/ros.h>

using namespace std;

int main( int argc, char** argv )
{
    string inizio = "nel mezzo del";
    string medio = "cammin";
    string fine = "nostravita";

    string aaa = inizio + fine + medio;
    cout << aaa << endl;

    return 0;
}