cmake_minimum_required(VERSION 3.12)
project(tissueRetraction)

set(CMAKE_CXX_STANDARD 11)
find_package(OpenCV REQUIRED)

add_executable(tissueRetraction main.cpp)
add_executable(disparityMap disparityMap.cpp)
add_executable(cameraCalibration cameraCalibration.cpp)
add_executable(colorSegmentation colorSegmentation.cpp ShowImages.cpp ShowImages.h ImageProcessing.cpp ImageProcessing.h)

target_link_libraries(tissueRetraction ${OpenCV_LIBS})
target_link_libraries(disparityMap ${OpenCV_LIBS})
target_link_libraries(cameraCalibration ${OpenCV_LIBS})