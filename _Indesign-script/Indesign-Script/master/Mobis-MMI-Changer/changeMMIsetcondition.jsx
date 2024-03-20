// function ChangeMMI2condition() {
// 	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;
// 	if (app.books.length == 0) {
// 		alert("인디자인 북 파일을 열어주세요.");
// 		exit();
// 	}

// 	var myBook = app.activeBook;
// 	var myBookContents = myBook.bookContents.everyItem().getElements();
// 	for(var i=0; i<myBookContents.length; i++) {
// 		var myPath = myBookContents[i].fullName;
// 		var myFile = File(myPath);
// 		if (myFile.name.search('Cover') > 0 || myFile.name.search('TOC') > 0 || myFile.name.search('Index') > 0 || myFile.name.search('Trademarks') > 0 || myFile.name.search('Opensource') > 0) {
// 		} else {
// 			var doc = app.open(myFile);
// 			var result = changeMMIsetCodtions(doc);
// 			if (result == false) {
// 				doc.close(SaveOptions.NO);
// 			} else {
// 				doc.close(SaveOptions.YES);
// 			}
// 		}
// 	}
// 	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.INTERACT_WITH_ALL;
// 	alert("완료합니다.");
// }

changeMMIsetCodtions()
function changeMMIsetCodtions() {
	var myDoc = app.activeDocument;
	myDoc.textPreferences.smartTextReflow = true;
	// MMI 조건부텍스트 ON
	var MMI = myDoc.conditions.item("MMI");
	
	try {
		if (MMI.isValid) {
			if (MMI.visible == false) {
				MMI.visible = true;
			}
		} else {
			return false;
		}
	} catch (e) {
		alert(e.line + ":" + e);
		exit();
	}
	var cSmmi = myDoc.characterStyles.item("C_MMI");
	var cSmmiNobold = myDoc.characterStyles.item("C_MMI_NoBold");
	var cSmmiKo = myDoc.characterStyles.item("C_MMI_KO");
	var cSmmiWA = myDoc.characterStyles.item("C_Web_App");
	var cSmmiWAnb = myDoc.characterStyles.item("C_Web_App_NoBold");
	var cSmmiLtR1 = myDoc.characterStyles.item("C_MMI_LtoR");
	var cSmmiLtR2 = myDoc.characterStyles.item("C_LtoR");
	var mmiCS = [ cSmmi, cSmmiNobold, cSmmiKo, cSmmiWA, cSmmiWAnb, cSmmiLtR1, cSmmiLtR2 ]
	// var mmiCS = [ cSmmiNobold ]

	// MMI가 적용된 단어를 찾는다.
	for (var i=0; i < mmiCS.length; i++) {
		try {
			if (mmiCS[i].isValid) {
				$.writeln(mmiCS[i].name + "있음");
				_ChangeType(myDoc, mmiCS[i]);
				// return true
			} else {
				$.writeln(i + " 없음");
				continue;
			}
		} catch(e) {
			alert(e.line + ":" + e);
			exit();
		}
	}
}

function _ChangeType(doc, mmiCS) {
	//reset search
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;

	//set find options
	app.findChangeGrepOptions.includeFootnotes = false;
	app.findChangeGrepOptions.includeHiddenLayers = false;
	app.findChangeGrepOptions.includeLockedLayersForFind = false;
	app.findChangeGrepOptions.includeLockedStoriesForFind = false;
	app.findChangeGrepOptions.includeMasterPages = false;

	app.findGrepPreferences.findWhat = "(\\$)(\\{MMI-\\d\\d\\d\\d\\})([^>]+)(\\$)";
	app.findGrepPreferences.appliedCharacterStyle = mmiCS;

	var findMMI = doc.findGrep();
	var cdns = doc.conditions;

	for (var j=0; j<findMMI.length; j++) {
		// MMI 아이디를 추출하고 조건부텍스트로 추가한다.
		var myID = findMMI[j].contents.match(/MMI-\d\d\d\d/).toString();
		var setID = cdns.item(myID);
		if (setID.isValid == true) {
			// 아이디가 조건부 텍스트로 있는 경우 아무것도 하지 않는다.
		} else {
			// 없는 경우 조건부 텍스트를 추가한다.
			doc.conditions.add({
				name: myID,
				indicatorColor: UIColors.GRID_GREEN,
				indicatorMethod: ConditionIndicatorMethod.useHighlight
			});
		}
		// ${MMI-XXXX} $ 삭제한다.
		var myText = findMMI[j].contents.replace(/(\$)(\{MMI-\d\d\d\d\})([^>]+)(\$)/g, "$3");
		$.writeln(mmiCS.name + " | " + myID + ":" + myText);
		findMMI[j].contents = myText;
		// MMI 아이디를 조건부텍스트로 적용한다.
		findMMI[j].appliedConditions = doc.conditions.item(myID);
	}
	
	//reset search
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;
}