import QtQuick 2.0

Rectangle {
    id: btinfo
    width: 160;
    height: 65;
    color: colorNormal;

    property color colorPressed: "#1E88E5"
    property color colorNormal: "#4a4a4a"

    property alias valueCenter: textCenter.text
    property alias valueLeft: textLeft.text
    property alias valueRight: textRight.text

    signal clicked()

    Text {
        id: textCenter
        text: valueCenter
        anchors.centerIn: parent
        font.pixelSize: 30
        color: "white"
    }

    Text {
        id: textLeft
        text: valueLeft
        anchors.left: parent.left
        anchors.leftMargin: 5
        font.pixelSize: 14
        color: "white"
    }

    Text {
        id: textRight
        text: valueRight
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        font.pixelSize: 14
        color: "white"
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            btinfo.clicked()
        }
        onReleased: btinfo.color = colorNormal
        onPressed: btinfo.color = colorPressed
    }
}
