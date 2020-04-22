import QtQuick 2.0

Rectangle {
    property double value       : 0
    property double step        : 1
    property double fillWidth  : 0
    property double lowerLimit  : 0
    property double upperLimit  : 100
    property double handleOffsetX: handle.width/2
    property double convertRatio:  (handleMouseArea.drag.maximumX - handleMouseArea.drag.minimumX)/(upperLimit - lowerLimit)
    property string handleNormal   : "qrc:/images/icon_triangle.png"
    property string handlePressed  : "qrc:/images/icon_triangle.png"
    property bool   displayOnly: false

    id: slider
    color: "#c1c1c1"
    smooth: true
    radius: 0.7*height/2
//    border.width: 0.5
//    border.color: "cyan"
    implicitHeight: 8; implicitWidth: 360
    Item {
        id: grooveRect
        width: parent.width - parent.border.width
        height: parent.height - parent.border.width
        anchors.centerIn: parent
        clip: true
        Rectangle {
            id: fillRect
            height: parent.height;
            width: (value - lowerLimit)*convertRatio
            radius: slider.radius
            color: "#f15a22"
            opacity: 0.8
            anchors.left: parent.left; anchors.leftMargin: slider.border.width/2
        }
    }

    Item {
        id: handle
        height:  25 ; width: 25; anchors.top: grooveRect.bottom;
        x: fillRect.width - handleOffsetX
        Image{
            id: handleReleasedImage
            asynchronous: true
            anchors.fill: parent
            source: handleNormal
        }
        Image{
            id: handlePressedImage
            asynchronous: true
            anchors.fill: parent
            source: handlePressed
            state: "normal"
            states:[
                State {
                    name: "focus"
                    PropertyChanges {target: handlePressedImage; opacity: 1; }
                }
                ,State {
                    name: "normal"
                    PropertyChanges {target: handlePressedImage; opacity: 0; }
                }
            ]
            transitions: [ Transition {
                    from: "focus"
                    to:   "normal"
                    ParallelAnimation{
                        NumberAnimation { target: handlePressedImage; property: "opacity"; duration: 200;  }
                        SequentialAnimation{
                            NumberAnimation{ target: handlePressedImage; properties: "scale"; to: 1.5; duration: 100;}
                            NumberAnimation{ target: handlePressedImage; properties: "scale"; to: 0.5; duration: 100;}
                        }
                    }
                },
                Transition{
                    from: "normal"
                    to: "focus"
                    ParallelAnimation{
                        NumberAnimation { target: handlePressedImage; property: "opacity"; duration: 300;  }
                        SequentialAnimation{
                            NumberAnimation{ target: handlePressedImage; properties: "scale"; to: 1.0; duration: 100;}
                            NumberAnimation{ target: handlePressedImage; properties: "scale"; to: 1.5; duration: 100;}
                            NumberAnimation{ target: handlePressedImage; properties: "scale"; to: 1; duration: 100;}

                        }
                    }
                }
            ]
        }
        MouseArea {
            id: handleMouseArea
            anchors.fill: parent
    //            hoverEnabled: true

            drag.axis: Drag.XAxis
            drag.minimumX: slider.border.width - handleOffsetX
            drag.maximumX: slider.width - handleOffsetX  - slider.border.width
            onPressed: { handlePressedImage.state  = "focus"
            }
            onReleased: {
                handlePressedImage.state = "normal"
            }
            onEntered: handleReleasedImage.source = handlePressed
            onExited:  handleReleasedImage.source = handleNormal


            onMouseXChanged: {
                if(!displayOnly){
                    drag.target =  handle
                    fillWidth = handle.x + handleOffsetX  - slider.border.width
                    var fixedData = 0
                    if(step < 1)fixedData = 1

                    value = (lowerLimit + fillWidth/convertRatio).toFixed(fixedData);
                    if(value%step != 0 && step > 1){
                        value = (value - value%step).toFixed(fixedData)
                    }
                    handle.x = (value - lowerLimit)*convertRatio - handleOffsetX

                }
            }
        }

    }
    Text {
        id: textcurrent
        text: value.toString()
        font.pixelSize: 18
        color: "#4a4a4a"
        anchors.bottom: grooveRect.top;
        anchors.bottomMargin: 10
        x: fillRect.width
    }
//    Text {
//        id: textlow
//        text: lowerLimit
//        font.pixelSize: 18
//        color: "#4a4a4a"
//        anchors.bottom: parent.top
//        anchors.bottomMargin: 10
//        anchors.left: parent.left
//    }
//    Text {
//        id: textup
//        text: upperLimit
//        font.pixelSize: 18
//        color: "#4a4a4a"
//        anchors.bottom: parent.top
//        anchors.bottomMargin: 10
//        anchors.right: parent.right
//    }
    ImageButtonEdit{
        width: 40
        height: 40
        imgNormal: "qrc:/images/btnedit-_normal.png"
        imgHover: "qrc:/images/btnedit-_hover.png"
        anchors.right: parent.left
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            var fixedData = 0
            if(step < 1)fixedData = 1
            value = (value - step).toFixed(fixedData)
            if(value< lowerLimit) value = lowerLimit
        }
    }

    ImageButtonEdit{
        width: 40
        height: 40
        imgNormal: "qrc:/images/btnedit+_normal.png"
        imgHover: "qrc:/images/btnedit+_hover.png"
        anchors.left: parent.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            var fixedData = 0
            if(step < 1)fixedData = 1
            value = (value + step).toFixed(fixedData)
            if(value > upperLimit) value = upperLimit
        }
    }
}


