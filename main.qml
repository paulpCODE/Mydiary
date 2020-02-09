import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Diary 1.0

Window {
    id: window
    visible: true
    color: "#1f586d"
    minimumWidth: 640
    minimumHeight: 480
    width: 640
    height: 480
    title: qsTr("My Diary")

    TopPannel {
        id: topPannel
        height: 35
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    ColumnLayout {
        id: leftColumn
        width: 200
        height: parent.height - topPannel.height
        anchors.top: topPannel.bottom
        NotesList {
            id:notesList
            Layout.fillWidth: true
        }

        RowLayout {
            width: parent.width
            height: 40
            Button {
                Layout.fillWidth: true
                text: "ADD"
                onClicked: {
                    diaryList.addItem()
                    notesList.currentIndex=0
                    updateWindowInformation()
                }

            }
            Button {
                Layout.fillWidth: true
                text: "Del"
                onClicked: {
                    if(notesList.currentIndex == -1) { return; }
                    var temp = notesList.currentIndex
                    diaryList.deleteItem(notesList.currentIndex)
                    if(diaryList.endItem(temp)) { temp--; }
                    notesList.currentIndex = temp
                    updateWindowInformation()


                }
            }
        }
    }

    Rectangle {
        id: startRect
        visible: true
        color: "#033749"
        x: leftColumn.width + verticalSeparator.width
        width: parent.width - leftColumn.width - verticalSeparator.width
        anchors.top: topPannel.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        Text {
            anchors.centerIn: parent
            font.pixelSize: 17
            color: "#aaaaaa"
            text: "Enter or Create a Page"
        }
    }





    TextINputWindow {
        visible: false
        id: userinput
        x: leftColumn.width + verticalSeparator.width
        width: parent.width - leftColumn.width - verticalSeparator.width
        anchors.top: topPannel.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right



        titletext.onEditingFinished: {
            updateModelInformation()
        }
        usertext.onEditingFinished: {
            updateModelInformation()
        }
    }

    Rectangle {
        id: verticalSeparator
        color:"black"

        width: 1
        anchors.top: topPannel.bottom
        anchors.bottom: parent.bottom
        anchors.left: leftColumn.right
    }

    Component.onDestruction: {
        updateModelInformation()
    }

    function updateWindowInformation() {


        if(userinput.visible==false){
            userinput.visible=true;
        }
        if(notesList.currentIndex == -1){
            userinput.visible=false;
            return
        }
        userinput.datetext.text = notesList.model.data(notesList.model.index(notesList.currentIndex, 0), 257)
        userinput.titletext.text = notesList.model.data(notesList.model.index(notesList.currentIndex, 0), 258)
        userinput.usertext.text = notesList.model.data(notesList.model.index(notesList.currentIndex, 0), 259)
    }

    // don't change data if we don't change anything
    function updateModelInformation() {
        if(notesList.currentIndex==-1){
            return
        }

        if(notesList.model.setData(notesList.model.index(notesList.currentIndex, 0), qsTr(userinput.titletext.text), 258)){
            return
        }
        notesList.model.setData(notesList.model.index(notesList.currentIndex, 0), qsTr(userinput.usertext.text), 259)
    }

    function addButtonRealization() {
        diaryList.addItem()
        notesList.currentIndex = 0
        updateWindowInformation()
    }




    /*##^##
Designer {
    D{i:1;anchors_height:453;anchors_y:27}D{i:2;anchors_height:432;anchors_x:209;anchors_y:33}
D{i:7;anchors_height:171;anchors_width:148;anchors_x:42;anchors_y:187}
}
##^##*/
}
