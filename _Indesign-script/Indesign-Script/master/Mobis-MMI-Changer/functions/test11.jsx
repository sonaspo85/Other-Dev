var doc = app.activeDocument;
var cSmmi = doc.characterStyles.item("C_MMI");
var cSmmiNobold = doc.characterStyles.item("C_MMI_NoBold");
var cSmmiKo = doc.characterStyles.item("C_MMI_KO");
var cSmmiWA = doc.characterStyles.item("C_Web_App");
var cSmmiWAnb = doc.characterStyles.item("C_Web_App_NoBold");
var cSmmiLtR1 = doc.characterStyles.item("C_MMI_LtoR");
var cSmmiLtR2 = doc.characterStyles.item("C_LtoR");
var mmiCS = [ cSmmi, cSmmiNobold, cSmmiKo, cSmmiWA, cSmmiWAnb, cSmmiLtR1, cSmmiLtR2 ]

for (var i=0; i < mmiCS.length; i++) {
	try {
		if (mmiCS[i].isValid) { //MMI 스타일이 있을 경우 진행
			gogo(doc, mmiCS[i]);
		} else {
			continue; //MMI 스타일이 없으면 다음 스타일로 넘어가도록
		}
	} catch(err) {
		alert (err.message + ", line: " + err.line);
	}
}

function gogo(doc, mmiCS) {
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
		var mmiText = findMMI[i].contents;
		var sText = mmiText.split("\uFEFF").join("");
		var mmiID = findMMI[i].appliedConditions[0].name;
		$.writeln(i + "-" + mmiID + ":" + sText);
	}
	//reset search
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;
}