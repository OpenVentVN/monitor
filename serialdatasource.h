#ifndef SERIALREADER_H
#define SERIALREADER_H

#include <QObject>
#include <QSerialPort>
#include <QByteArray>
#include "serialportinfor.h"
#include <QList>
#include <QSerialPortInfo>

class SerialDataSource : public QObject
{
    Q_OBJECT


public:
    SerialDataSource();
    void processLine(const QByteArray & line);

    Q_INVOKABLE     void        openCloseComport();


    Q_SLOT void readData();

    QPointF getPressureData();
    QPointF getVolumnData();


private slots:
    QString     getPortName(int idx);
    int         getTotalPortsCount();
    void        updateComportSettings(QString portname_str);
    void        fillSerialPortInfo();



private:
    QSerialPort *m_serial_port;
    QList<serialPortInfor *> m_serial_port_info;
    QByteArray m_buffer;


    QString     _selected_port_name;
    double _pressure_data_x;
    double _pressure_data_y;

};

#endif // SERIALREADER_H
