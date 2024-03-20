var sBook = app.activeBook;
var sBookContents = sBook.bookContents.everyItem().getElements();
var sBookPath = sBook.filePath;
sBook.automaticPagination = false;
var sDoc;
for (var i=2;i<sBookContents.length;i++) {
    sDoc = File(sBookContents[i].fullName);
    app.open(sDoc);
}

var newRef = File(sBookPath + "/_new-hyperlinklist.xml");
newRef.open('r');
var xml = new XML(newRef.read());
newRef.close();
var doc = app.documents;

for (i=0;i<doc.length;i++) {
	try {
		var cDoc = doc[i]
		var hRef = cDoc.hyperlinks;
		var xRefFormat = cDoc.crossReferenceFormats.itemByName("전체 단락"); 
		var sSourceText, targetName, targetInfo, targetDoc, cSource, target, HypDest;
		for (var j=0;j<hRef.length;j++) {
			sSourceText = hRef[j].source.sourceText;
			targetInfo = _returnChangeDocuName(cDoc.name, sSourceText.contents, xml);
			// $.writeln(targetInfo)
			
			if (targetInfo != '') {
				targetDoc = targetInfo.split(":")[0];
				targetName = targetInfo.split(":")[1];
				hRef[j].remove();
				sSourceText.remove();
				cSource = cDoc.crossReferenceSources.add(sSourceText, xRefFormat);
				target = app.documents.itemByName(targetDoc);
				HypDest = target.hyperlinkTextDestinations.itemByName(targetName);
				cDoc.hyperlinks.add({
					source : cSource,
					destination : HypDest,
					highlight : HyperlinkAppearanceHighlight.INVERT
				})
			}
		}
	} catch(e) {
		alert(e.line + ":" + e);
	}
}
sBook.automaticPagination = true;
alert("완료합니다.");

function _returnChangeDocuName(docName, iText, xml) {
	$.writeln(docName + " - " + iText);
	var xmlRef = xml.xpath('/root/newRef');
	var curName, sText, tarName;
	for (var n=0;n<xmlRef.length();n++) {
		curName = xmlRef[n].attribute('cDoc').toString();
		sText = xmlRef[n].attribute('sourceText').toString();

		if (curName == docName && iText == sText) {
			tarDoc = xmlRef[n].attribute('target').toString();
			tarName = xmlRef[n].attribute('targetName').toString();
			return tarDoc + ":" + tarName;
		}
	}
	return ''
}