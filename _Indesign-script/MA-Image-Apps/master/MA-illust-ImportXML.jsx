var appVer = GetAppVersion();

// C:\Program Files\Adobe\Adobe Illustrator 2023\Presets\ko_KR\스크립트
var settings = 'c:\\Program Files\\Adobe\\Adobe Illustrator ' + appVer + '\\Presets\\ko_KR\\스크립트\\settings.xml';
var xmlFile = File(settings);
if (!xmlFile.exists) {
	alert(xmlFile + " 파일이 존재하지 않습니다.");
} else {
	xmlFile.open('r');
	var xmlObj = new XML(xmlFile.read());
	xmlFile.close();

	var w = new Window ("dialog","MA ImageApps Importer ");  

	
	var fontsets = xmlObj.xpath("//fontset");
	group = w.add ('group {orientation: "column"}');
	panel_00 = group.add ('panel {text: "그룹 선택"}');	
	var fontsetDropdown = panel_00.add("dropdownlist", [0, 0, 180, 25]);
	// var fontsetList = []
	for (i=0; i<fontsets.length(); i++) {
		// fontsetList = fontsetDropdown.add("item", fontsets[i].attribute('id'))
		fontsetDropdown.add("item", fontsets[i].attribute('id'))
	}
	
	var styles = xmlObj.xpath("//fontset[1]/style");
	// group = w.add ('group {orientation: "column"}');
	panel_01 = group.add ('panel {text: "언어 선택"}');	
	var langDropdown = panel_01.add("dropdownlist", [0, 0, 180, 25]);
	// var langlist = []
	// for (var i=0; i<styles.length(); i++) {
	// 	var langNameList = styles[i].attribute('lang').toString().replace('simple_', '간소화');
	// 	var langlist = langDropdown.add("item", langNameList);
	// }

	btn_01 = panel_01.add("button", [0, 0, 180, 25], "실행");
}

fontsetDropdown.onChange = function() {

	langlist = langDropdown.removeAll();
	query = '//fontset[@id="' +  fontsetDropdown.selection.toString() + '"]/style';
	styles = xmlObj.xpath(query);
	for (var i=0; i<styles.length(); i++) {
		langNameList = styles[i].attribute('lang').toString().replace('simple_', '간소화');
		langDropdown.add("item", langNameList);
		// langlist = langDropdown.add("item", langNameList);
	}
}

btn_01.onClick = function() {
	w.close();
	// var language = selLang.toString().replace('간소화', 'simple_');
	// var myStyle = xmlObj.xpath('//style[@lang="' + language + '"]');
	var fontset = fontsetDropdown.selection.toString()
	var language = langDropdown.selection.toString().replace('간소화', 'simple_');
	var query = '//fontset[@id="' +  fontset + '"]/style[@lang="' + language + '"]';
	alert(query)
	var myStyle = xmlObj.xpath(query);
	var pFont = myStyle.attribute('para-name');
	var sIndex = _getFonts(pFont);
	if (sIndex == undefined) {
		alert(pFont + " 폰트가 설치되어 있지 않습니다.");
		return;
	}
	var pSize = myStyle.attribute('size');
	var pLeading = myStyle.attribute('leading');
	var pHorizon = myStyle.attribute('horizon');
	var pLigature = myStyle.attribute('ligature');
	var pRtL = myStyle.attribute('RtL');
	// var pColor = myStyle.attribute('color');
	var pComposer = myStyle.attribute('composer');
	var pKerning = myStyle.attribute('kerning');
	var cFont = myStyle.attribute('char-name');
	var cIndex = _getFonts(cFont);
	if (cIndex == undefined) {
		alert(cFont + " 폰트가 설치되어 있지 않습니다.");
		return
	}
	var cTags = myStyle.attribute('charTag-style').toString();
	var cEngCName = myStyle.attribute('eng-char-name');
	var cEngSize = myStyle.attribute('eng-size');
	
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
				_changeParaFont(myDoc, language, sIndex, pSize, pLeading, pHorizon, pLigature, pKerning, pRtL, pComposer, cIndex);
				if (cTags.split(", ").length > 1) {
					_addengTag(myDoc, cTags, cEngSize, cEngCName);
				}
				_importXML(myDoc);
				myDoc.close(SaveOptions.SAVECHANGES);
			}
			app.userInteractionLevel = UserInteractionLevel.DISPLAYALERTS;
			alert("완료합니다.");
		} else {
			alert("일러스트 파일이 없습니다.");
		}
	}
}
w.show();

