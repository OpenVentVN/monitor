#ifndef DATASINK_H
#define DATASINK_H

#include <QObject>
#include <QTimer>

#include "datasource.h"
#include "sampledatasource.h"

#define DEFAULT_INTERVAL 100

class DataSink :  public QObject
{
    Q_OBJECT
public:
    DataSink(SampleDataSource *src, DataSource * target);

public slots:
    void copyData();

private:
    DataSource          *_target;
    SampleDataSource    *_source;

    QTimer              *_timer;

};

#endif // DATASINK_H
