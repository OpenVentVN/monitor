import QtQuick 2.0

Image {
    id: imgbt
    width: 40
    height: 40
    property string imgNormal: "qrc:/images/btn_normal.png"
    property string imgHover: "qrc:/images/btn_hover.png"

    source: imgNormal


    signal clicked();

    MouseArea{
        anchors.fill: parent
        onClicked: {
            imgbt.clicked();
        }
        onReleased: imgbt.source = imgNormal
        onPressed: imgbt.source = imgHover
    }

}
