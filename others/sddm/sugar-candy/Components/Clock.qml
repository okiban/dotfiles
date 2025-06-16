//
// This file is part of Sugar Dark, a theme for the Simple Display Desktop Manager.
//
// Copyright 2018 Marian Arlt
//
// Sugar Dark is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Sugar Dark is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Sugar Dark. If not, see <https://www.gnu.org/licenses/>.
//

import QtQuick 2.12
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.15


Column {
    id: clock
    spacing: 0
    width: parent.width / 2
   
    Text {
  	anchors.horizontalCenter: parent.horizontalCenter
	//        font.pointSize: config.HeaderText !=="" ? root.font.pointSize * 3 : 0
	font.pointSize: 42
	color: root.palette.text
	renderType: Text.QtRendering
     	text: config.HeaderText  
    }
    
    Label {
        id: timeLabel
        anchors.horizontalCenter: parent.horizontalCenter
	//        font.pointSize: root.font.pointSize * 3
	font.pointSize: 42
        color: root.palette.text
	renderType: Text.QtRendering
        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(config.Locale), config.HourFormat == "long" ? Locale.LongFormat : config.HourFormat !== "" ? config.HourFormat : Locale.ShortFormat)
        }
    }

    Label {
        id: dateLabel
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.palette.text
        renderType: Text.QtRendering
        function updateTime() {
            text = new Date().toLocaleDateString(Qt.locale(config.Locale), config.DateFormat == "short" ? Locale.ShortFormat : config.DateFormat !== "" ? config.DateFormat : Locale.LongFormat)
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            dateLabel.updateTime()
            timeLabel.updateTime()
        }
    }

    Component.onCompleted: {
        dateLabel.updateTime()
        timeLabel.updateTime()
    }
}
