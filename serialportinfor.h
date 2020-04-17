#ifndef SERIALPORTINFOR_H
#define SERIALPORTINFOR_H

#include <QString>

class serialPortInfor
{
public:
    serialPortInfor();
    QString portName;   ///< Port name.
    QString physName;   ///< Physical name.
    QString friendName; ///< Friendly name.
    QString enumName;   ///< Enumerator name.
    int vendorID;       ///< Vendor ID.
    int productID;      ///< Product ID
};

#endif // SERIALPORTINFOR_H
