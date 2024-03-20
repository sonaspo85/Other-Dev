#targetengine "session";
#include "functions/mmi-change-before.jsx";
#include "functions/mmi-set-conditional.jsx";
#include "functions/mmi-onoff.jsx";
#include "functions/mmi-set-id.jsx";
#include "functions/mmi-remove-condition.jsx";
#include "functions/mmi-changeLanguage.jsx";
#include "functions/mmi-check.jsx";
#include "functions/RemoveBlankPages.jsx";
#include "functions/mmi-selectedTextapplyID.jsx";
#include "functions/mmi-selectedTextChange.jsx";
#include "functions/mmi-list-view.jsx";
#include "functions/mmi-color-apply.jsx";
#include "functions/mmi-remove-setID.jsx";
#include "functions/mmi-noneStyle.jsx";
#include "functions/changeMMIsetcondition.jsx";

var script = app.activeScript;
var myScriptFolderPath = script.path;
// var myScriptFolderPath = "c:/Users/adfasdfasdf/appData/Roaming/Adobe/InDesign/Version 16.0-J/ko_KR/Scripts/Scripts Panel/Mobis-MMI-Changer"
var mmiFindChnageFile = new File(myScriptFolderPath + "/functions/MMI_List.txt");
mmiFindChnageFile = File(mmiFindChnageFile);

if (!mmiFindChnageFile.exists) {
	alert("Not found MMI_List.txt");
	exit();
}

var myResult = mmiFindChnageFile.open("r", undefined, undefined);
var myLine = mmiFindChnageFile.readln();
var mmiFindChangeArray = myLine.split("\t");

var w = new Window ("palette","Mobis HMI Changer ver.2.0.4");
group = w.add ('group {orientation: "column"}');
panel_00 = group.add ('panel {text: "언어 선택"}');
	var langDropdown = panel_00.add("dropdownlist", [0, 0, 180, 25]);
	var langlist = []
	for (var i=0; i<mmiFindChangeArray.length; i++) {
		var mmilist = mmiFindChangeArray[i];
		//alert(mmiFindChangeArray[i]);
		var langlist = langDropdown.add("item", mmilist);
	}
	btn_00 = panel_00.add("button", [0, 0, 180, 25], "HMI ID 보기");

panel_05 = group.add ('panel {text: "HMI ID : "}');
	btn_014 = panel_05.add("button", [0, 0, 180, 25], "선택한 HMI ID 확인")

panel_01 = group.add ('panel {text: "HMI ID 적용"}');
//panel_01.orientation = "row";
	btn_01 = panel_01.add("button", [0, 0, 180, 25], "북 파일 적용");
	btn_02 = panel_01.add("button", [0, 0, 180, 25], "열린 문서 모두 적용");
	btn_03 = panel_01.add("button", [0, 0, 180, 25], "현재 문서만 적용");
	btn_07 = panel_01.add("button", [0, 0, 180, 25], "선택한 용어 적용");

panel_02 = group.add ('panel {text: "HMI 다국어 변경"}');
//panel_01.orientation = "row";
	btn_04 = panel_02.add("button", [0, 0, 180, 25], "북 파일 변경");
	btn_05 = panel_02.add("button", [0, 0, 180, 25], "열린 문서 모두 변경");
	btn_06 = panel_02.add("button", [0, 0, 180, 25], "현재 문서만 변경");
	btn_08 = panel_02.add("button", [0, 0, 180, 25], "선택한 용어 변경");

panel_03 = group.add ('panel {text: "부가 기능"}');
//panel_01.orientation = "row";
	btn_006 = panel_03.add("button", [0, 0, 180, 25], "New HMI 형식 적용하기");
	btn_000 = panel_03.add("button", [0, 0, 180, 25], "HMI 표시기 확인하기");
	btn_001 = panel_03.add("button", [0, 0, 180, 25], "HMI ID 없음 확인하기");
	btn_016 = panel_03.add("button", [0, 0, 180, 25], "사용하지 않는 ID 삭제하기");
	// btn_011 = panel_03.add("button", [0, 0, 180, 25], "MMI ID 스타일 확인하기");
	// btn_002 = panel_03.add("button", [0, 0, 180, 25], "MMI Set Conditions");
	// btn_006 = panel_03.add("button", [0, 0, 180, 25], "MMI Disable Conditions");
	btn_010 = panel_03.add("button", [0, 0, 180, 25], "BOOK:HMI ID 제거하기");
	btn_013 = panel_03.add("button", [0, 0, 180, 25], "DOCU:HMI ID 제거하기");
	btn_005 = panel_03.add("button", [0, 0, 180, 25], "HMI 색상으로 확인");
	btn_007 = panel_03.add("button", [0, 0, 180, 25], "북 전체 페이지 계산");
	btn_009 = panel_03.add("button", [0, 0, 180, 25], "빈 페이지 삭제");
	btn_004 = panel_03.add("button", [0, 0, 180, 25], "메모 페이지 추가");
	btn_012 = panel_03.add("button", [0, 0, 180, 25], "열린 문서 IDML 출력");

