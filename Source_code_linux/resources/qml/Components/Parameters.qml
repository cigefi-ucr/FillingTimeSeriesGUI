import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.5
import QtQuick.Dialogs 1.3

ColumnLayout{
    width: parent.width
    height: parent.height * 0.91
    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
    
    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        ColumnLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Rectangle {
                visible: vis
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                Text {
                    text: "Tolerance"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.width / 15
                    font.family: "Sans-Serif"
                }
            }

            Rectangle {
                visible: vis
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                TextFields {
                    id: tolerance
                    phText: "Tolerance..."
                    text: tolerance.text
                    validator: RegExpValidator{
                        regExp: /\d*\.*\d+/
                    }
                }
            }
        }

        ColumnLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Rectangle {
                visible: vis
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                Text {
                    text: "Minimum value"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.width / 15
                    font.family: "Sans-Serif"
                }
            }

            Rectangle {
                visible: vis
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                TextFields {
                    id: minvalue
                    phText: "Minimum value..."
                    text: minvalue.text
                    validator: RegExpValidator{
                        regExp: /\-*\d*\.*\d+/
                    }
                }
            }
        }
    }

    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

        ColumnLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Rectangle {
                id:chr
                visible: vis
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                Text {
                    text: parameter
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.width / 15
                    font.family: "Sans-Serif"
                }
            }

            Rectangle {
                visible: vis
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                SpinBoxes{
                    id: parameterCh
                    from: belowRange
                    to: upperRange
                    value: parameterCh.value
                }
            }
        }

        ColumnLayout{
            Rectangle {
                id:iter
                visible: vis
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                Text {
                    text: "Maximum iterations"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.width / 15
                    font.family: "Sans-Serif"
                }
            }
            Rectangle {
                visible: vis
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                SpinBoxes{
                    id: max
                    from: 1
                    to: 1000000
                    value: max.value
                }
            }
        }
    }

    RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

        ColumnLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Rectangle {
                id: fullsection
                visible: visSection
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                Text {
                    text: "Lags"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: parent.width / 25
                    font.family: "Sans-Serif"
                }
            }

            Rectangle {
                visible: visSection
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"
                SpinBoxes{
                    id: parameterSection
                    height: parent.height
                    width: parent.width / 4
                    font.pixelSize: parent.width / 40
                    from: belowRange
                    to: upperRangeAR
                    value: parameterSection.value
                }
            }
        }
    }

    Rectangle {
        id: apply
        visible: vis
        height: parent.height * 0.35
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter
        color: "transparent"
        Buttons {
            text: "Apply & save"
            buttonWidth: parent.width / 3.5
            buttonHeight: parent.height / 2
            buttonFontSize: parent.width / 30
            colorButton: "yellowgreen"
            anchors.centerIn: parent
            onClicked: {
                savedFileDialog.open()
            }
        }  
    }

    FileDialog{
        id: savedFileDialog
        selectMultiple: false
        nameFilters: ["*.txt", "*.csv"]
        selectExisting: false
        onAccepted:{
            savedfilename = savedFileDialog.fileUrl.toString()
            tol = tolerance.text
            maxIter = max.value
            valueMin = minvalue.text
            parCh = parameterCh.value
            parS = parameterSection.value
            carrousel.push(waiting)
        }
    }
}
