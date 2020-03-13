import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtQuick.Window 2.12
import Diary 1.0
import "themeslist.js" as ThemesFunctions


Item {
    property alias  defaultButton: defaultTheme
    property alias  roseButton: roseTheme
    property alias  yellowButton: yellowTheme
    property alias  darkButton: darkTheme


    //Themes
    property color themeColor
    property color defaultSelect
    property color roseSelect
    property color yellowSelect
    property color darkSelect
    property color enteredDefault : "#7187df"
    property color enteredRose :"#DB6767"
    property color enteredYellow : "#FFDFB9"
    property color enteredDark :"#3D3838"
    id:mainArea




    MouseArea{
        id:emptyFocus
        anchors.left:parent.left
        anchors.top:parent.top
        anchors.bottom: parent.bottom
        width: parent.width-settingsArea.width
        onClicked: {
            mainArea.state=""
            window.buttonsActive = true
        }
    }
    Rectangle{
        id:settingsArea
        width: 200
        color: themeColor
        anchors.left: emptyFocus.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        MouseArea{
            anchors.fill: parent
        }
        Rectangle{
            id:themeTitle
            color: parent.color
            height: 80
            anchors.horizontalCenter: parent.horizontalCenter
            width: themeImage.width+ themeText.width

            anchors.margins: 5


            Rectangle{
                id:themeImage
                color: parent.color
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 40
                height: width
                Image {
                    id: themeIcon
                    anchors.fill: parent
                    anchors.margins: 3
                    source: "resources/images/themeIcon.svg"
                    sourceSize.width: width*Screen.devicePixelRatio
                    sourceSize.height: height*Screen.devicePixelRatio
                    visible: false
                }
                ColorOverlay {
                    id: themeColorOverlay
                    anchors.fill: themeIcon
                    source: themeIcon
                    transformOrigin: Item.Center
                    color: "white"
                }

            }
            Text{
                id:themeText
                anchors.margins: 5
                anchors.left: themeImage.right
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Theme")
                font.family: "poppins_black"
                font.pixelSize:22
                color: "white"
            }

        }
        Rectangle{
            id:themeSection
            anchors.top: themeTitle.bottom
            width: parent.width
            Button{
                id:defaultTheme
                height: 30
                width: parent.width/2 -9
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 5

                contentItem: Text {
                    color:defaultTheme.hovered?enteredDefault: defaultSelect
                    text: "Default"
                    font.pixelSize: {
                        if(defaultTheme.down) return 14
                        else if(defaultTheme.hovered) return 26
                        else return 20
                    }

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle{
                    color: themeColor
                }
                onClicked: {
                    qSettings.colorTheme=Themes.DEFAULT_THEME
                    ThemesFunctions.changeTheme(Themes.DEFAULT_THEME)
                }
            }

            Button{
                id:roseTheme
                height: 30

                width: parent.width/2 -9
                anchors.left: defaultTheme.right
                anchors.top: parent.top
                anchors.margins: 5
                contentItem: Text {
                    color:roseTheme.hovered? enteredRose: roseSelect
                    text:"Rose"
                    font.pixelSize: {
                        if(roseTheme.down) return 14
                        else if(roseTheme.hovered) return 26
                        else return 20
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle{
                    color: themeColor
                }
                onClicked: {
                    qSettings.colorTheme=Themes.ROSE_THEME
                    ThemesFunctions.changeTheme(Themes.ROSE_THEME)
                }
            }
            Button{
                id:yellowTheme
                height: 30

                width: parent.width/2 -9
                anchors.left: parent.left
                anchors.top: defaultTheme.bottom
                anchors.margins: 5
                contentItem: Text {
                    color:yellowTheme.hovered? enteredYellow: yellowSelect
                    text:"Beige"
                    font.pixelSize: {
                        if(yellowTheme.down) return 14
                        else if(yellowTheme.hovered) return 26
                        else return 20
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle{
                    color: themeColor
                }
                onClicked: {
                    qSettings.colorTheme=Themes.YELLOW_THEME
                    ThemesFunctions.changeTheme(Themes.YELLOW_THEME)
                }
            }
            Button{
                id:darkTheme
                height: 30
                width: parent.width/2 -9
                anchors.left: yellowTheme.right
                anchors.top: roseTheme.bottom
                anchors.margins: 5
                text: "Dark"
                contentItem: Text {
                    color:darkTheme.hovered ? enteredDark : darkSelect
                    text:"Dark"
                    font.pixelSize: {
                        if(darkTheme.down) return 14
                        else if(darkTheme.hovered) return 26
                        else return 20
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle{
                    color: themeColor
                }
                onClicked: {
                    qSettings.colorTheme=Themes.DARK_THEME
                    ThemesFunctions.changeTheme(Themes.DARK_THEME)
                }
            }
        }



    }



    states: [
        State {
            name: "Active"
            PropertyChanges {
                target: settingsSection
                x: 0
                visible:true
            }
        }]

    transitions: [
        Transition {
            from: "Active"
            to: ""
            PropertyAnimation {
                easing.type: Easing.InOutQuad
                properties: "x, visible"
                duration: 450
            }
        },
        Transition {
            from: ""
            to: "Active"
            PropertyAnimation {
                easing.type: Easing.InOutQuad
                properties: "x"
                duration: 450
            }
        }]

}
