import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.5
import QtQuick.Dialogs 1.3

Rectangle{
    color: "transparent"
    Layout.alignment: Qt.AlignHCenter
    Layout.fillHeight: true
    Layout.fillWidth: true
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Text {
            text: "Search txt file"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            font.pixelSize: parent.width / 20
            font.family: "Sans-Serif"
        }
    }
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Buttons {
            text: "Search..."
            buttonWidth: parent.width / 3
            buttonHeight: parent.height / 3
            buttonFontSize: parent.width / 20
            colorButton: "yellowgreen"
            anchors.centerIn: parent
            onClicked: {
                fileDialog.open()
            }
        }
    }

    FileDialog{
        id: fileDialog
        selectMultiple: false
        nameFilters: ["*.txt", "*.csv"]
        onAccepted:{
            filename = fileDialog.fileUrl
            ftsconn.getFilename(filename)
            visBtn = true
        }
    }
}
