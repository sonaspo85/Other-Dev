#targetengine "session";

var MainScriptPath = "C:/Program Files (x86)/Adobe/Adobe InDesign CS5.5/Scripts/Scripts Panel/";
var MainScriptFile = "AllinOne_Script.jsx";

if (app.documents.length == 0) {
	alert("인디자인 문서를 열고 실행해주세요.");
	var myScriptPath = MainScriptPath + MainScriptFile;
	var myScriptFile = new File (myScriptPath);
	$.evalFile(myScriptFile);
} else {
	Main();
}

function Main() {
langList = app.languagesWithVendors.everyItem().name;
var langDialog = app.dialogs.add({name:"Change Languages", canCancel:true});
with (langDialog) {
	with(dialogColumns.add()) {
		with(dialogRows.add())
	{
	staticTexts.add({staticLabel:"&Language", minWidth:40});
	chngDropDown = dropdowns.add ({stringList:langList, selectedIndex:0});
	}
	}
}
	if (langDialog.show() == true) {
		var doc = app.activeDocument;
		var pstyle = doc.allParagraphStyles;
		for (var a=2; a<pstyle.length; a++){
			pstyle[a].appliedLanguage = app.languagesWithVendors.item(chngDropDown.selectedIndex);
		}
	alert(app.languagesWithVendors.item(chngDropDown.selectedIndex).name + " 언어 설정 변경 완료");
	}
}