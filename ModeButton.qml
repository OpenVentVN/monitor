import QtQuick 2.0

Image {
    id: imgbt
    width: 90
    height: 46
    property string imgNormal: "qrc:/images/btn_normal.png"
    property string imgHover: "qrc:/images/btn_hover.png"
    property alias buttonName: textbt.text
    property bool buttonStatus: false

    source: buttonStatus? imgHover:imgNormal


    signal clicked();


    Text {
        id: textbt
        font.pixelSize: 16
        font.bold: true
        anchors.centerIn: parent
        color: buttonStatus ? "white":"#4a4a4a"
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            imgbt.clicked();
        }
    }

}
