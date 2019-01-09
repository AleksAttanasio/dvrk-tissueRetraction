#!/usr/bin/env python

import time, sys, os
from ros import rosbag
import roslib, rospy
roslib.load_manifest('sensor_msgs')
from sensor_msgs.msg import Image

from cv_bridge import CvBridge
from sensor_msgs.msg import CameraInfo
import cv2
import yaml

TOPIC_R = 'camera/right/image_raw'
TOPIC_L = 'camera/left/image_raw'
YAML_TOPIC_R = 'camera/right/camera_info'
YAML_TOPIC_L = 'camera/left/camera_info'

def CreateVideoBag(videopath_R, videopath_L, bagname, yaml_file_R, yaml_file_L):
    '''Creates a bag file with a video file'''
    bag = rosbag.Bag(bagname, 'w')
    cap_r = cv2.VideoCapture(videopath_R)
    cap_l = cv2.VideoCapture(videopath_L)
    cb = CvBridge()
    prop_fps = 25 
    ret_r = True
    ret_l = True
    frame_id = 0
    count = 0
	# Load data from file
    with open(yaml_file_R, "r") as file_handle:
	calib_data = yaml.load(file_handle)

	camera_info_msg_R = CameraInfo()
	camera_info_msg_R.width = calib_data["image_width"]
	camera_info_msg_R.height = calib_data["image_height"]
	camera_info_msg_R.K = calib_data["camera_matrix"]["data"]
	camera_info_msg_R.D = calib_data["distortion_coefficients"]["data"]
	camera_info_msg_R.R = calib_data["rectification_matrix"]["data"]
	camera_info_msg_R.P = calib_data["projection_matrix"]["data"]
	camera_info_msg_R.distortion_model = calib_data["distortion_model"]
    
    with open(yaml_file_L, "r") as file_handle:
	calib_data = yaml.load(file_handle)

	camera_info_msg_L = CameraInfo()
	camera_info_msg_L.width = calib_data["image_width"]
	camera_info_msg_L.height = calib_data["image_height"]
	camera_info_msg_L.K = calib_data["camera_matrix"]["data"]
	camera_info_msg_L.D = calib_data["distortion_coefficients"]["data"]
	camera_info_msg_L.R = calib_data["rectification_matrix"]["data"]
	camera_info_msg_L.P = calib_data["projection_matrix"]["data"]
	camera_info_msg_L.distortion_model = calib_data["distortion_model"]
	

    #max_frame = max(cap_r.get(CV_CAP_PROP_FRAME_COUNT), cap_l.get(CV_CAP_PROP_FRAME_COUNT))
    #print('Bag will record {} samples'.format(max_frame))

    # for loop for right camera images
    while(ret_l and ret_r):
        ret_l, frame_r = cap_r.read()
	ret_r, frame_l = cap_l.read()

        if not (ret_l and ret_r):
            break

        stamp = rospy.rostime.Time.from_sec(float(frame_id) / prop_fps)
        frame_id += 1

        image_r = cb.cv2_to_imgmsg(frame_r, encoding='bgr8')
        image_r.header.stamp = stamp
        image_r.header.frame_id = "camera"

        image_l = cb.cv2_to_imgmsg(frame_l, encoding='bgr8')
        image_l.header.stamp = stamp
        image_l.header.frame_id = "camera"

        bag.write(TOPIC_R, image_r, stamp)
	bag.write(TOPIC_L, image_l, stamp)
	bag.write(YAML_TOPIC_R, camera_info_msg_R, stamp)
	bag.write(YAML_TOPIC_L, camera_info_msg_L, stamp)

    cap_r.release()
    cap_l.release()
    bag.close()


if __name__ == "__main__":
    if len( sys.argv ) == 6:
        CreateVideoBag(*sys.argv[1:])
    else:
        print( "Usage: stereovideo2bag <videofilename_R> <videofilename_L> <bagfilename> <yaml_file_R_cam> <yaml_file_L_cam>")
