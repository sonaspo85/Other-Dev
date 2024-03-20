#include "lib.jsx";

function selectedTxTapplyID(selectLang, mmiFindChnageFile) {
	var doc = app.activeDocument;
	var sindex = selectLang;
	// var sindex = 2;
	// var myScriptFolderPath = "c:/Users/adfasdfasdf/appData/Roaming/Adobe/InDesign/Version 16.0-J/ko_KR/Scripts/Scripts Panel/Mobis-MMI-Changer/functions"
	// var mmiFindChnageFile = new File(myScriptFolderPath + "/MMI_List.txt");
	// if (!mmiFindChnageFile.exists) {
	// 	alert("Not found MMI_List.txt");
	// 	exit();
	// }
	var fileData = readTabDelimitedFile(mmiFindChnageFile);

	var mySelText = app.selection[0];
	var mmiText = mySelText.contents;
	var sText = mmiText.split("\uFEFF").join("");
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
			mySelText.appliedConditions = doc.conditions.item(mmiID);
			break;
		}
	}
}