// panel_04 = group.add ('panel {text: "Smart Reflow : "}');
// 	btn_003 = panel_04.add("button", [0, 0, 180, 25], "Smart Reflow ON/OFF");

var docs = app.documents;
if (docs.length == 0) {
	w.show();
} else {
	// stateOfSmartReflow();
	w.show();
	}

btn_014.onClick = function() { // HMI ID 확인하기
	var mID = "";
	var mySel = app.selection[0];
	if (mySel.contents == "") {
		// alert("선택된 텍스트가 없습니다.");
		panel_05.text = "HMI ID : None";
	}
	if (app.selection[0].appliedConditions[0] == undefined) {
		panel_05.text = "HMI ID : None";
	} else {
		mID = mySel.appliedConditions[0].name
		panel_05.text = "HMI ID : " + mID;
	}
}

btn_016.onClick = function() {
	removeUnusedConditions();
	alert("완료합니다.");
}

btn_01.onClick = function() {
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;
	var selectLang = langDropdown.selection.index;
	if (app.books.length == 0) {
		alert("인디자인 북 파일을 열어주세요.");
	} else if (app.books.length > 0) {
		var myBook = app.activeBook;
		var myBookContents = myBook.bookContents.everyItem().getElements();
		for(var i=0; i<myBookContents.length; i++) {
			var myPath = myBookContents[i].fullName;
			var myFile = File(myPath);
			if (myFile.name.search('Cover') > 0 || myFile.name.search('Index') > 0 || myFile.name.search('Trademarks') > 0 || myFile.name.search('Opensource') > 0) {
			} else
			var doc = app.open(myFile);
		}
		w.close();
		var docs = app.documents;
		var myWindow = new Window ('palette');
			myWindow.pbar = myWindow.add ('progressbar', undefined, 0, docs.length);
			myWindow.pbar.preferredSize.width = 300;
		myWindow.show();
		for (j=0; j<docs.length; j++) {
			myWindow.pbar.value = j+1;
			var openDocs = app.documents.everyItem().getElements();
			app.activeDocument = openDocs[openDocs.length-1];
			changeBefore();
			setidMMI(selectLang, mmiFindChnageFile);
			// setConditionaltxt();
			app.activeDocument.save();
			$.sleep(20); // Do something useful here
		}
		alert("완료");
		w.show();
	}
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.INTERACT_WITH_ALL;
};

btn_02.onClick = function() {
	var selectLang = langDropdown.selection.index;
	var doc = app.documents;
	if (doc.length == 0) {
		alert ("열려있는 인디자인 문서가 없습니다.");
	} else {
		w.close();
		var myWindow = new Window ('palette');
			myWindow.pbar = myWindow.add ('progressbar', undefined, 0, doc.length);
			myWindow.pbar.preferredSize.width = 300;
		myWindow.show();
		for (i=0; i<doc.length; i++) {
			myWindow.pbar.value = i+1;
			var openDocs = app.documents.everyItem().getElements();
			app.activeDocument = openDocs[openDocs.length-1];
			changeBefore();
			setidMMI(selectLang, mmiFindChnageFile);
			// setConditionaltxt();
			app.activeDocument.save();
			$.sleep(20); // Do something useful here
		}
		alert("완료");
		w.show();
	}
};

btn_03.onClick = function() {
	var selectLang = langDropdown.selection.index;
	var doc = app.documents;
	if (doc.length == 0) {
		alert ("열려있는 인디자인 문서가 없습니다.");
	} else {
		changeBefore();
		setidMMI(selectLang, mmiFindChnageFile);
		// setConditionaltxt();
		app.activeDocument.save();
	}
	alert("완료");
}

btn_07.onClick = function() {
	var selectLang = langDropdown.selection.index;
	var doc = app.documents;
	if (doc.length == 0) {
		alert ("열려있는 인디자인 문서가 없습니다.");
	} else {
		selectedTxTapplyID(selectLang, mmiFindChnageFile);
	}
}

