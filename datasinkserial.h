#ifndef DATASINKSERIAL_H
#define DATASINKSERIAL_H

#include <QObject>

class DataSinkSerial : public QObject
{
    Q_OBJECT
public:
    explicit DataSinkSerial(QObject *parent = nullptr);

signals:

public slots:
};

#endif // DATASINKSERIAL_H
