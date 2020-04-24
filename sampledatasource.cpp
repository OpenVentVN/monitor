#include "sampledatasource.h"
#include <QObject>
#include <QMutex>
#include <QFile>
#include <QTextStream>
#include <QDebug>


QPointF pressureDataSample[] =
{
       QPointF(15, 0.1), QPointF(16, 0.2), QPointF(17, 0.3), QPointF(18, 0.4), QPointF(19, 0.5), QPointF(20, 0.6), QPointF(21, 0.7), QPointF(22, 0.8), QPointF(23, 0.9), QPointF(24, 1.0),
       QPointF(20, 1.1), QPointF(20, 1.2), QPointF(20, 1.3), QPointF(20, 1.4), QPointF(20, 1.5), QPointF(10, 1.6), QPointF(10, 1.7), QPointF(10, 1.8), QPointF(10, 1.9), QPointF(10, 2.0),
       QPointF(10, 2.1), QPointF(10, 2.2), QPointF(10, 2.3), QPointF(10, 2.4), QPointF(10, 2.5), QPointF(10, 2.6), QPointF(10, 2.7), QPointF(10, 2.8), QPointF(10, 2.9), QPointF(10, 3.0),
       QPointF(10, 3.1), QPointF(10, 3.2), QPointF(10, 3.3), QPointF(10, 3.4), QPointF(10, 3.5), QPointF(10, 3.6), QPointF(10, 3.7), QPointF(10, 3.8), QPointF(10, 3.9), QPointF(10, 4.0),

    // line 2
       QPointF(15, 4.1), QPointF(16, 4.2), QPointF(17, 4.3), QPointF(18, 4.4), QPointF(19, 4.5), QPointF(20, 4.6), QPointF(21, 4.7), QPointF(22, 4.8), QPointF(23, 4.9), QPointF(24, 5.0),
       QPointF(20, 5.1), QPointF(20, 5.2), QPointF(20, 5.3), QPointF(20, 5.4), QPointF(20, 5.5), QPointF(10, 5.6), QPointF(10, 5.7), QPointF(10, 5.8), QPointF(10, 5.9), QPointF(10, 6.0),
       QPointF(10, 6.1), QPointF(10, 6.2), QPointF(10, 6.3), QPointF(10, 6.4), QPointF(10, 6.5), QPointF(10, 6.6), QPointF(10, 6.7), QPointF(10, 6.8), QPointF(10, 6.9), QPointF(10, 7.0),
       QPointF(10, 7.1), QPointF(10, 7.2), QPointF(10, 7.3), QPointF(10, 7.4), QPointF(10, 7.5), QPointF(10, 7.6), QPointF(10, 7.7), QPointF(10, 7.8), QPointF(10, 7.9), QPointF(10, 8.0),

    // line 3
       QPointF(15, 8.1), QPointF(16, 8.2), QPointF(17, 8.3), QPointF(18, 8.4), QPointF(19, 8.5), QPointF(20, 8.6), QPointF(21, 8.7), QPointF(22, 8.8), QPointF(23, 8.9), QPointF(24, 9.0),
       QPointF(20, 9.1), QPointF(20, 9.2), QPointF(20, 9.3), QPointF(20, 9.4), QPointF(20, 9.5), QPointF(10, 9.6), QPointF(10, 9.7), QPointF(10, 9.8), QPointF(10, 9.9), QPointF(10, 10.0),
       QPointF(10, 10.1), QPointF(10, 10.2), QPointF(10, 10.3), QPointF(10, 10.4), QPointF(10, 10.5), QPointF(10, 10.6), QPointF(10, 10.7), QPointF(10, 10.8), QPointF(10, 10.9), QPointF(10, 11.0),
       QPointF(10, 11.1), QPointF(10, 11.2), QPointF(10, 11.3), QPointF(10, 11.4), QPointF(10, 11.5), QPointF(10, 11.6), QPointF(10, 11.7), QPointF(10, 11.8), QPointF(10, 11.9), QPointF(10, 12.0)

};

