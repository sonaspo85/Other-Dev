var doc = app.activeDocument;

var finds = "(?!\\r)^~a\\s(\\w|\\()";
var finds1 = "\\.\\s~a\\s(\\w|\\()";
var finds2 = "^(\\w|\\()";
// var finds2 = "^";
var nwb = String.fromCharCode(0xFEFF);


app.findGrepPreferences = NothingEnum.nothing;
app.changeGrepPreferences = NothingEnum.nothing;

//Set the find options.
app.findChangeGrepOptions.includeFootnotes = false;
app.findChangeGrepOptions.includeHiddenLayers = false;
app.findChangeGrepOptions.includeLockedLayersForFind = false;
app.findChangeGrepOptions.includeLockedStoriesForFind = false;
app.findChangeGrepOptions.includeMasterPages = false;

app.findGrepPreferences.findWhat = finds;

var found = doc.findGrep();
var count = 0, count1 = 0;

for (var i=found.length-1; i>=0; i--) {
	if (found[i].paragraphs[0].characters[0].contents == nwb) {
		// $.writeln(i + ":: Error 111");
	} else {
		found[i].insertionPoints[0].contents = nwb;
		// found[i].insertionPoints[0].contents = "son111";
		count++;
	}
}

app.findGrepPreferences = NothingEnum.nothing;
app.changeGrepPreferences = NothingEnum.nothing;

app.findGrepPreferences.findWhat = finds1;

var found1 = doc.findGrep();

for (var j=found1.length-1; j>=0; j--) {
	if (found1[j].characters[2].contents == nwb) {
		// $.writeln(j + ":: Error 2222");
	} else {
		found1[j].insertionPoints[2].contents = nwb;
		// found1[j].insertionPoints[2].contents = "son222";
		count1++;
	}
}

// $.writeln("중간-" + count1 + " ::: " + "else " + count);

app.findGrepPreferences = NothingEnum.nothing;
app.changeGrepPreferences = NothingEnum.nothing;

// sonaspo----------------------------------------------
var osd1 = doc.characterStyles.item("C_OSD");
var osd2 = doc.characterStyles.item("C_OSD-NoBold");
var osd3 = doc.characterStyles.item("C_Notrans");
var osd4 = doc.characterStyles.item("C_Notrans-NoBold");
var osdlist = [ osd1, osd2, osd3, osd4 ]



// var toccStyle = doc.characterStyles.itemByName('C_OSD-NoBold');
// var pStyle = doc.paragraphStyles.itemByName('UnorderList_2_1');

for (var y=0;y<osdlist.length;y++) {
	app.findGrepPreferences.findWhat = finds2;
	// app.findGrepPreferences.appliedParagraphStyle = pStyle;
	app.findGrepPreferences.appliedCharacterStyle = osdlist[y];
	
	var found2 = doc.findGrep();
	var count = 0, count1 = 0;
	// paragraphs : 단락 집합의 모음
	for (var i=found2.length-1; i>=0; i--) {
		if (found2[i].paragraphs[0].characters[0].contents == nwb) {
		} else {
			found2[i].insertionPoints[0].contents = nwb;
			// found2[i].insertionPoints[0].contents = "son111";
			// doc.characterStyles[i]
			count++;
		}
	}
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;

}

alert("완료합니다.");