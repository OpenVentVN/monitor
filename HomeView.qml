import QtQuick 2.0

Rectangle {
    width:  800
    height: 480
    color: "#262626"

    Rectangle{
        id: recInfor
        color: "black"
        width: 780 //740
        height: 373//353
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top;
        anchors.topMargin: 10//30
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

//        patientFistName: "Chanh"
//        patientLastName: "Thai Quoc"
//        patientGender: false
//        patientAge: "30"
//        patientHigh: "160"
//        patientWeight: "61"
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
            buttonID: 1
            lowLimit: 200
            upLimit: 800
            stepConfig: 10
        }
        InfoButton{
            id: iebutton
            valueCenter: "1"
            valueLeft: "Ti"
            valueRight: "s"
            buttonID: 2
            lowLimit: 0.5
            upLimit: 2
            stepConfig: 0.1
        }
        InfoButton{
            id: fbutton
            valueCenter: "20"
            valueLeft: "F"
            valueRight: "bpm"
            buttonID: 3
            lowLimit: 5
            upLimit: 40
            stepConfig: 1
        }
        InfoButton{
            id: peepbutton
            valueCenter: "10"
            valueLeft: "PEEP"
            valueRight: "cmH2O"
            buttonID: 4
            lowLimit: 5
            upLimit: 20
            stepConfig: 1
        }
        InfoButton{
            id: pipbutton
            valueCenter: "21"
            valueLeft: "PIP"
            valueRight: "%"
            buttonID: 5
            lowLimit: 20
            upLimit: 40
            stepConfig: 1
        }
        InfoButton{
            id: supbutton
            valueCenter: "10"
            valueLeft: "SUP"
            valueRight: "%"
            buttonID: 6
            lowLimit: 0
            upLimit: 100
            stepConfig: 10
        }
    }

    Row{
        id: rowmode
        spacing: 40
        anchors.left: parent.left; anchors.leftMargin: 30
        anchors.bottom: parent.bottom; anchors.bottomMargin: 26
//        anchors.left: columbtinfo.right
//        anchors.leftMargin: 30

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
            buttonName: "SIMV+PS"
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
