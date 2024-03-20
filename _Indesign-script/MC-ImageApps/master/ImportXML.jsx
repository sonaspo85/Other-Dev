app.userInteractionLevel = UserInteractionLevel.DONTDISPLAYALERTS;

var myFolder = Folder.selectDialog('일러스트 파일이 있는 폴더를 선택하세요.', '~');

if (myFolder != null) {
	var myFiles = new Array();
	var fileType = '*.ai';
	myFiles = myFolder.getFiles(fileType);

	if (myFiles.length > 0) {
		var myDoc;

		for (var i=0; i<myFiles.length; i++) {
			myDoc = app.open(myFiles[i]);
			_importXML(myDoc);
			myDoc.close(SaveOptions.SAVECHANGES);
		}
		app.userInteractionLevel = UserInteractionLevel.DISPLAYALERTS;
		alert("완료합니다.");
	} else {
		alert("일러스트 파일이 없습니다.");
	}
}

function _importXML(doc) {
	// var doc = app.activeDocument;
	var docPath = doc.path;
	var file = new File(docPath + "/" + doc.name.split(".ai").join(".xml"));
	// $.writeln(sLanguage + " " + file);
	// var file = new File(docPath + "/A715_Callout.xml");
	var xmlFile = File(file);
	xmlFile.open("r");
	var myXMLObject = XML(xmlFile.read());
	xmlFile.close();
	var story = myXMLObject.xpath("//stories/story");
	//$.writeln( story.length() );
	// $.writeln(story[44]);
	var textRefs = doc.textFrames;
	for (var i=0; i<story.length(); i++) {
		var cont = story[i];
		var originaltxt = textRefs[i].contents;
		var changetxt = textRefs[i].contents.replace(originaltxt, cont);
		textRefs[i].contents = changetxt;
	}
}