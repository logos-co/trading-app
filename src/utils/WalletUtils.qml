pragma Singleton
import QtQuick 2.15

QtObject {
    function getUpDownTriangle(value) {
        if (value > 0) return "▲"
        if (value < 0) return "▼"
        return "►"
    }
    
    function getChangePct24HourColor(value) {
        if (value > 0) return "#4EBC60" // green
        if (value < 0) return "#F55555" // red
        return "#939AB3" // neutral grey
    }
} 