import QtQuick 2.0

Item{
    id: root
    height: 32
    width: imgbt.width + textbt.width + 10
    property string imgNormal: "qrc:/images/check_white_18dp.png"
    property alias buttonName: textbt.text
    property bool buttonStatus: false

    signal clicked();
//    spacing: 10

    Rectangle {
        id: imgbt
        width: 32
        height: 32
        radius: width/2
        border.color: buttonStatus? "transparent" : "#979797"
        border.width: buttonStatus? 0:1
        color: buttonStatus? "#03adef":"#323132"
        anchors.verticalCenter: parent.verticalCenter
        Image {
            anchors.fill: parent
            source: buttonStatus? imgNormal:""
        }

    }
    Text {
        id: textbt
        font.pixelSize: 18
        color: "white"
        anchors.left: imgbt.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    root.clicked();
                }
            }


}
