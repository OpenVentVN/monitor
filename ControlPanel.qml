import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.0

/*
  Paramters:
    1. MVE
    2. VT
    3. Pavg
    4. PEEP
    5. Rate
    6. FiO2

  Functions:
    1. Set modes
    2. Set params
    3. Lock/Unlock
    4. Power On/Off

 */

ColumnLayout {
    spacing: 8
    Layout.fillHeight: true

    // define signal
    signal ventilatorStart(bool enabled)
    signal displayLock(bool locked)
    signal refreshRateChanged(variant rate);
    signal signalSourceChanged(string source, int signalCount, int sampleCount);

    Text {
        text: "OpenVENT"
        font.pixelSize: 18
        color: "white"
    }

    MultiButton {
        id: powerOnOffButton
        text: "Power: "
        items: ["false", "true"]
        currentSelection: 1
        onSelectionChanged: displayLock(currentSelection == 1);
    }

    MultiButton {
        id: lockButton
        text: "Lock: "
        items: ["false", "true"]
        currentSelection: 1
        onSelectionChanged: displayLock(currentSelection == 1);

    }

    MultiButton {
        id: startStopButton
        text: "Start : "
        items: ["false", "true"]
        currentSelection: 1
    }

}
