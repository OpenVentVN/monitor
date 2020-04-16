#ifndef SERIALREADER_H
#define SERIALREADER_H

#include <QObject>
#include <QSerialPort>
#include <QByteArray>

class SerialDataSource : public QObject
{
    Q_OBJECT


public:
    SerialDataSource();
    void processLine(const QByteArray & line);


    Q_SLOT void readData();

private:
    QSerialPort m_port;
    QByteArray m_buffer;
};

#endif // SERIALREADER_H
