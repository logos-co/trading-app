import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    width: 800
    height: 600
    visible: true
    title: "Trading App"
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10
        
        // Header
        Rectangle {
            Layout.fillWidth: true
            height: 60
            color: "#2e3440"
            radius: 5
            
            Text {
                anchors.centerIn: parent
                text: "Market Trading View"
                color: "white"
                font.pixelSize: 24
                font.bold: true
            }
        }
        
        // Main content area with trading components
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15
            
            // Market list panel
            Rectangle {
                Layout.preferredWidth: 250
                Layout.fillHeight: true
                color: "#3b4252"
                radius: 5
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10
                    
                    Text {
                        text: "Markets"
                        color: "white"
                        font.pixelSize: 18
                        font.bold: true
                    }
                    
                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: ["BTC/USD", "ETH/USD", "SOL/USD", "AVAX/USD", "LINK/USD"]
                        delegate: Rectangle {
                            width: parent ? parent.width : 0
                            height: 40
                            color: index % 2 === 0 ? "#434c5e" : "#4c566a"
                            radius: 3
                            
                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                color: "white"
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                onClicked: console.log("Selected market: " + modelData)
                            }
                        }
                    }
                }
            }
            
            // Chart and order panel
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#3b4252"
                radius: 5
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10
                    
                    // Price chart placeholder
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: 300
                        color: "#2e3440"
                        
                        Text {
                            anchors.centerIn: parent
                            text: "Price Chart"
                            color: "#88c0d0"
                            font.pixelSize: 20
                        }
                    }
                    
                    // Order entry form
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 150
                        color: "#434c5e"
                        radius: 5
                        
                        GridLayout {
                            anchors.fill: parent
                            anchors.margins: 15
                            columns: 2
                            rows: 3
                            columnSpacing: 10
                            rowSpacing: 10
                            
                            Text { 
                                text: "Price:" 
                                color: "white"
                                font.pixelSize: 14
                            }
                            
                            TextField {
                                Layout.fillWidth: true
                                placeholderText: "Enter price"
                                background: Rectangle {
                                    color: "#4c566a"
                                    radius: 3
                                }
                                color: "white"
                            }
                            
                            Text { 
                                text: "Amount:" 
                                color: "white"
                                font.pixelSize: 14
                            }
                            
                            TextField {
                                Layout.fillWidth: true
                                placeholderText: "Enter amount"
                                background: Rectangle {
                                    color: "#4c566a"
                                    radius: 3
                                }
                                color: "white"
                            }
                            
                            RowLayout {
                                Layout.columnSpan: 2
                                Layout.fillWidth: true
                                spacing: 10
                                
                                Button {
                                    Layout.fillWidth: true
                                    text: "BUY"
                                    background: Rectangle {
                                        color: "#a3be8c"
                                        radius: 3
                                    }
                                    onClicked: console.log("Buy order placed")
                                }
                                
                                Button {
                                    Layout.fillWidth: true
                                    text: "SELL"
                                    background: Rectangle {
                                        color: "#bf616a"
                                        radius: 3
                                    }
                                    onClicked: console.log("Sell order placed")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
