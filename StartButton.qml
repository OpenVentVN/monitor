import QtQuick 2.0

Rectangle {
    id: imgstart
    width: 68
    height: 68
    radius: width /2
    border.width: 4
    border.color: "black"
    color:  buttonStatus ? "#E53935":"#43A047"
    property bool buttonStatus: false


    Text {
        id: textbt
        font.pixelSize: 16
        font.bold: true
        text: buttonStatus? "STOP" : "START"
        anchors.centerIn: parent
        color: "white"
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            buttonStatus = !buttonStatus
        }
    }

}
