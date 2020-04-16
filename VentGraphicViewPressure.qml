import QtQuick 2.0
import QtCharts 2.1

/*
 Chart 1: Pressure monitor
 Chart 2: Flow monitor
 */

//![1]
ChartView {
    id: pressureChartView
    theme: ChartView.ChartThemeDark
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
        tickCount: 16
    }

    SplineSeries {
        id: pressureSeries
        name: "Pressure"
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

