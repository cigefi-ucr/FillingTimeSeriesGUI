import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.5

SpinBox{
    width: parent.width / 2
    height: parent.height
    anchors.centerIn: parent
    editable: true
    font.pixelSize: parent.width / 20
    background:Rectangle{
        implicitWidth: parent.width
        implicitHeight: parent.height
        color: "white"
        border.color: "#CB2B92"
        border.width: parent.width / 250
        radius: 50 
    }
}
