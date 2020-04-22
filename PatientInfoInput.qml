import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: rootip
    width: 350
    height: 60
    radius: 8
    border.color: "#97979797"
    color: "#323132"
    border.width: 1
    property alias title: titleText.text

    Text {
        id: titleText
        text: ""
        color: "#9b9b9b"
        font.pixelSize: 14
        anchors.left: parent.left
        anchors.leftMargin: 17
        anchors.top: parent.top
        anchors.topMargin: 8
    }
}

