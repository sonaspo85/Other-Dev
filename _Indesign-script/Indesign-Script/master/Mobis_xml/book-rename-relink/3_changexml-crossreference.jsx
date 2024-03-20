var sBook = app.activeBook;
var sBookPath = sBook.filePath;
var refxml = File(sBookPath + "/_hyperlinklist.xml");
var newRef = new File(sBookPath + "/_new-hyperlinklist.xml")
var fileList = File(sBookPath + "/_doculist.txt")
fileList.open('r')
var fLists = fileList.read().split("\n");

if (refxml.exists) {
    try {
        refxml.open('r');
        var xml = new XML(refxml.read());
        
        refxml.close();

        var hrefs = xml.xpath("/root/ref");
        var curDoc, trDoc, nDoc, ntrDoc, sText, targetName;
        newRef.open('w');
        newRef.encoding = 'utf-8';
        newRef.writeln("<?xml version='1.0' encoding='utf-8'?>");
        newRef.writeln("<root>");
        for (var i=0;i<hrefs.length();i++) {
            // 현재 문서 이름 바꾸기
            curDoc = hrefs[i].attribute('cDoc').toString();
            nDoc = changeDocument(curDoc, fLists);

            // 타켓 문서 이름 바꾸기
            trDoc = hrefs[i].attribute('target').toString();
            ntrDoc = changeDocument(trDoc, fLists);

            sText = hrefs[i].attribute('sourceText').toString();
            targetName = hrefs[i].attribute('targetName').toString();
            newRef.writeln("\t<newRef cDoc='" + nDoc +"' sourceText='" + sText + "' target='" + ntrDoc + "' targetName='" + targetName + "' />")
        }
        newRef.writeln("</root>");
        newRef.close();
    } catch(e) {
        alert(e.line + ":" + e.body);
    }
}
fileList.close();
alert("완료합니다.");

function changeDocument(tDocu, fLists) {
	var firstNum = tDocu.split('_')[0];
	var docuName = tDocu.replace(firstNum + '_', '');
	var sfNum, sfListName;
	for (var j=0;j<fLists.length;j++) {
		sfNum = fLists[j].split('_')[0];
		sfListName = fLists[j].replace(sfNum + '_', '');
		if (docuName == sfListName) {
			// $.writeln(docuName + " ::: " + sfListName)
			return fLists[j];
		}
	}
	// 일치하는것이 없으면 빈 값을 반환한다.
	return '';
}