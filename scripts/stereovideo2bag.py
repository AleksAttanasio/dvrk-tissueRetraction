#!/usr/bin/env python

import time, sys, os
from ros import rosbag
import roslib, rospy
roslib.load_manifest('sensor_msgs')
from sensor_msgs.msg import Image

from cv_bridge import CvBridge
import cv2

TOPIC_R = 'camera/right/image_raw'
TOPIC_L = 'camera/left/image_raw'

def CreateVideoBag(videopath_R, videopath_L, bagname):
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

    cap_r.release()
    cap_l.release()
    bag.close()


if __name__ == "__main__":
    if len( sys.argv ) == 4:
        CreateVideoBag(*sys.argv[1:])
    else:
        print( "Usage: stereovideo2bag <videofilename_R> <videofilename_L> <bagfilename> ")
