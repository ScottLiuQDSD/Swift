#include "qtcpplib.h"
#include <QDebug>


QtCPPLib::QtCPPLib()
{
}
int QtCPPLib::add(int x, int y)
{
    int value = x+y;
    qDebug() << "result is %d" << value;
    return value;
}
