var sBook = app.activeBook;
var sBookContents = sBook.bookContents.everyItem().getElements();
var sBookPath = sBook.filePath;
sBook.automaticPagination = false;
var sDoc;
for (var i=2;i<sBookContents.length;i++) {
    sDoc = File(sBookContents[i].fullName);
    app.open(sDoc);
}

xmlFile = new File(sBookPath + "/_hyperlinklist.xml");
xmlFile.open('w');
xmlFile.encoding = 'utf-8';
xmlFile.writeln("<?xml version='1.0' encoding='utf-8'?>")
xmlFile.writeln("<root>");

var doc = app.documents;
for (i=0;i<doc.length;i++) {
    exportCrossreference(doc[i], xmlFile);
}
xmlFile.writeln("</root>");
xmlFile.close();

for (i=doc.length-1; i >= 0; i--) {
    doc[i].close(SaveOptions.YES);
}
alert("완료합니다.");

function exportCrossreference(doc, xmlFile) {
    var sRef = doc.hyperlinks;
    var dest, mySourceText, targetDocument, targetName;
    for (var i=0;i<sRef.length;i++) {
        try {
            dest = sRef[i].destination;
            if (dest instanceof HyperlinkTextDestination) {
                mySourceText = sRef[i].source.sourceText;
                targetDocument = sRef[i].destination.parent.name;
                targetName = sRef[i].destination.name;

                xmlFile.writeln("\t<ref cDoc='" + doc.name +"' sourceText='" + mySourceText.contents + "' target='" + targetDocument + "' targetName='" + targetName + "' />")
            }
        } catch(e) {
            alert(e.line + ":" + e.body);
        }
    }
}
