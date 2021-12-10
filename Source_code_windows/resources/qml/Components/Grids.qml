import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.5

RowLayout {
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        color: "transparent"
        ColumnLayout{
            width: parent.width
            height: parent.height
            Search {
                id: search
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Methods {
                id: methods
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        color: "transparent"
        Parameters {
            id: parameters
        }
    }
    
}
