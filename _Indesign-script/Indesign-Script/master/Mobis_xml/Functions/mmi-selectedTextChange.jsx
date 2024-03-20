#include "lib.jsx";

function selectedTxTChange(selectLang, mmiFindChnageFile) {
	var doc = app.activeDocument;
	var sindex = selectLang;
	// var sindex = 3;
	// var myScriptFolderPath = "c:/Users/adfasdfasdf/appData/Roaming/Adobe/InDesign/Version 16.0-J/ko_KR/Scripts/Scripts Panel/Mobis-MMI-Changer/functions"
	// var mmiFindChnageFile = new File(myScriptFolderPath + "/MMI_List.txt");
	// if (!mmiFindChnageFile.exists) {
	// 	alert("Not found MMI_List.txt");
	// 	exit();
	// }
	var fileData = readTabDelimitedFile(mmiFindChnageFile);

	var mySelText = app.selection[0];
	if (mySelText.appliedConditions[0] == undefined) {
		alert("MMI ID 값이 적용되어 있지 않습니다.");
		exit();
	}
	var myID = mySelText.appliedConditions[0].name;
	for (var n=fileData.length - 1; n>=0; n--) {
		if (fileData[n][0] == myID) {
			if (fileData[n][sindex] == "" || fileData[n][sindex] == null) {
				mySelText.contents = "!!!" + mySelText.contents;
				break;
			} else {
				mySelText.contents = fileData[n][sindex];
				break;
			}
		}
	}
}