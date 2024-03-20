#include "lib.jsx";

function changeLanguage(selectLang, mmiFindChnageFile) {
	var doc = app.activeDocument;
	var sindex = selectLang;
	// var sindex = 2;
	// var myScriptFolderPath = "c:/Users/adfasdfasdf/appData/Roaming/Adobe/InDesign/Version 16.0-J/ko_KR/Scripts/Scripts Panel/Mobis-MMI-Changer/functions"
	// var mmiFindChnageFile = new File(myScriptFolderPath + "/MMI_List.txt");
	// if (!mmiFindChnageFile.exists) {
	// 	alert("Not found MMI_List.txt");
	// 	exit();
	// }
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
		if (mmiCS[i].isValid) {
			changeMMItext(doc, mmiCS[i], sindex, mmiList);
		} else {
			continue;
		}
	}
}

function changeMMItext(doc, mmiCS, sindex, mmiList) {
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

	// app.findGrepPreferences.findWhat = "(\\$)(\\{MMI-\\d\\d\\d\\d\\})([^>]+)(\\$)";
	// $.writeln(mmiCS.name);
	app.findGrepPreferences.appliedCharacterStyle = mmiCS;
	var findMMI = doc.findGrep();
	try {
		for (var j=0;j<findMMI.length; j++) {
			if (findMMI[j].appliedConditions[0] != undefined) {
				// $.writeln(j + ":" + findMMI[j].appliedConditions[0].name + " - " + findMMI[j].contents);
				var myID = findMMI[j].appliedConditions[0].name;
				for (var n=fileData.length - 1; n>=0; n--) {
					if (fileData[n][0] == myID) {
						if (fileData[n][sindex] == "" || fileData[n][sindex] == null) {
							findMMI[j].contents = "!!!" + findMMI[j].contents;
							break;
						} else {
							findMMI[j].contents = fileData[n][sindex];
							break;
						}
					}
				}
			}
		} 
	} catch(e) {
		alert(j + " - " + e.line + ":" + e.message)
	}
	//reset search
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;
}