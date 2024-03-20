#targetengine "session";
if (app.books.length == 0) {
	alert("인디자인 북 파일을 열어주세요.");
} else if (app.books.length > 0) {
	var myBook = app.activeBook
    var myDocs = myBook.bookContents;
	for (i=0; i<myDocs.length; i++) {
		app.open(myDocs[i].fullName, true);
		exportpdf ();
	}
	alert ("인디자인 개별 파일 PDF 출력 완료");
}
function exportpdf () {
	var doc = app.activeDocument;
	var myGraphics = doc.links;
	for (x=0; x < myGraphics.length; x++){
		myGraphics[x].update();
	}
	var myFolder = doc.filePath;
	//myFilePath = myFolder + "/" +  myBookFile.name.split(".indb")[0] + ".pdf"; //파일명 설정
	var myfile = File (myFolder + "/" + doc.name.split(".indd")[0] + ".pdf");
	doc.exportFile(ExportFormat.pdfType, myfile, false, app.pdfExportPresets.item('AST_CAR_Manual')); // pdf 내보내기 preset 설정
	doc.close(SaveOptions.no)
}