QPointF volumnDataSample[] =
{
       QPointF(0, 0.0),
       QPointF(50, 0.1), QPointF(100, 0.2), QPointF(150, 0.3), QPointF(200, 0.4), QPointF(250, 0.5), QPointF(300, 0.6), QPointF(350, 0.7), QPointF(400, 0.8), QPointF(400, 0.9), QPointF(400, 1.0),
       QPointF(400, 1.1), QPointF(400, 1.2), QPointF(400, 1.3), QPointF(350, 1.4), QPointF(300, 1.5), QPointF(250, 1.6), QPointF(200, 1.7), QPointF(180, 1.8), QPointF(160, 1.9), QPointF(140, 2.0),
       QPointF(120, 2.1), QPointF(100, 2.2), QPointF(80, 2.3), QPointF(60, 2.4), QPointF(50, 2.5), QPointF(40, 2.6), QPointF(30, 2.7), QPointF(20, 2.8), QPointF(10, 2.9), QPointF(0, 3.0),
       QPointF(50, 3.1), QPointF(100, 3.2), QPointF(150, 3.3), QPointF(200, 3.4), QPointF(250, 3.5), QPointF(300, 3.6), QPointF(350, 3.7), QPointF(400, 3.8), QPointF(400, 3.9), QPointF(400, 4.0),

   // line 2
       QPointF(400, 4.1), QPointF(400, 4.2), QPointF(400, 4.3), QPointF(350, 4.4), QPointF(300, 4.5), QPointF(250, 4.6), QPointF(200, 4.7), QPointF(180, 4.8), QPointF(160, 4.9), QPointF(140, 5.0),
       QPointF(120, 5.1), QPointF(100, 5.2), QPointF(80, 5.3), QPointF(60, 5.4), QPointF(50, 5.5), QPointF(40, 5.6), QPointF(30, 5.7), QPointF(20, 5.8), QPointF(10, 5.9), QPointF(0, 6.0),
       QPointF(10, 6.1), QPointF(10, 6.2), QPointF(10, 6.3), QPointF(10, 6.4), QPointF(10, 6.5), QPointF(10, 6.6), QPointF(10, 6.7), QPointF(10, 6.8), QPointF(10, 6.9), QPointF(10, 7.0),
       QPointF(10, 7.1), QPointF(10, 7.2), QPointF(10, 7.3), QPointF(10, 7.4), QPointF(10, 7.5), QPointF(10, 7.6), QPointF(10, 7.7), QPointF(10, 7.8), QPointF(10, 7.9), QPointF(10, 8.0),

   // line 3
       QPointF(50, 8.1), QPointF(100, 8.2), QPointF(150, 8.3), QPointF(150, 8.4), QPointF(200, 8.5), QPointF(250, 8.6), QPointF(300, 8.7), QPointF(300, 8.8), QPointF(350, 8.9), QPointF(400, 9.0),
       QPointF(400, 9.1), QPointF(400, 9.2), QPointF(400, 9.3), QPointF(350, 9.4), QPointF(300, 9.5), QPointF(250, 9.6), QPointF(200, 9.7), QPointF(180, 9.8), QPointF(160, 9.9), QPointF(140, 10.0),
       QPointF(120, 10.1), QPointF(100, 10.2), QPointF(80, 10.3), QPointF(60, 10.4), QPointF(50, 10.5), QPointF(40, 10.6), QPointF(30, 10.7), QPointF(20, 10.8), QPointF(10, 10.9), QPointF(10, 11.0),
       QPointF(10, 11.1), QPointF(10, 11.2), QPointF(10, 11.3), QPointF(10, 11.4), QPointF(10, 11.5), QPointF(10, 11.6), QPointF(10, 11.7), QPointF(10, 11.8), QPointF(10, 11.9), QPointF(10, 12.0)

};


QVector<QPointF> pressureSensorData;

SampleDataSource::SampleDataSource()
{
    _internalPressureCounter = 0;
    _internalVolumnCounter = 0;


    QFile inputFile("://data/TEST_V800T1000F15.txt");

    if (inputFile.open(QIODevice::ReadOnly))
    {
       QTextStream in(&inputFile);
       int lastmsTime = 0;
       int count = 0;
       while (!in.atEnd())
       {
          QString line = in.readLine();
          //qDebug() << line;

          QRegExp rx("[, ]");// match a comma or a space
          QStringList list = line.split(rx, QString::SkipEmptyParts);
          //qDebug() << list;

          if (list.count() == 4)
          {
              // QString type = list.at(0);
              // QString sensorType = list.at(1);
              // QString sensorPostition = list.at(2);

              QString sensorDataString = list.at(2);
              QString sensorDataTimeString = list.at(3);

              QPointF point;

              point.setY(sensorDataString.toInt());

              // lastmsTime = sensorDataTimeString.toInt();
              if (count == 0)
              {
                  lastmsTime = sensorDataTimeString.toInt();
              }

              count++;
//              qDebug() << "Count = " << count << "," << sensorDataTimeString.toInt() - lastmsTime;

              // qDebug() << lastmsTime;

              point.setX((float) (sensorDataTimeString.toInt() - lastmsTime)/10);

              // qDebug() << point;

              pressureSensorData.push_back(point);

          }


       }
       inputFile.close();
    }
    else
    {
        qDebug() << "Openfile error";
    }

}

QPointF SampleDataSource::getPressureData()
{

//    QPointF p = pressureDataSample[this->_internalPressureCounter++];

//    if (_internalPressureCounter == 120 /*sizeof(pressureDataSample)/sizeof(QPointF)*/)
//        _internalPressureCounter = 0;

//    QPointF p2;
//    p2.setX(p.y());
//    p2.setY(p.x());

//    return p2;


    if (_internalPressureCounter >= 150)
        _internalPressureCounter = 150;

    return pressureSensorData.at(_internalPressureCounter++);

}

QPointF SampleDataSource::getVolumnData()
{
    QPointF p = volumnDataSample[this->_internalVolumnCounter++];

    if (_internalVolumnCounter == 120 /*sizeof(volumnDataSample)/sizeof(QPointF)*/ )
        _internalVolumnCounter = 0;

    QPointF p2;
    p2.setX(p.y());
    p2.setY(p.x());

    return p2;
}
