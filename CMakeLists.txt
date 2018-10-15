cmake_minimum_required(VERSION 2.8.3)
project(dvrk-tissueRetraction)

find_package(Curses REQUIRED)

find_package(
		catkin REQUIRED COMPONENTS
		roscpp
		cv_bridge
		image_geometry
		image_transport
)


include(/opt/opencv-3.4.3/build/OpenCVConfig.cmake)
set(OpenCV_INCLUDE_DIR ${OPENCV_INCLUDE_DIR})

include_directories(
	${catkin_INCLUDE_DIRS}
	${OpenCV_INCLUDE_DIRS}
	${CURSES_INCLUDE_DIRS}
)

add_executable(video_stream_dummy src/ros/videoStreamDummy.cpp)
add_executable(stereo_img_reader src/ros/stereoImagesReader.cpp)
add_executable(kinematic_data_reader src/ros/kinematicDataReader.cpp)
add_executable(test_key src/ros/testKey.cpp)
add_executable(joint_state_dummy src/ros/jointStateDummy.cpp)
add_executable(video_trial_recorder src/ros/videoTrialRecorder.cpp)

target_link_libraries(video_stream_dummy ${OpenCV_LIBRARIES} ${catkin_LIBRARIES})
target_link_libraries(stereo_img_reader ${OpenCV_LIBRARIES} ${catkin_LIBRARIES})
target_link_libraries(kinematic_data_reader ${catkin_LIBRARIES} ${CURSES_LIBRARIES})
target_link_libraries(test_key ${catkin_LIBRARIES} ${CURSES_LIBRARIES})
target_link_libraries(joint_state_dummy ${catkin_LIBRARIES} ${CURSES_LIBRARIES})
target_link_libraries(video_trial_recorder ${OpenCV_LIBRARIES} ${catkin_LIBRARIES})




