function changeBefore() {
	var doc = app.activeDocument;
	var cSmmi = doc.characterStyles.item("C_MMI");
	var cSmmiNobold = doc.characterStyles.item("C_MMI_NoBold");
	var cSmmiKo = doc.characterStyles.item("C_MMI_KO");
	var cSmmiWA = doc.characterStyles.item("C_Web_App");
	var cSmmiWAnb = doc.characterStyles.item("C_Web_App_NoBold");
	var cSmmiLtR1 = doc.characterStyles.item("C_MMI_LtoR");
	var cSmmiLtR2 = doc.characterStyles.item("C_LtoR");
	var mmiCS = [ cSmmi, cSmmiNobold, cSmmiKo, cSmmiWA, cSmmiWAnb, cSmmiLtR1, cSmmiLtR2 ]

	var MMI = doc.conditions.item("MMI");
	if (MMI == null) {
		for (var i=0; i < mmiCS.length; i++) {
			if (mmiCS[i].isValid) {
				gogo(mmiCS[i]);
			} else
				continue;
		}
	} else

	if (MMI.visible == false) {
		MMI.visible = true;
		for (var i=0; i < mmiCS.length; i++) {
			if (mmiCS[i].isValid) {
				gogo(mmiCS[i]);
			} else
				continue;
		}
	} else 
		for (var i=0; i < mmiCS.length; i++) {
			if (mmiCS[i].isValid) {
				gogo(mmiCS[i]);
			} else
				continue;
		}

	function gogo(mmiCS) {
		//Enter에 적용된 문자 스타일 해제
		app.findGrepPreferences = app.findChangeGrepOptions = NothingEnum.nothing;
		app.changeGrepPreferences = app.findChangeGrepOptions = NothingEnum.nothing;
		app.findGrepPreferences.properties = {
			findWhat : "(\\r)",
		}
		app.findChangeGrepOptions.properties = {
			includeFootnotes:false,
			includeHiddenLayers:false,
			includeLockedLayersForFind:false,
			includeLockedStoriesForFind:false,
			includeMasterPages:false,
		}
		app.changeGrepPreferences.appliedCharacterStyle = app.characterStyles.item("$ID/[None]"),
		app.changeGrepPreferences.changeTo = "",
		doc.changeGrep();
		app.findGrepPreferences = app.findChangeGrepOptions = NothingEnum.nothing;
		app.changeGrepPreferences = app.findChangeGrepOptions = NothingEnum.nothing;
		
		//reset search
		app.findGrepPreferences = NothingEnum.nothing;
		app.changeGrepPreferences = NothingEnum.nothing;

		//set find options
		app.findChangeGrepOptions.includeFootnotes = false;
		app.findChangeGrepOptions.includeHiddenLayers = false;
		app.findChangeGrepOptions.includeLockedLayersForFind = false;
		app.findChangeGrepOptions.includeLockedStoriesForFind = false;
		app.findChangeGrepOptions.includeMasterPages = false;

		app.findGrepPreferences.appliedCharacterStyle = mmiCS;
		var findMMI = doc.findGrep();
		for (var i=0; i<findMMI.length; i++) {
			var selGrep = findMMI[i].select();
			var sText = app.selection[0].contents;
			var appliedTxT = "$"
			if (sText.indexOf(appliedTxT) != -1) { // 포함일 경우
				continue
			} else // 미포함일 경우
				changebarcket(sText);
		}
		function changebarcket(sText) {
			app.changeGrepPreferences.changeTo = "$" + sText + "$";
			app.selection[0].changeGrep();
		}
	}
}