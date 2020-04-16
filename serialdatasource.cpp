#include "serialdatasource.h"
#include <QDebug>

SerialDataSource::SerialDataSource()
{
    connect(&m_port, &QIODevice::readyRead, this, &SerialDataSource::readData);
}

void SerialDataSource::processLine(const QByteArray &line)
{
    qDebug() << line;
}

void SerialDataSource::readData()
{
    while (m_port.canReadLine())
    {
        processLine(m_port.readLine());
    }
}
