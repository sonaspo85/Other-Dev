if (app.books.length == 0) {
	alert ("북 파일을 열어 놓은 상태에서 실행하세요.")
	exit();
} else

var root = new XML("<root/>");
var BMs = new XML("<stories/>");
root.appendChild(BMs);

var book = app.activeBook;
var bookcontents = book.bookContents;
var bookPath = book.filePath;

app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;

for (var n=0; n<bookcontents.length; n++) {
	if (bookcontents[n].name.indexOf("Cover") != -1 || bookcontents[n].name.indexOf("TOC") != -1) {
		continue
	}
	app.open(bookcontents[n].fullName, true);
	exportXMLfromheading();
	app.activeDocument.close();
}

app.scriptPreferences.userInteractionLevel = UserInteractionLevels.INTERACT_WITH_ALL;

function exportXMLfromheading() {
	var doc = app.activeDocument;
	var docfName = doc.name.replace(".indd", "");
	var story = doc.stories;
	var star = "%star%";
	var starf = "%starf%";
	var para, paraStyle, pContents, item
	for (var i=0; i<story.length; i++) {
		var paras = story[i].paragraphs.everyItem().getElements();
		for (var j=0; j<paras.length; j++) {
			para = paras[j];
			paraStyle = para.appliedParagraphStyle.name;
			pContents = para.contents.replace("\r", "").replace(/\ufeff/g, "").replace(/\u2606/g, star).replace(/\u2605/g, starf).replace(/(\s)*$/g, "");
			try {
				if (paraStyle.indexOf("Heading1") != -1) {
					// $.writeln(doc.name + "\t" + "1" + "\t" + paraStyle + "\t" + para.contents);
					item = <item file={docfName} depth="1" style={paraStyle} contents={pContents}></item>;
					BMs.appendChild(item);
				} else if (paraStyle.indexOf("Heading2") != -1) {
					item = <item file={docfName} depth="2" style={paraStyle} contents={pContents}></item>;
					BMs.appendChild(item);
				} else if (paraStyle.indexOf("Heading3") != -1) {
					item = <item file={docfName} depth="3" style={paraStyle} contents={pContents}></item>;
					BMs.appendChild(item);
				} else if (paraStyle.indexOf("Heading4") != -1) {
					item = <item file={docfName} depth="3" style={paraStyle} contents={pContents}></item>;
					BMs.appendChild(item);
			} catch (e) {
				alert(e);
			}
		}
	}
}

var file = new File(bookPath + "/" + book.name.split(".indb").join(".xml"));
var xml = root.toXMLString();
file.open("w");
file.encoding = "UTF-8";
file.write(xml);
 
file.close();

alert("Complete");