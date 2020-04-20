import QtQuick 2.0
import QtCharts 2.0

/*
 Chart 1: Pressure monitor
 Chart 2: Flow monitor
 */

//![1]
ChartView {
    id: pressureChartView
    width: 650
    height: 400
    theme: ChartView.ChartThemeDark
    antialiasing: true

    property string serieName: "Pressure"

    ValueAxis {
        id: axisY1
        min: -10
        max: 40
        tickCount: 6
    }

    ValueAxis {
        id: axisX
        min: 0
        max: 15

        gridVisible:false
        tickCount: 6
    }

    SplineSeries {
        id: pressureSeries
        name: "Pressure"
//        axisX: axisX
        axisX: axisX
        axisY: axisY1
        useOpenGL: true
        width: 5
        color: "#FFFFFF"
    }

    Timer {
        id: refreshTimer
        interval: 1 / 60 * 1000 // 60 Hz
        running: true
        repeat: true
        onTriggered: {
            dataSource.updatePressureData(pressureChartView.series(0));
        }
    }
}

