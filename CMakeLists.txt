cmake_minimum_required(VERSION 3.12)
project(tissueRetraction)

set(CMAKE_CXX_STANDARD 11)
find_package(OpenCV REQUIRED)

add_executable(tissueRetraction main.cpp)

target_link_libraries(tissueRetraction ${OpenCV_LIBS})