btn_04.onClick = function() {
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;
	var selectLang = langDropdown.selection.index;
	if (app.books.length == 0) {
		alert("인디자인 북 파일을 열어주세요.");
	} else if (app.books.length > 0) {
		var myBook = app.activeBook;
		var myBookContents = myBook.bookContents.everyItem().getElements();
		for(var i=0; i<myBookContents.length; i++) {
			var myPath = myBookContents[i].fullName;
			var myFile = File(myPath);
			var result = true;
			if (myFile.name.search('Cover') > 0 || myFile.name.search('Index') > 0 || myFile.name.search('Trademarks') > 0 || myFile.name.search('Opensource') > 0) {
			} else
			var doc = app.open(myFile);
		}
		var docs = app.documents;
		w.close();
		
		for (j=0; j<docs.length; j++) {
			var openDocs = app.documents.everyItem().getElements();
			app.activeDocument = openDocs[openDocs.length-1];
			changeLanguage(selectLang, mmiFindChnageFile);
			app.activeDocument.save();
		}
		alert("완료");
		w.show();
	}
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.INTERACT_WITH_ALL;
};

btn_05.onClick = function(){
	var selectLang = langDropdown.selection.index;
	var doc = app.documents;
	if (doc.length == 0) {
		alert ("열려있는 인디자인 문서가 없습니다.");
	} else {
		w.close();
		var myWindow = new Window ('palette');
			myWindow.pbar = myWindow.add ('progressbar', undefined, 0, doc.length);
			myWindow.pbar.preferredSize.width = 300;
		myWindow.show();
		for (i=0; i<doc.length; i++) {
			myWindow.pbar.value = i+1;
			var openDocs = app.documents.everyItem().getElements();
			app.activeDocument = openDocs[openDocs.length-1];
			changeLanguage(selectLang, mmiFindChnageFile);
			app.activeDocument.save();
			$.sleep(20); // Do something useful here
		}
		alert("완료");
		w.show();
	}
};

btn_06.onClick = function(){
	var selectLang = langDropdown.selection.index;
	var doc = app.documents;
	if (doc.length == 0) {
		alert ("열려있는 인디자인 문서가 없습니다.");
	} else {
		changeLanguage(selectLang, mmiFindChnageFile);
		app.activeDocument.save();
	}
	alert("완료");
}

btn_08.onClick = function(){
	var selectLang = langDropdown.selection.index;
	var doc = app.documents;
	if (doc.length == 0) {
		alert ("열려있는 인디자인 문서가 없습니다.");
	} else {
		selectedTxTChange(selectLang, mmiFindChnageFile);
	}
}
btn_00.onClick = function() {
	var selectLang = langDropdown.selection.index;
	var selLang = langDropdown.selection;
	mmiListView(selLang, selectLang, mmiFindChnageFile);
}
btn_000.onClick = function() {
	var doc = app.activeDocument;
	var stausOfindicator = doc.conditionalTextPreferences.showConditionIndicators

	if (stausOfindicator == 1698908520) {
		doc.conditionalTextPreferences.showConditionIndicators = ConditionIndicatorMode.SHOW_INDICATORS;
		btn_000.text = "표시기 : 표시";
	}
	else if (stausOfindicator == 1698908531) {
		doc.conditionalTextPreferences.showConditionIndicators = ConditionIndicatorMode.SHOW_AND_PRINT_INDICATORS;
		btn_000.text = "표시기 : 표시 및 인쇄";
	}
	else if (stausOfindicator == 1698908528) {
		doc.conditionalTextPreferences.showConditionIndicators = ConditionIndicatorMode.HIDE_INDICATORS;
		btn_000.text = "표시기 : 숨기기";
	}
}
btn_001.onClick = function() {
	mmiChecker();
}
// btn_002.onClick = function() {
// 	setConditionaltxt();
// }
btn_009.onClick = function() {
	RemoveBlankPages();
}
// btn_003.onClick = function() {
// 	updateSmartReflow();
// }
btn_004.onClick = function() {
	var doc = app.activeDocument;
	var memoMaster = doc.masterSpreads.item('CH-Memo');
	if (memoMaster == null) {
		alert ("메모 마스터 페이지가 없습니다.")
		exit();
	} else
	doc.pages.add();
	doc.pages[-1].appliedMaster = doc.masterSpreads.item('CH-Memo');
}
btn_005.onClick = function() {
	applyColorMMIall();
}

btn_006.onClick = function() {
	ChangeMMI2condition()
}

btn_007.onClick = function() {
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;
	if (app.books.length == 0) {
		alert("인디자인 북 파일을 열어주세요.");
	} else if (app.books.length > 0) {
		var myBook = app.activeBook;
		var myBookContents = myBook.bookContents.everyItem().getElements();
		for(var i=0; i<myBookContents.length; i++) {
			var myPath = myBookContents[i].fullName;
			var myFile = File(myPath);
			var doc = app.open(myFile);
		}
		var docs = app.documents;
		var count = 0;
		for (j=0; j<docs.length; j++) {
			var openDocs = app.documents.everyItem().getElements();
			app.activeDocument = openDocs[openDocs.length-1];
			var myPages = app.activeDocument.pages;
			for (n=0; n<myPages.length; n++) {
				count ++;
			}
		}
		if (count%8 == 0) {
			alert(count + " 페이지, 8의 배수입니다.");
		} else {
			alert(count + " 페이지, 8의 배수가 아닙니다.");
		}
		for (var i = docs.length-1; i >= 0; i--) {
			docs[i].close(SaveOptions.YES);
		}
	}
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.INTERACT_WITH_ALL;
}

