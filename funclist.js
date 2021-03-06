
function updateWindowInformation() {

    if(!userinput.visible)
        userinput.visible = true;

    if(notesList.currentIndex === -1){
        userinput.visible = false;
        return
    }

    // а тут она по приколу)
    var sourceIndex = notesList.sortModel.mapToSource(notesList.sortModel.index(notesList.currentIndex, 0))
    userinput.dateInfo = notesList.model.data(sourceIndex, DiaryModel.DateRole)
    userinput.titletext.text = notesList.model.data(sourceIndex, DiaryModel.TitleRole)
    userinput.usertext.text = notesList.model.data(sourceIndex, DiaryModel.TextRole)
    userinput.editInfo = notesList.model.data(sourceIndex, DiaryModel.LastEditRole)
    userinput.favorite = !notesList.model.data(sourceIndex, DiaryModel.FavoriteRole)
}

// don't change data if we don't change anything
// after committing changes sets the date of editing
function updateModelInformation() {

    if(notesList.currentIndex === -1)
        return

    //тут эта переменная нужна потому что иначе setFilterFixedString уберет или переставит индекс
    //когда мы изменим title во время поиска. И, соответственно, все что после функции которая меняет title,
    //сохранится неправильно.
    var sourceIndex = notesList.sortModel.mapToSource(notesList.sortModel.index(notesList.currentIndex, 0))

    if(notesList.model.setData(sourceIndex, qsTr(userinput.usertext.text), DiaryModel.TextRole))
        notesList.model.setData(sourceIndex, diaryList.currDate(), DiaryModel.LastEditRole)

    if(notesList.model.setData(sourceIndex, qsTr(userinput.titletext.text), DiaryModel.TitleRole))
        notesList.model.setData(sourceIndex, diaryList.currDate(), DiaryModel.LastEditRole)

    notesList.model.setData(sourceIndex, !userinput.favorite, DiaryModel.FavoriteRole)
}

function addButtonRealization() {
    if(topPannel.searchfield.text !== "")
        topPannel.searchfield.text = ""
    else
        updateModelInformation()

    topPannel.searchfield.state = ""
    diaryList.addItem()
    notesList.currentIndex = 0
    updateWindowInformation()
}

function arrowButtonRealization() {
    if(topPannel.searchfield.state == "Active" && notesList.currentIndex == -1)
        return
    if(notesList.state === "" || notesList.state === "Large")
        hideAllDelegates = true
    else
        hideAllDelegates = false
}

function searchButtonRealization() {
    if(searchField.state == "Active" )
        searchField.text=""

    if(searchField.state == "") {
        if(notesList.currentIndex != -1)
            updateModelInformation()
        notesList.currentIndex = -1
    }

    hideAllDelegates = false
    updateWindowInformation()

    searchField.state = searchField.state == "" ? "Active" : ""
}

function deleteButtonRealization() {
    var temp = notesList.currentIndex
    diaryList.deleteItem(notesList.sortModel.mapToSource(notesList.sortModel.index(notesList.currentIndex, 0)))
    if(notesList.sortModel.rowCount() === notesList.currentIndex) {temp--}
    notesList.currentIndex = temp
    updateWindowInformation()

    if(notesList.currentIndex === -1) {
        topPannel.searchfield.text = ""
        topPannel.searchfield.state = ""
    }
}

function changeFilter(searchText) {
    updateModelInformation()
    notesList.currentIndex = -1
    updateWindowInformation()
    notesList.sortModel.setFilterFixedString(searchText)
}

function focusOff() {
    userinput.titletext.focus = false
    userinput.usertext.focus = false
    topPannel.searchfield.textfocus = false
}

function acceptPassword(){
    if(myPassword===qSettings.myPassword){
        locked=false
        passwordRect.state="reanchored"
        unlockedAnim.start()
        //  unlockedAnim.start()
        endingPasswordAnim.start()
        // подпрыгивание
    }
    else{
        myPassword=""
        lockedAnim.start()
        //дерганье
    }
}
function settingsButtonRealization(){
    settingsSection.state = "Active"
    window.buttonsActive=false
}
function lockButtonRealization(){
    mainWindowItem.enabled=false
    passwordWindow.openingPasswordAnim.start()
    passwordWindow.myPassword=""
}

function createNewPassWord(){
    if(passwordField.text!==""){
        qSettings.myPassword = passwordField.text
        view.currentIndex++
    }
    else {
        wrongInputAnim.start()
    }
}
function validateOldPassword(){
    if (passwordOld.text === qSettings.myPassword)
    {
        if(changePasswordWindow.isChangingPassword){
           //set new password
           changePasswordWindow.swipeView.currentIndex=1
        }
        else if(changePasswordWindow.isRemoving){
            togglePasswordOn();
            changePasswordWindow.close();
        }
        else{
            console.log("wrong validateOldPassword to do next instruction")
            changePasswordWindow.close();
        }
    }
    else{
        passwordOld.text=""
    }
}
function whatToDoWithNewPassword(){
    //save new password
    if(changePasswordWindow.isChangingPassword){
        changePasswordWindow.isChangingPassword = false;
    }
    else if (!isRemoving){
        changePasswordWindow.isRemoving = false;
        togglePasswordOn();
    }
    else{
        console.log("wrong whatToDoWithNewPassword to do next instruction")
    }
    changePasswordWindow.close();
}

function togglePasswordOn(){
    if (qSettings.passwordOn){
        qSettings.passwordOn = false
    }
    else{
        qSettings.passwordOn = true
    }
}

