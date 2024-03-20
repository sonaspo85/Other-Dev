function setidMMI(selectLang, mmiFile) {
	var doc = app.activeDocument;
	var sindex = selectLang;
	var cSmmi = doc.characterStyles.item("C_MMI");
	var cSmmiNobold = doc.characterStyles.item("C_MMI_NoBold");
	var cSmmiKo = doc.characterStyles.item("C_MMI_KO");
	var cSmmiWA = doc.characterStyles.item("C_Web_App");
	var cSmmiWAnb = doc.characterStyles.item("C_Web_App_NoBold");
	var cSmmiLtR1 = doc.characterStyles.item("C_MMI_LtoR");
	var cSmmiLtR2 = doc.characterStyles.item("C_LtoR");
	var mmiCS = [ cSmmi, cSmmiNobold, cSmmiKo, cSmmiWA, cSmmiWAnb, cSmmiLtR1, cSmmiLtR2 ]

	for (var j=0; j < mmiCS.length; j++) {
		try {
			if (mmiCS[j].isValid) { //MMI 스타일이 있을 경우 진행
				applyMMID(doc, mmiCS[j], sindex, mmiFile);
			} else {
				continue; //MMI 스타일이 없으면 다음 스타일로 넘어가도록
			}
		} catch(err) {
			alert (err.message + ", line: " + err.line);
		}
	}
}

function applyMMID(doc, mmiCS, sindex, mmiList) {
	var fileData = readTabDelimitedFile(mmiList);
	//reset search
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;

	//set find options
	app.findChangeGrepOptions.includeFootnotes = false;
	app.findChangeGrepOptions.includeHiddenLayers = false;
	app.findChangeGrepOptions.includeLockedLayersForFind = false;
	app.findChangeGrepOptions.includeLockedStoriesForFind = false;
	app.findChangeGrepOptions.includeMasterPages = false;

	// app.findGrepPreferences.findWhat = "(\\$)([^>]+)(\\$)";
	app.findGrepPreferences.appliedCharacterStyle = mmiCS;

	var findMMI = doc.findGrep();
	for (var i=0; i<findMMI.length; i++) {
		if (findMMI[i].appliedConditions[0] == undefined) {
			var mmiText = findMMI[i].contents;
			var sText = mmiText.split("\uFEFF").join("");
			// $.writeln(sText);
			for (var n=fileData.length - 1; n>=0; n--) {
				if (fileData[n][sindex] == sText) {
					// $.writeln(fileData[n][0] + " : " + fileData[n][sindex]);
					var mmiID = fileData[n][0];
					if (!doc.conditions.item(mmiID).isValid) {
						doc.conditions.add({
							name: mmiID,
							indicatorColor: UIColors.GRID_GREEN,
							indicatorMethod: ConditionIndicatorMethod.useHighlight
						});
					}
					findMMI[i].appliedConditions = doc.conditions.item(mmiID);
					break;
				}
			}
		}
	}
	//reset search
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;
}