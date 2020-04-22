import QtQuick 2.0
import QtQuick.Controls 2.0

Popup {
    id: config
    x: (main.width - width) / 2
    y: Math.abs(main.height - height) / 2
    closePolicy: Popup.NoAutoClose
    modal: true
    focus: true

    property alias    titleName: titleid.text
    property alias    currentValue: slider.value
    property alias    lowerLimit  : slider.lowerLimit
    property alias    upperLimit  : slider.upperLimit
    property alias    stepSlider  : slider.step
    property int      buttonID: 0

    Rectangle{
        width: 500
        height: 250
        color: "white"
        radius: 8
        anchors.centerIn: parent

        Text {
            id: titleid
            font.pixelSize: 26
            color: "#4a4a4a"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 30
        }

        SliderConfig{
            id: slider
            anchors.centerIn: parent
        }

        Row{
            id: rowbt
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.right: parent.right
            anchors.rightMargin: 20
            FlatButton{
                text: "NO"
                textColor:"#9b9b9b"
                onClicked: {
                    puconfig.close()
                }
            }
            FlatButton{
                text: "YES"
                textColor: "#4a4a4a"
                onClicked: {
                    s_config_changed(buttonID,slider.value)
                    s_updated_ie_param_flag();
                    puconfig.close()
                }
            }
        }

    }
}
