function setidMMI(selectLang, mmiFindChnageFile) {
	var doc = app.activeDocument;
	var sindex = selectLang;
	// var sindex = 2;
	// var myScriptFolderPath = "C:/Users/adfasdfasdf/AppData/Roaming/Adobe/InDesign/Version 12.0-J/ko_KR/Scripts/Scripts Panel/functions"
	// var mmiFindChnageFile = new File(myScriptFolderPath + "/MMI_List.txt");
	var mmiList = mmiFindChnageFile;
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
			if (mmiCS[i].isValid) {//MMI 스타일이 있을 경우 진행
				gogo(mmiCS[i]);
			} else
				continue;//MMI 스타일이 없으면 다음 스타일로 넘어가도록
		} catch(err) {
			alert (err.message + ", line: " + err.line);
		}
	}

	function gogo(mmiCS) {
		//reset search
		app.findGrepPreferences = NothingEnum.nothing;
		app.changeGrepPreferences = NothingEnum.nothing;

		//set find options
		app.findChangeGrepOptions.includeFootnotes = false;
		app.findChangeGrepOptions.includeHiddenLayers = false;
		app.findChangeGrepOptions.includeLockedLayersForFind = false;
		app.findChangeGrepOptions.includeLockedStoriesForFind = false;
		app.findChangeGrepOptions.includeMasterPages = false;

		app.findGrepPreferences.findWhat = "(\\$)([^>]+)(\\$)";
		app.findGrepPreferences.appliedCharacterStyle = mmiCS;

		var findMMI = doc.findGrep();
		for (var i=0; i<findMMI.length; i++) {
			var selGrep = findMMI[i].select();
			var xText = app.selection[0].contents.split("$").join("");
			var sText = xText.split("\uFEFF").join("");
			// $.writeln(sText);
			var myID = findmmiID(sText, sindex, mmiList);
			function applyID (mmiID, sText) {
				app.changeGrepPreferences.changeTo = "$1{" + mmiID + "}$2$3";
				app.selection[0].changeGrep();
				//reset search
				// app.findGrepPreferences = NothingEnum.nothing;
				// app.changeGrepPreferences = NothingEnum.nothing;
			}
		}
		//reset search
		app.findGrepPreferences = NothingEnum.nothing;
		app.changeGrepPreferences = NothingEnum.nothing;

		function findmmiID(sText, sindex, mmiList) {
			mmiFindChnageFile = File(mmiList);
			var myResult = mmiFindChnageFile.open("r", undefined, undefined);
			if (myResult == true) {
				do  {
					var myLine = mmiFindChnageFile.readln();
					var mmiFindChangeArray = myLine.split("\t");
					var mmiID = mmiFindChangeArray[0]; //ID
					var mmiLang = mmiFindChangeArray[sindex] //selected language

					if (sText == mmiLang) {
						applyID(mmiID, sText);
					}
				} while(mmiFindChnageFile.eof == false);
					mmiFindChnageFile.close();
			}
		}
	}
}