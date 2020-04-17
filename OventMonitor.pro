QT += charts qml quick serialport

static {
    QT += svg
    QTPLUGIN += qtvirtualkeyboardplugin
}

CONFIG += c++11
DEFINES += QT_DEPRECATED_WARNINGS

INCLUDEPATH +=  data \

SOURCES += \
        datasink.cpp \
        datasinkserial.cpp \
        datasource.cpp \
        main.cpp \
        sampledatasource.cpp \
        serialdatasource.cpp \
        serialportinfor.cpp

RESOURCES += qml.qrc \
    dataFile.qrc

QML_IMPORT_PATH =
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    datasink.h \
    datasinkserial.h \
    datasource.h \
    sampledatasource.h \
    serialdatasource.h \
    serialportinfor.h

DISTFILES +=