function _addengTag(doc, cTags, cSize, cEngCName) {
	var chTags = cTags.split(", ")
	// create c_eng style
	var count = 0;
	for (var i=1; i<doc.characterStyles.length; i++) {
		if (doc.characterStyles[i].name == chTags[1]) {
			count++;
		}
	}
	if (count == 0) {
		var cEngTag = doc.characterStyles.add(chTags[1]);
	} else {
		var cEngTag = doc.characterStyles.getByName(chTags[1]);
	}
	var eIndex = _getFonts(cEngCName);
	if (eIndex == undefined) {
		// alert(cEngCName + " 폰트가 설치되어 있지 않습니다. NotoSans 폰트로 대체합니다.");
		eIndex = _getFonts("NotoSans")
		if (eIndex == undefined) {
			alert("NotoSans 폰트가 없습니다. C_Eng 문자 스타일의 폰트를 설정하지 않은 채 진행합니다. ")
			return
		}
	}
	cEngTag.characterAttributes.textFont = app.textFonts[eIndex];
	cEngTag.characterAttributes.size = Number(cSize);
}

function _getFonts(fontName) {
	var fontLists = app.textFonts

	for (var i=0; i<fontLists.length; i++) {
		if (fontLists[i].name == fontName) {
			return i
		};
	}
}

function _changeParaFont(doc, slang, sIndex, pSize, pLeading, pHorizon, pLigature, pKerning, pRtL, pComposer, cIndex) {
	var pStyles = doc.paragraphStyles;
	var cStyles = doc.characterStyles;
	var strColor = new CMYKColor();
		strColor.black = 100;
		strColor.cyan = 100;
		strColor.magenta = 100;
		strColor.yellow = 100;
	
	try {
		for (var i=1; i<pStyles.length; i ++) {
			pStyles[i].characterAttributes.textFont = app.textFonts[sIndex];
			pStyles[i].characterAttributes.size = Number(pSize);
			pStyles[i].characterAttributes.leading = Number(pLeading);
			pStyles[i].characterAttributes.horizontalScale = Number(pHorizon);
			pStyles[i].characterAttributes.tracking = 0;
			// pStyles[i].characterAttributes.fillColor = pColor;
			if (pLigature == "false") {
				pStyles[i].characterAttributes.ligature = false;
			} else {
				pStyles[i].characterAttributes.ligature = true;
			}
			// if (pKerning != "null") {
			// 	pStyles[i].characterAttributes.tracking = 0;
			// } else {
			// 	pStyles[i].characterAttributes.tracking = Number(pKerning);
			// }
			if (pRtL == "false") {
				pStyles[i].paragraphAttributes.paragraphDirection = ParagraphDirectionType.LEFT_TO_RIGHT_DIRECTION
			} else {
				pStyles[i].paragraphAttributes.paragraphDirection = ParagraphDirectionType.RIGHT_TO_LEFT_DIRECTION
			}
			if (pComposer == "2") { //adobe 전체
				pStyles[i].paragraphAttributes.composerEngine = ComposerEngineType.latinCJKComposer;
				pStyles[i].paragraphAttributes.everyLineComposer = true;
			} else if (pComposer == "1") { //동남아
				pStyles[i].paragraphAttributes.composerEngine = ComposerEngineType.optycaComposer;
				pStyles[i].paragraphAttributes.everyLineComposer = false;
			} else if (pComposer == "0") { //adobe 단일
				pStyles[i].paragraphAttributes.composerEngine = ComposerEngineType.latinCJKComposer;
				pStyles[i].paragraphAttributes.everyLineComposer = false;
			}
			if (slang == "Arabic/Farsi") {
				pStyles[i].characterAttributes.language = LanguageType.ARABIC;
			}
		}
		if (cStyles.length > 1) {
			for (var j=1; j<cStyles.length; j++) {
				cStyles[j].characterAttributes.textFont = app.textFonts[cIndex];
				if (slang == "Myanmar" || slang == "[QSG]Myanmar") {
					cStyles[j].characterAttributes.strokeWeight = 0.25;
					cStyles[j].characterAttributes.strokeColor = strColor;
				}
			}
		}
	} catch(e) {
		alert(e.line + " : " + e);
	}
}




