#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "../QtCPPLib/qtcpplib.h"
#include <QDebug>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QtCPPLib lib;
    int value = lib.add(4, 7);
    qDebug() << "value is " << value;
}

MainWindow::~MainWindow()
{
    delete ui;
}
