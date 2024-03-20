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
			_eXportXML(myDoc);
			myDoc.close(SaveOptions.DONOTSAVECHANGES);
		}
		app.userInteractionLevel = UserInteractionLevel.DISPLAYALERTS;
		alert("완료합니다.");
	} else {
		alert("일러스트 파일이 없습니다.");
	}
}

function _eXportXML(doc) {
	// var doc = app.activeDocument;
	var docPath = doc.path;
	var textRefs = doc.textFrames;

	if (textRefs.length > 0) {
		var file = new File(docPath + "/" + doc.name.split(".ai").join(".xml"));
		file.encoding = "binary";
		file.open("w");
		file.write("\xEF\xBB\xBF");
		file.writeln("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		file.writeln("<Root>")
		file.writeln("<stories>");

		

		for (var i=0; i<textRefs.length; i++){
			var count = i + 1;
			var tFrame = textRefs[i];
			var paraStyle = [];
			//tFrame.selected;
			// app.doScript ("style-override", "MA");

			// $.write(count + " - " + textRefs[i].textRange.justification + " : " + textRefs[i].contents + "\n");
			var tcontents = tFrame.contents.replace(/\r/g, "&#xD;").replace("","").replace("►", "&#x25BA;").replace("►", "&#x25BA;").replace(/\•/g, "&#x2022;").replace(/\→/g, "&#x2192;").replace(/\■/g, "&#x25A0;").replace(/\↓/g, "&#x2193;").replace(/\↑/g, "&#x2191;").replace(/\←/g, "&#x2190;");
			var trealcont = tFrame.contents.replace(/\r/g, "&#xD;").replace("","").replace("►", "&#x25BA;").replace("►", "&#x25BA;").replace(/\•/g, "&#x2022;").replace(/\→/g, "&#x2192;").replace(/\■/g, "&#x25A0;").replace(/\↓/g, "&#x2193;").replace(/\↑/g, "&#x2191;").replace(/\←/g, "&#x2190;");
			var tWords = tFrame.words;
			var jcount = 0
			paraStyle = tFrame.textRange.paragraphStyles[0].name;
			// if (tFrame.textRange.justification == Justification.RIGHT) {
			// 	paraStyle = "Callout-L";
			// } else if (tFrame.textRange.justification == Justification.LEFT) {
			// 	paraStyle = "Callout-R";
			// } else if (tFrame.textRange.justification == Justification.CENTER) {
			// 	paraStyle = "Callout-C";
			// }

			try {
				for (var j=0; j<tWords.length; j++) {
					if (tWords[j].textFont.style.match("Semibold")) {
						jcount ++;
						var tagMMi = "<CharTag char-style=\"C_MMI\">" + tWords[j].contents + "</CharTag>";
						//tagMMI = <chartag char-style="C_MMI">{tWords[j].contents}</chartag>;
						var tagContents = trealcont.replace(tWords[j].contents, tagMMi);
					}
					else {
						continue;
					}
				}
				// $.write(count + " - " + jcount + "\n");
				if (jcount > 0) {
					// $.write(tagMMi + "\n");
					file.writeln("\t<story origin=\"" + tcontents + "\" para-style=\"" + paraStyle + "\" index=\"" + count + "\">" + tagContents.replace("\r", " ") + "</story>")
					//Story = <story Origin={tcontents} para-style={paraStyle} index={count}>{tagContents}</story>
					//Stories.appendChild(Story);
				} else if (jcount < 1) {
					file.writeln("\t<story Origin=\"" + tcontents + "\" para-style=\"" + paraStyle + "\" index=\"" + count + "\">" + trealcont + "</story>")
					//Story = <story Origin={tcontents} para-style={paraStyle} index={count}>{trealcont}</story>
					//Stories.appendChild(Story);
				}
			} catch(e) {
				alert(e.message);
				}
		}
		file.writeln("</stories>");
		file.writeln("</Root>");
		file.close();
		file.encoding="utf-8";
	}
}