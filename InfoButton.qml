import QtQuick 2.0

Rectangle {
    id: btinfo
    width: 160;
    height: 56//65;
    color: colorNormal;

    property color colorPressed: "#1E88E5"
    property color colorNormal: "#4a4a4a"

    property alias valueCenter: textCenter.text
    property alias valueLeft: textLeft.text
    property alias valueRight: textRight.text

    property double    stepConfig: 1
    property double    lowLimit: 0
    property double    upLimit: 100


    property int buttonID: 0

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
        anchors.leftMargin: 3
        font.pixelSize: 14
        anchors.top: parent.top
        anchors.topMargin: 3
        color: "white"
    }

    Text {
        id: textRight
        text: valueRight
        anchors.right: parent.right
        anchors.rightMargin: 3
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        font.pixelSize: 14
        color: "white"
    }
    // only show for Ti mode
    Text {
        id: textti
        text: "I/E = 1:2"
        anchors.left: parent.left
        anchors.leftMargin: 3
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        font.pixelSize: 12
        color: "white"
        visible: textLeft.text == "Ti"? true:false
    }



    MouseArea{
        anchors.fill: parent
        onClicked: {
            btinfo.clicked()
            puconfig.currentValue = valueCenter*1
            puconfig.buttonID = buttonID
            puconfig.stepSlider = stepConfig
            puconfig.upperLimit = upLimit
            puconfig.lowerLimit = lowLimit
            puconfig.titleName = valueLeft + " ("+valueRight +")"
            puconfig.open()
        }
        onReleased: btinfo.color = colorNormal
        onPressed: btinfo.color = colorPressed
    }

    Connections{
        target: mainwindown
        onS_config_changed:{
            if(buttonID == _id) valueCenter = _value.toString()
        }
        onS_updated_ie_param_start:{
            if(textLeft.text == "Ti"){
                textti.text = "I/E = 1:" + (((60/_f) - valueCenter*1)/valueCenter*1).toFixed(1).toString()
            }
        }
        onS_updated_ie_param_flag:{
            if(textLeft.text == "F") s_updated_ie_param_start(valueCenter*1)
        }
    }

}