function _importXML(doc) {
	var docPath = doc.path;
	var file = new File(docPath + "/" + doc.name.split(".ai").join(".xml"));
	if (file.exists) {
		var xmlFile = File(file);
		xmlFile.open("r");
		var str = xmlFile.read()
		xmlFile.close();
		var story = str.split('\n')
		var textRefs = doc.textFrames;
		var j = 0
		
		for (var i=2; i<story.length-1; i++) {
			var cont = story[i];
			var originaltxt = textRefs[j].contents;
			var changetxt = textRefs[j].contents.replace(originaltxt, cont);
			changetxt = changetxt.toString().replace(/\t/g, "");
			changetxt = changetxt.toString().replace(/\<story [^>]+\>/g, "");
			changetxt = changetxt.toString().replace(/\<\/story\>/g, "");
			changetxt = changetxt.toString().replace(/\&apos\;/g, "'");
			changetxt = changetxt.toString().replace(/\&lt\;/g, "<");
			changetxt = changetxt.toString().replace(/\&gt\;/g, ">");
			changetxt = changetxt.toString().replace(/\&amp\;/g, "&");
			changetxt = changetxt.toString().replace(/\&quot\;/g, '"');
			textRefs[j].contents = changetxt;
			j++;
		}
		var cStyles =  doc.characterStyles;
		var count = 0;
		for (var i=1; i<cStyles.length; i++) {
			if (cStyles[i].name == "C_MMI") {
				count++;
			}
		}
		if (count > 0) {
			for (var k=0; k<textRefs.length; k++) {
				var tFrame = textRefs[k];
				var searchString = /\<CharTag char-style=\"C_MMI\"\>([^>]+)\<\/CharTag\>/g;
				var replaceString = "$1";
				var myStyle = doc.characterStyles.getByName("C_MMI");
				var tWords = tFrame.words;
				var result, aCont;
				while (result = searchString.exec(tFrame.contents)) {
					try {
						aCon = tFrame.characters[result.index];
						aCon.length = result[0].length;
						var newString = aCon.contents.replace(searchString, replaceString);
						aCon.contents = newString;
						myStyle.applyTo(aCon, true);
					} catch (e) {}
				}
			}
		}
		// 스타일 재정의
		var appliedName, applyStyle;
		for (var i=0; i<textRefs.length; i++) {
			appliedName = textRefs[i].textRange.paragraphStyles[0].name;
			applyStyle = doc.paragraphStyles.getByName(appliedName);
			applyStyle.applyTo(textRefs[i].textRange, true);
		}
	}
}

function GetAppVersion() {
	var appVersion,
	appVersionNum = Number(String(app.version).split(".")[0]);

	if (appVersionNum > 23) {
		// if 27 then "2023"
		return String(appVersionNum + 1996)
	} else if (appVersionNum > 21) {
		// if 23 then "CC 2019"
		return "CC "+ String(appVersionNum + 1996)
	} else {
		return null;
	}
}