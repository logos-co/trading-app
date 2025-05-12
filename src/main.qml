import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: "Hello World App"

    Text {
        anchors.centerIn: parent
        text: "Hello World!"
        font.pixelSize: 24
    }
} 