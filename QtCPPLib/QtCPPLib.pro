#-------------------------------------------------
#
# Project created by QtCreator 2015-03-05T10:28:28
#
#-------------------------------------------------

QT       -= gui

TARGET = QtCPPLib
TEMPLATE = lib

DEFINES += QTCPPLIB_LIBRARY

SOURCES += qtcpplib.cpp

HEADERS += qtcpplib.h\
        qtcpplib_global.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}
