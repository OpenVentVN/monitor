QT += charts qml quick virtualkeyboard serialport

CONFIG += c++11
DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        datasink.cpp \
        datasource.cpp \
        main.cpp \
        sampledatasource.cpp \
        serialdatasource.cpp

RESOURCES += qml.qrc

QML_IMPORT_PATH =
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    datasink.h \
    datasource.h \
    sampledatasource.h \
    serialdatasource.h

DISTFILES +=
