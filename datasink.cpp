#include "datasink.h"
#include <QDebug>

DataSink::DataSink(SampleDataSource *src, DataSource * target)
    : _target(target), _source(src)
{
    // qDebug() << "Start timer ...\n";

   _timer = new QTimer(this);
   _timer->setInterval(DEFAULT_INTERVAL);

   QObject::connect(_timer, SIGNAL(timeout()), this, SLOT(copyData()));

   _timer->start();
}

void DataSink::copyData()
{
    // do smthing here
    // qDebug() << "start copy data\n";

    QPointF prP = this->_source->getPressureData();
    QPointF prV = this->_source->getVolumnData();

    this->_target->addVolumData(prV);
    this->_target->addPressureData(prP);

}
