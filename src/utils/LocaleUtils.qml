pragma Singleton
import QtQuick 2.15

QtObject {
    function numberToLocaleString(number, decimals) {
        if (typeof number !== "number") {
            return "0.00";
        }
        
        return Number(Math.abs(number).toFixed(decimals)).toLocaleString('en-US');
    }
} 