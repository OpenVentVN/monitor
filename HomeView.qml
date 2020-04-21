import QtQuick 2.0

Rectangle {
    width:  800
    height: 480
    color: "#262626"

    Rectangle{
        id: recInfor
        color: "black"
        width: 740
        height: 353
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top;
        anchors.topMargin: 30
    }

    VentGraphicViewPressure {
        id: pressureView
        anchors.top: patientlb.bottom ;anchors.topMargin: -20
        anchors.left: columbtinfo.right; anchors.leftMargin: -10
        anchors.right: recInfor.right ;anchors.rightMargin: -10
        anchors.bottom: recInfor.bottom ; anchors.bottomMargin: -10
    }

    PatientInforLabel{
        id: patientlb
        anchors.top: recInfor.top
        anchors.topMargin: 5
        anchors.right: recInfor.right
        anchors.rightMargin: 5
        anchors.left: columbtinfo.right
        anchors.leftMargin: 5

        patientName: "Thai Quoc Chanh"
        patientGender: "Male"
        patientAge: "30"
        patientHigh: "160"
        patientWeight: "61"
    }

    Column{
        id: columbtinfo
        spacing: 5
//        anchors.top: recInfor.top
//        anchors.topMargin: 5
        anchors.left: recInfor.left
        anchors.leftMargin: 5
        anchors.verticalCenter: recInfor.verticalCenter

        InfoButton{
            id: vtbutton
            valueCenter: "500"
            valueLeft: "VT"
            valueRight: "ml"
        }
        InfoButton{
            id: iebutton
            valueCenter: "1:2"
            valueLeft: "I/E"
            valueRight: ""
        }
        InfoButton{
            id: fbutton
            valueCenter: "20"
            valueLeft: "F"
            valueRight: "bpm"
        }
        InfoButton{
            id: peepbutton
            valueCenter: "10"
            valueLeft: "PEEP"
            valueRight: "cmH2O"
        }
        InfoButton{
            id: pipbutton
            valueCenter: "21"
            valueLeft: "PIP"
            valueRight: "%"
        }
    }

    Row{
        id: rowmode
        spacing: 40
        anchors.left: parent.left; anchors.leftMargin: 30
        anchors.bottom: parent.bottom; anchors.bottomMargin: 26

        ModeButton{
            id: cmvbutton
            buttonStatus: true
            buttonName: "A/VC"
            onClicked: {
                buttonStatus = !buttonStatus
                acbutton.buttonStatus = false
                cpapbutton.buttonStatus = false
            }
        }
        ModeButton{
            id: acbutton
            buttonStatus: false
            buttonName: "SIMV"
            onClicked: {
                buttonStatus = !buttonStatus
                cmvbutton.buttonStatus = false
                cpapbutton.buttonStatus = false
            }
        }
        ModeButton{
            id: cpapbutton
            buttonStatus: false
            buttonName: "PRVC"
            onClicked: {
                buttonStatus = !buttonStatus
                acbutton.buttonStatus = false
                cmvbutton.buttonStatus = false
            }
        }
    }

    StartButton{
        id:startbt
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15

    }

}
