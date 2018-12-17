#! /usr/bin/env python

from PyQt4 import QtGui, QtCore
import sys
import rospy
from rosapi.srv import Topics, Publishers
import numpy as np
import time
import os
import cv2
from std_msgs.msg import String
from sensor_msgs.msg import Image, JointState
from cv_bridge import CvBridge, CvBridgeError
import dvrk_gui_struct


class dvrKTrialRec(QtGui.QMainWindow, dvrk_gui_struct.Ui_MainFrame):
    
    def __init__(self, parent=None):
        super(dvrKTrialRec, self).__init__(parent)
        self.joint_values = 0
        self.setupUi(self)
        self.rec_button.clicked.connect(self.record_trial)


        rospy.init_node('dvrk_gui', anonymous=True)
        self.kinematics_sub = rospy.Subscriber("/dvrk/PSM1/io/joint_position", JointState, self.kinematicDataCallback)

    def record_trial(self):
        print self.joint_values

    
    def kinematicDataCallback(self, msg):
        joint_values = msg.position[1]


    def leftCameraCallback(self, msg):
        self.cv_image = self.br.imgmsg_to_cv2(msg, "bgr8")
        cv2.waitKey(3)

def main():
    app = QtGui.QApplication(sys.argv)
    window = dvrKTrialRec()
    window.show()
    sys.exit(app.exec_())

if __name__ == '__main__':
    main()


