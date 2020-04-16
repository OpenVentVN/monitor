import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.0

Item {
    id: main
    visible: true

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    RowLayout {
        spacing: 2
        anchors.fill: parent

        // left panel
        ControlPanel {
            id: controlPanel
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: 200
            Layout.margins: 10.0
       }

        // two views
        Item {
            id: viewPadding
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                spacing: 2
                anchors.fill: parent

                VentParamView {
                    id: paramViewer

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop
                }

                ColumnLayout {
                    spacing: 2
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    VentGraphicViewPressure {
                        id: pressureView
                        visible: true

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }

                    VentGraphicViewVolumn {
                        id: flowView
                        visible: false

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Component.onCompleted: {
                                console.log("VentGraphicViewVolumn height: ", flowView.height)
                            }
                    }
                }
            }
        }
    }

}

