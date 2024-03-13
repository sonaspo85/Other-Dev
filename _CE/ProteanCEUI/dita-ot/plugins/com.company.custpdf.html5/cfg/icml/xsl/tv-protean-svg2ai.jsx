

var fontLists = ['SamsungOne-400', 'SamsungOneKorean-400', 'SamsungOneArabic-400', 'SamsungOneHebrew-400', 'Tahoma', 'Zawgyi-One', 'SamsungSVDMedium_T_CN', 'SamsungSVDMedium_S_CN'];
            
var w = new Window ("dialog","CE Protean Image Utility");  
group = w.add ('group {orientation: "column"}');
panel_00 = group.add ('panel {text: "폰트 선택"}');
var langDropdown = panel_00.add("dropdownlist", [0, 0, 180, 25], fontLists);
btn_00 = panel_00.add("button", [0, 0, 180, 25], "실행");

btn_00.onClick = function(){
    w.close();
    var selFont = langDropdown.selection.text;
    var myFolder = Folder.selectDialog('일러스트 파일이 있는 폴더를 선택하세요.', '~');
    try {
        if (myFolder != null) {
            var myFiles = new Array();
            var fileType = "*.svg";
            myFiles = myFolder.getFiles(fileType);
            if (myFiles.length == 0) {
                alert("선택한 폴더에 이미지가 없습니다.");
            } else {
                for (var n=0;n<myFiles.length;n++) {
                    // $.writeln(myFiles[n].name);
                    if (myFiles[n].name.indexOf('smart-ui-') > -1) {
                        var myDoc = app.open(myFiles[n]);
                        convertSVG2AI(myDoc, selFont);
                    }
                }
                alert("완료합니다.");
            }
        }
    } catch(e) {
        alert(e.line + ":" + e);
    }
};

w.show();

function convertSVG2AI(doc, aplFont) {
    app.userInteractionLevel = UserInteractionLevel.DONTDISPLAYALERTS;
    // var doc = app.activeDocument;
    var mainLay = doc.layers;
    
    // ai 파일로 저장
    var target = doc.path + "/" + doc.name.replace('.svg', '.ai');
    var tgFile = new File(target);
    doc.saveAs(tgFile);

    // placedItems 문서에 포함하기
    var myItems = doc.pageItems;
    for (var i=0;i<myItems.length;i++) {
        if (myItems[i].typename == "PlacedItem") {
            myItems[i].embed();
        }
    }

    // 대지 사이즈를 아트웍 테두리에 맞추기
    for (var i=0;i<myItems.length;i++) {
        // 모든 아이템 선택하기
        myItems[i].selected = true;
    }
    doc.fitArtboardToSelectedArt(0);

    // Group 오브젝트의 박스 - 선색 없음, 면색 없음 설정
    var noColor = new NoColor();
    for (var i=0;i<myItems.length;i++) {
        if (myItems[i].typename == "PathItem") {
            myItems[i].fillColor = noColor;
            myItems[i].strokeColor = noColor;
        }
    }

    // 모든 텍스트 박스의 서체 변경 - SamsungOne-400
    var tf = doc.textFrames;
    var paras;
    for (var x=0;x<tf.length;x++) {
        paras = tf[x].paragraphs
        for (var z=0;z<paras.length;z++) {
            paras[z].characterAttributes.textFont = app.textFonts.getByName(aplFont);
        }
    }

    doc.close(SaveOptions.SAVECHANGES);

    app.userInteractionLevel = UserInteractionLevel.DISPLAYALERTS;
}