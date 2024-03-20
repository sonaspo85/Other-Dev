function mmiChecker() {
	var doc = app.activeDocument;
	var cSmmi = doc.characterStyles.item("C_MMI");
	var cSmmiNobold = doc.characterStyles.item("C_MMI_NoBold");
	var cSmmiKo = doc.characterStyles.item("C_MMI_KO");
	var cSmmiWA = doc.characterStyles.item("C_Web_App");
	var cSmmiWAnb = doc.characterStyles.item("C_Web_App_NoBold");
	var cSmmiLtR1 = doc.characterStyles.item("C_MMI_LtoR");
	var cSmmiLtR2 = doc.characterStyles.item("C_LtoR");
	var mmiCS = [ cSmmi, cSmmiNobold, cSmmiKo, cSmmiWA, cSmmiWAnb, cSmmiLtR1, cSmmiLtR2 ]
	var count = 0;
	var result;
	for (var i=0; i < mmiCS.length; i++) {
		if (mmiCS[i].isValid) {
			result = checkMMID(doc, mmiCS[i]);
			count = count + result;
		} else {
			continue;
		}
	}
	if (count == 0) {
		alert("MMI ID를 모두 적용했습니다.");
	}
}

function checkMMID(doc, mmiCS) {
	//reset search
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;

	//set find options
	app.findChangeGrepOptions.includeFootnotes = false;
	app.findChangeGrepOptions.includeHiddenLayers = false;
	app.findChangeGrepOptions.includeLockedLayersForFind = false;
	app.findChangeGrepOptions.includeLockedStoriesForFind = false;
	app.findChangeGrepOptions.includeMasterPages = false;

	app.findGrepPreferences.findWhat = "(.*)?"
	app.findGrepPreferences.appliedCharacterStyle = mmiCS;
	var findMMI = doc.findGrep();
	var noneCount = 0;
	for (var j=0;j<findMMI.length;j++) {
		if (findMMI[j].appliedConditions[0] == undefined) {
			findMMI[j].select();
			app.activeWindow.activePage = findMMI[0].parentTextFrames[0].parentPage;
			app.activeDocument.layoutWindows[0].zoomPercentage = 300;
			alert(findMMI[j].contents + " 단어에 ID를 적용하지 않았습니다.");
			exit();
		} else {
			noneCount ++;
		}
	}
	//reset search
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;
	var total = findMMI.length - noneCount;
	return total;
}