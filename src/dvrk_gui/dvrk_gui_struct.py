# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'dvrk_trial_record.ui'
#
# Created by: PyQt4 UI code generator 4.11.4
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_MainFrame(object):
    def setupUi(self, MainFrame):
        MainFrame.setObjectName(_fromUtf8("MainFrame"))
        MainFrame.resize(831, 353)
        self.rec_button = QtGui.QPushButton(MainFrame)
        self.rec_button.setGeometry(QtCore.QRect(180, 90, 41, 41))
        font = QtGui.QFont()
        font.setPointSize(16)
        self.rec_button.setFont(font)
        self.rec_button.setObjectName(_fromUtf8("rec_button"))
        self.play_pause_button = QtGui.QPushButton(MainFrame)
        self.play_pause_button.setGeometry(QtCore.QRect(120, 90, 51, 41))
        font = QtGui.QFont()
        font.setPointSize(16)
        self.play_pause_button.setFont(font)
        self.play_pause_button.setObjectName(_fromUtf8("play_pause_button"))
        self.stop_button = QtGui.QPushButton(MainFrame)
        self.stop_button.setGeometry(QtCore.QRect(230, 90, 51, 41))
        font = QtGui.QFont()
        font.setPointSize(16)
        self.stop_button.setFont(font)
        self.stop_button.setObjectName(_fromUtf8("stop_button"))
        self.cam_1_topic = QtGui.QLineEdit(MainFrame)
        self.cam_1_topic.setGeometry(QtCore.QRect(100, 20, 271, 21))
        self.cam_1_topic.setObjectName(_fromUtf8("cam_1_topic"))
        self.left_camera_view = QtGui.QGraphicsView(MainFrame)
        self.left_camera_view.setGeometry(QtCore.QRect(440, 50, 360, 288))
        self.left_camera_view.setObjectName(_fromUtf8("left_camera_view"))
        self.label = QtGui.QLabel(MainFrame)
        self.label.setGeometry(QtCore.QRect(10, 20, 81, 17))
        self.label.setObjectName(_fromUtf8("label"))
        self.widget = QtGui.QWidget(MainFrame)
        self.widget.setGeometry(QtCore.QRect(440, 10, 362, 29))
        self.widget.setObjectName(_fromUtf8("widget"))
        self.horizontalLayout = QtGui.QHBoxLayout(self.widget)
        self.horizontalLayout.setObjectName(_fromUtf8("horizontalLayout"))
        self.left_camera_label = QtGui.QLabel(self.widget)
        self.left_camera_label.setObjectName(_fromUtf8("left_camera_label"))
        self.horizontalLayout.addWidget(self.left_camera_label)
        self.topic_list = QtGui.QComboBox(self.widget)
        self.topic_list.setMinimumSize(QtCore.QSize(231, 27))
        self.topic_list.setObjectName(_fromUtf8("topic_list"))
        self.horizontalLayout.addWidget(self.topic_list)

        self.retranslateUi(MainFrame)
        QtCore.QMetaObject.connectSlotsByName(MainFrame)

    def retranslateUi(self, MainFrame):
        MainFrame.setWindowTitle(_translate("MainFrame", "dVRK Trial Recorder", None))
        self.rec_button.setText(_translate("MainFrame", "⏺️", None))
        self.play_pause_button.setText(_translate("MainFrame", "⏯️", None))
        self.stop_button.setText(_translate("MainFrame", "⏹", None))
        self.label.setText(_translate("MainFrame", "Save trial as", None))
        self.left_camera_label.setText(_translate("MainFrame", "Left Camera topic", None))

