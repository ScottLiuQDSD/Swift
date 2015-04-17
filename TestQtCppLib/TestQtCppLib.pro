#-------------------------------------------------
#
# Project created by QtCreator 2015-03-05T11:11:00
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = TestQtCppLib
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h \
    ../QtCPPLib/qtcpplib.h

FORMS    += mainwindow.ui

macx: LIBS += -L$$PWD/../build-QtCPPLib-Desktop_Qt_5_4_1_clang_64bit-Debug/ -lQtCPPLib

INCLUDEPATH += $$PWD/../build-QtCPPLib-Desktop_Qt_5_4_1_clang_64bit-Debug
DEPENDPATH += $$PWD/../build-QtCPPLib-Desktop_Qt_5_4_1_clang_64bit-Debug
