var doc = app.documents;
var index_txt = new Array()
var docPath = app.activeDocument.filePath;
var cStyle = app.activeDocument.characterStyles.item("$ID/[None]")
var mmiStyle = app.activeDocument.characterStyles.item("$ID/MMI")
var mmiNobold = app.activeDocument.characterStyles.item("$ID/MMI_NoBold")
var findTXT;
// 참조 | \\d - 숫자 | \\s - 공백 |
index_txt.push("■ [UM_QSG] ► 문자스타일 없음\n");
findTXT = String.fromCharCode(0x25BA);
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] → 문자스타일 없음\n");
findTXT = String.fromCharCode(0x2192);
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] °C\n");
findTXT = "\\d\\s°C";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] AM\n");
findTXT = "\\d\\s(AM|am)";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] cm\n");
findTXT = "\\d\\s(CM|cm)";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] inches\n");
findTXT = "\\d\\s(I|i)nches";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] m\n");
findTXT = "\\d\\s(M|m)";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] MB\n");
findTXT = "\\d\\s(MB|mb)";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] minutes\n");
findTXT = "\\d\\s(M|m)inutes";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] non-network\n");
findTXT = "(N|n)on-network";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] on-screen\n");
findTXT = "(O|o)n-screen";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] PM\n");
findTXT = "\\d\\s(PM|pm)";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] S Pen\n");
findTXT = "(S|s) (P|p)en";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] seconds\n");
findTXT = "\\d\\s(S|s)econds";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] tray 1\n");
findTXT = "tray 1";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] tray 2\n");
findTXT = "tray 2";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] Type-C\n");
findTXT = "(T|t)ype-(C|c)";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] Wi-Fi\n");
findTXT = "Wi-Fi";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] W/kg\n");
findTXT = "\\d\\sW/kg";
fGrep(findTXT, cStyle);
index_txt.push("\n■ [UM_QSG] 공백+마침표\n");
findTXT = "\\s\\.";
fGrepX(findTXT);
index_txt.push("\n■ [UM_QSG] 공백+쉼표\n");
findTXT = "\\s\\,";
fGrepX(findTXT);
index_txt.push("\n■ [UM_QSG] 공백 두개 (공백 + 엔터 포함) - Grep 검색에서 \\\s\\\s 검색\n");
findTXT = "\\s\\s";
fGrepX(findTXT);
index_txt.push("\n■ [UM_QSG] 마침표 두개\n");
findTXT = "\\.\\.";
fGrepX(findTXT);
index_txt.push("\n■ [UM_QSG] 쉼표 두개\n");
findTXT = "\\,\\,";
fGrepX(findTXT);
index_txt.push("\n■ [UM_QSG] 엔터+mmi\n");
findTXT = "\\r";
fGrep(findTXT, mmiStyle);
index_txt.push("\n■ [UM_QSG] 강제개행1_대문자\n");
findTXT = "\\u\\r\\l"
fGrepX(findTXT);
index_txt.push("\n■ [UM_QSG] 강제개행2_소문자\n");
findTXT = "\\l\\r\\l"
fGrepX(findTXT);

//--------------------------------------------------
var myCStyle = app.activeDocument.allCharacterStyles;
for (n=1; n<myCStyle.length; n++) {
	switch (myCStyle[n].name) {
		case "MMI_NoBold": index_txt.push("\n■ [UM_QSG] 엔터+mmi_nobold\n");
			findTXT = "\\r";
			fGrep(findTXT, mmiNobold);
			break;
	}
}
//--------------------------------------------------

index_txt.push("\n■ [UM_QSG] massage\n");
findTXT = "(M|m)assage";
fGrepX(findTXT);
index_txt.push("\n■ [UM_QSG] samsong\n");
findTXT = "(S|s)amsong";
fGrepX(findTXT);

// "없음" 문자스타일 적용 검색
function fGrep (findTXT, chStyle) {
	for (var i=0; i<doc.length; i++) {
		app.findGrepPreferences = NothingEnum.nothing;
		app.changeGrepPreferences = NothingEnum.nothing;

		//Set the find options.
		app.findChangeGrepOptions.includeFootnotes = false;
		app.findChangeGrepOptions.includeHiddenLayers = false;
		app.findChangeGrepOptions.includeLockedLayersForFind = false;
		app.findChangeGrepOptions.includeLockedStoriesForFind = false;
		app.findChangeGrepOptions.includeMasterPages = false;
		
		app.findGrepPreferences.findWhat = findTXT;
		app.findGrepPreferences.appliedCharacterStyle = chStyle;
		var found = doc[i].findGrep();
		var count = 0
		for (var j=0; j<found.length; j++) {
			found[j];
			count++;
		}
		if (count > 0) {
			index_txt.push("\t" + doc[i].name + " : " + count + " 개\n");
		} else {
			continue
		}
	}
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;
}

// 문자스타일 없이 검색
function fGrepX (findTXT) {
	for (var i=0; i<doc.length; i++) {
		app.findGrepPreferences = NothingEnum.nothing;
		app.changeGrepPreferences = NothingEnum.nothing;

		//Set the find options.
		app.findChangeGrepOptions.includeFootnotes = false;
		app.findChangeGrepOptions.includeHiddenLayers = false;
		app.findChangeGrepOptions.includeLockedLayersForFind = false;
		app.findChangeGrepOptions.includeLockedStoriesForFind = false;
		app.findChangeGrepOptions.includeMasterPages = false;
		
		app.findGrepPreferences.findWhat = findTXT;
		var found = doc[i].findGrep();
		var count = 0
		for (var j=0; j<found.length; j++) {
			found[j];
			count++;
		}
		if (count > 0) {
			index_txt.push("\t" + doc[i].name + " : " + count + " 개\n");
		} else {
			continue
		}
	}
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;
}

var Report = new File(docPath +"/" + "UM-Grep-Report" + ".csv");  
Report.open("w");  
Report.write(index_txt);
Report.encoding = "UNICODE";
Report.close();
Report.execute();