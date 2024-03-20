app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;

var sBook = app.activeBook;
var sBookContents = sBook.bookContents.everyItem().getElements();
var sBookPath = sBook.filePath;
var sNum = 1;
var docName, dName, changeName, curFile;

sBook.automaticPagination = false;

var fileList = new File(sBookPath + "/_doculist.txt");
fileList.open("w");
fileList.encoding = "utf-8";

for (var i=2;i<sBookContents.length;i++) {
    // 파일명 앞에 번호를 확인한다.
    docName = sBookContents[i].name;
    fileNum = Number(docName.split('_')[0]);
    
    if (fileNum == sNum) {
        fileList.writeln(docName);
    } else {
        // 순서가 잘못된 경우, 파일명을 변경한 다음 _doculist.txt 파일에 파일명을 기록한다.
        dName = docName.replace(docName.split('_')[0] + '_', '');
        changeName = fillZero(sNum) + '_' + dName;
        curFile = File(sBookContents[i].fullName);
        curFile.rename(changeName);
        fileList.writeln(changeName);
    }
    sNum++;
};
fileList.close();

// 북 파일 제거 reverse loop
for (var i = sBookContents.length - 1; i >=2; i--) {
    sBookContents[i].remove();
}

// _doculist.txt 파일을 읽고 북파일에 추가한다.
fileList = File(sBookPath + "/_doculist.txt")
fileList.open('r')
var fLists = fileList.read().split("\n");
var addDocu;
for (var n=0;n<fLists.length-1;n++) {
    addDocu = File(sBookPath + "/" + fLists[n])
    sBook.bookContents.add(addDocu);
}

fileList.close();
sBook.automaticPagination = true;
app.scriptPreferences.userInteractionLevel = UserInteractionLevels.INTERACT_WITH_ALL;
alert("완료합니다.");


function fillZero(sNum) {
    str = sNum.toString();
    if (str.length < 3) {
        fNum = new Array(3 - str.length + 1).join('0').toString();
        return fNum + str;
    }
}