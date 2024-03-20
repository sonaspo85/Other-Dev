if (app.books.length == 0) {
	alert("열려있는 북 파일이 없습니다.");
	exit();
}

// 경고창 비활성화
app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;

var myBook = app.activeBook;
var bookPath = myBook.filePath;
var fileToWrite = new File(bookPath + "/" + myBook.name.replace(/\.indb$/,"")  + ".csv");

var ok = fileToWrite.open("w");  
if (!ok) {  
	alert("Error: " + fileToWrite.error);  
	exit();  
}

var text = File (fileToWrite);
text.encoding = "utf-8"; //Encoding for Windows/Excel
text.open ("w");

var myBookContents = myBook.bookContents.everyItem().getElements();
for (var b=0; b<myBookContents.length; b++) {
	var myPath = myBookContents[b].fullName;
	var bookDoc = File(myPath);
	var curDoc = app.open(bookDoc);
	
	writeStroies(text, curDoc);
	curDoc.close(SaveOptions.NO);
}

// 경고창 활성화
app.scriptPreferences.userInteractionLevel = UserInteractionLevels.interactWithAll;

fileToWrite.close();
alert("Complete");


function writeStroies(text, doc) {
	app.findTextPreferences = NothingEnum.nothing;
	app.changeTextPreferences = NothingEnum.nothing;

	app.findGrepPreferences.findWhat = "[^\r]+";  

	var myFound = doc.findGrep();

	for (i=0; i<myFound.length; i++) {
		// $.writeln(myFound[i].contents);
		// text.writeln(myFound[i].parentTextFrames[0].parentPage.name + ":::" + myFound[i].contents.split("\t")[0]);
		text.writeln("es" + "\t" + myFound[i].contents.split("\t")[0].replace(/\ufeff/g, "").replace(/\ufffc/g, ""));
	}

	app.findTextPreferences = NothingEnum.nothing;
	app.changeTextPreferences = NothingEnum.nothing;
}