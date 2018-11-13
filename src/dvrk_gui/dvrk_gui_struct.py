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
        MainFrame.resize(467, 300)
        self.rec_button = QtGui.QPushButton(MainFrame)
        self.rec_button.setGeometry(QtCore.QRect(70, 60, 41, 41))
        font = QtGui.QFont()
        font.setPointSize(16)
        self.rec_button.setFont(font)
        self.rec_button.setObjectName(_fromUtf8("rec_button"))
        self.play_pause_button = QtGui.QPushButton(MainFrame)
        self.play_pause_button.setGeometry(QtCore.QRect(10, 60, 51, 41))
        font = QtGui.QFont()
        font.setPointSize(16)
        self.play_pause_button.setFont(font)
        self.play_pause_button.setObjectName(_fromUtf8("play_pause_button"))
        self.stop_button = QtGui.QPushButton(MainFrame)
        self.stop_button.setGeometry(QtCore.QRect(120, 60, 51, 41))
        font = QtGui.QFont()
        font.setPointSize(16)
        self.stop_button.setFont(font)
        self.stop_button.setObjectName(_fromUtf8("stop_button"))

        self.retranslateUi(MainFrame)
        QtCore.QMetaObject.connectSlotsByName(MainFrame)

    def retranslateUi(self, MainFrame):
        MainFrame.setWindowTitle(_translate("MainFrame", "dVRK Trial Recorder", None))
        self.rec_button.setText(_translate("MainFrame", "⏺️", None))
        self.play_pause_button.setText(_translate("MainFrame", "⏯️", None))
        self.stop_button.setText(_translate("MainFrame", "⏹", None))

