import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.5

TextField {
    property string phText
    width: parent.width / 2
    height: parent.height/ 1.1
    anchors.centerIn: parent
    placeholderText: phText
    font.pixelSize: parent.width / 20
    font.family: "Sans-Serif"
    color: "#000000"
    background: Rectangle{
        implicitWidth: parent.width
        implicitHeight: parent.height
        color: "white"
        border.color: "#CB2B92"
        border.width: parent.width / 250
        radius: 50
    }
}