btn_010.onClick = function() {
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;
	if (app.books.length == 0) {
		alert("인디자인 북 파일을 열어주세요.");
	} else if (app.books.length > 0) {
		w.close();
		var myBook = app.activeBook;
		var myBookContents = myBook.bookContents.everyItem().getElements();
		for(var i=0; i<myBookContents.length; i++) {
			var myPath = myBookContents[i].fullName;
			var myFile = File(myPath);
			if (myFile.name.search('Cover') > 0 || myFile.name.search('Index') > 0 || myFile.name.search('Trademarks') > 0 || myFile.name.search('Opensource') > 0) {
			} else
			var doc = app.open(myFile);
		}
		var myWindow = new Window ('palette');
			myWindow.pbar = myWindow.add ('progressbar', undefined, 0, myBookContents.length);
			myWindow.pbar.preferredSize.width = 300;
		myWindow.show();
		var docs = app.documents;
		for (j=0; j<docs.length; j++) {
			myWindow.pbar.value = j+1;
			var openDocs = app.documents.everyItem().getElements();
			app.activeDocument = openDocs[openDocs.length-1];
			RemoveCondition();
			$.sleep(20); // Do something useful here
			app.activeDocument.save();
		}
		alert("완료");
		w.show();
	}
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.INTERACT_WITH_ALL;
}

btn_013.onClick = function() {
	alert("현재 열려있는 문서의 MMI ID를 제거합니다.");
	RemoveCondition();
	alert("완료");
}

// btn_011.onClick = function() {
// 	mmiStyleChecker();
// }

btn_012.onClick = function(){
	var doc = app.documents;
	if (doc.length == 0) {
		alert ("열려있는 인디자인 문서가 없습니다.");
	} else {
		w.close();
		var myFolder = Folder.selectDialog( "IDML 파일을 저장할 폴더를 선택하세요." );
		if ( myFolder == null ) {
			exit();
		} else
		var myWindow = new Window ('palette');
			myWindow.pbar = myWindow.add ('progressbar', undefined, 0, doc.length);
			myWindow.pbar.preferredSize.width = 300;
		myWindow.show();
		for (i=0; i<doc.length; i++) {
			myWindow.pbar.value = i+1;
			var openDocs = app.documents.everyItem().getElements();
			app.activeDocument = openDocs[openDocs.length-1];
			myFilePath = myFolder + "/" + app.activeDocument.name.split(".indd")[0] + ".idml"; //파일명 설정
			myFile = new File(myFilePath);
			app.activeDocument.exportFile(ExportFormat.INDESIGN_MARKUP, myFile); 
			// app.activeDocument.save();
			$.sleep(20); // Do something useful here
		}
		alert("완료");
		w.show();
	}
};

function updateSmartReflow() {
	var doc = app.activeDocument;
	var smartReflowStatus = doc.textPreferences.smartTextReflow;
	var state = "";
	if (smartReflowStatus == false) {
		doc.textPreferences.smartTextReflow = true;
		state = "켜짐";
	} else if (smartReflowStatus == true) {
		doc.textPreferences.smartTextReflow = false;
		state = "꺼짐";
	}
	panel_04.text = "Smart Reflow : " + state;
}
function stateOfSmartReflow() {
	var doc = app.activeDocument;
	var smartReflowStatus = doc.textPreferences.smartTextReflow;
	var state = "";
	if (smartReflowStatus == false) {
		state = "꺼짐";
	} else if (smartReflowStatus == true) {
		state = "켜짐";
	}
	panel_04.text = "Smart Reflow : " + state;
}

function removeUnusedConditions() {
	var cdns = app.activeDocument.conditions;
	var myWindow = new Window ('palette');
				myWindow.pbar = myWindow.add ('progressbar', undefined, 0, cdns.length);
				myWindow.pbar.preferredSize.width = 300;
				myWindow.show();
	for (i=0; i<cdns.length; i++) {
		myWindow.pbar.value = i+1;
		app.findGrepPreferences = app.changeGrepPreferences = null;
		app.findGrepPreferences.appliedConditions = [ cdns[i].name ];
		var myFound = app.activeDocument.findGrep();
		if (myFound.length == 0) cdns[i].remove();
		app.findGrepPreferences = app.changeGrepPreferences = null;
	}
}