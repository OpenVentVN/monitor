#ifndef DATASINKSERIAL_H
#define DATASINKSERIAL_H

#include <QObject>
#include <QTimer>

#include "datasource.h"
#include "serialdatasource.h"

#define DEFAULT_INTERVAL 100

class DataSinkSerial : public QObject
{
    Q_OBJECT
public:
   DataSinkSerial(SerialDataSource *src, DataSource * target);

signals:

public slots:

public slots:
    void copyData();



private:
    DataSource          *_target;
    SerialDataSource    *_source;

    QTimer              *_timer;

};

#endif // DATASINKSERIAL_H
