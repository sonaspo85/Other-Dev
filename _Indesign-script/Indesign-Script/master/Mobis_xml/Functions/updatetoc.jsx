function updateAllTocIndex() {
	// 활성화된 북파일을 myBook 변수로 생성
	var myBook = app.activeBook;

	// myBook.bookContents.everyItem(): book 파일내 포함된 모든 indd 컬렉션 목록들을 반환
	var myBookContents = myBook.bookContents.everyItem().getElements();
	// 경고창 비활성화
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;
	
	// book 파일에 포함된 indd들을 하나씩 반복
	for (var b=0; b<myBookContents.length; b++) {
		var myPath = myBookContents[b].fullName;
		// 파일이름 추출
		var myDoc = File(myPath);
		// 파일 열기
		app.open(myDoc);
	}

	// 위 작업은 book 파일내 포함된 모든 indd을 여는 작업
	//-----------------------------------------------
	var docs = app.documents;
	var paraName;

	for (var n=0; n<docs.length; n++) {
		// var doc = docs[n];
		// app.documents.everyItem(): 어플리케이션의 모든 컬렉션의 문서 목록들을 Element로 반환
		var openDocs = app.documents.everyItem().getElements();
		app.activeDocument = openDocs[openDocs.length-1];
		var activeDoc = app.activeDocument;

		// Cover, QRG, Trademarks, Opensource 인 경우 반복 넘김
		if (activeDoc.name.indexOf("Cover") != -1 || activeDoc.name.indexOf("QRG") != -1 || activeDoc.name.indexOf("Readmefirst") != -1 || activeDoc.name.indexOf("Trademarks") != -1 || activeDoc.name.indexOf("Opensource") != -1) {
			// $.writeln(activeDoc.name + " pass");
			continue;

		} else if (activeDoc.name.indexOf("TOC") != -1) { // 목차 파일인 경우
			updateToc();
			paraName = "TOC2";
			removeTOCcs(paraName);
			paraName = "TOC3";
			removeTOCcs(paraName);
			removeTOC_charStyle();
			
		} else if (activeDoc.name.indexOf("Index") != -1) { // 인덱스 파일인 경우
			updateToc();
			generateIndex(activeDoc);

		} else { // 그 외 도비라 파일인 경우
			updateToc();
			paraName = "TOC-Chapter";
			removeTOCcs(paraName);
		}
		
	}

	// 경고창 활성화
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.interactWithAll;
	alert("완료합니다.");
}

function updateToc() {
	var myDoc = app.activeDocument;
	var s = myDoc.stories;
	for (var i=0; i<s.length; i++) {
		try {
			if (s[i].storyType == StoryTypes.TOC_STORY) {
				s[i].textContainers[0].select();
				// scriptMenuActions.itemByID(): 지정된 ID로 ScriptMenuAction을 반환
				app.scriptMenuActions.itemByID(71442).invoke();  //Update TOC
				// $.writeln(myDoc.name + " update TOC");
			} else continue;

		} catch(err) {
			alert(myDoc.name + " : " + err.line + " : " + err);
			exit();
		}
	}
}

function removeTOC_charStyle() {
	var doc = app.activeDocument;
	
	// 배열 변수 생성
	var removes = ['C_Below_Heading', 'C_Below_Chapter'];
	

	var greps = [
		// {"findWhat":"(.*)(\\t\\d{1,})", "changeTo":"$2"}
		{"findWhat":"(\\([^>]+\\))(\\t\\d{1,})", "changeTo":"$2"},
		{"findWhat":"(\\([^>]+\\))(\\t)?($)", "changeTo":"###$2"},
		// {"findWhat":"([※]+)(.*)(\\t\\d{1,})", "changeTo":"###$3"}
		{"findWhat":"([^>]+)(\\t\\d{1,})", "changeTo":"$2"}
	]


	for (var j=0; j<removes.length; j++) {
		app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;
		var getList = doc.characterStyles.itemByName(removes[j]);
		if(getList != null) {
			
			if(getList.name == removes[j]) {
				// findGrepPreferences.appliedCharacterStyle: 검색하거나 변경할 문자 스타일을 지정. 
				app.findGrepPreferences.appliedCharacterStyle = doc.characterStyles.itemByName(removes[j]);
				
				for(var e=0; e < greps.length; e++) {
					// $.writeln("aaa1: " + doc.characterStyles.itemByName(removes[j]))
					// grep 기본설정을 변경할때 사용 한다.
					// findGrepPreferences.findWhat: 찾을 FindGrepPreference 을 지정
					app.findGrepPreferences.findWhat = greps[e].findWhat;
					app.changeGrepPreferences.changeTo = greps[e].changeTo;
					app.changeGrepPreferences.appliedCharacterStyle = app.characterStyles.item("$ID/[None]");
					doc.changeGrep();
				}

				app.findTextPreferences = app.changeTextPreferences = NothingEnum.NOTHING;
				try {
					app.findTextPreferences.findWhat = "###";
					app.changeTextPreferences.changeTo = "";
					// app.changeTextPreferences.appliedCharacterStyle = None;
					doc.changeText();
				} catch(err) {
					alert(doc.name + " : " + err.line + " : " + err);
					exit();
				}
				app.findTextPreferences = app.changeTextPreferences = NothingEnum.NOTHING;
			}
			
			app.changeGrepPreferences.appliedCharacterStyle = null;

		}
		app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;	
	}
}

// function removeTOC_ccNC() {
// 	var doc = app.activeDocument;
// 	var removes = [ 'C_Below_Heading', 'C_Below_Chapter' ];
// 	for (var j=0;j<removes.length;j++) {
// 		app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;
// 		app.findGrepPreferences.findWhat = "\\(" + "if equipped" + "\\)";
// 		app.findGrepPreferences.appliedCharacterStyle = doc.characterStyles.itemByName(removes[j])
// 		var myFound = doc.findGrep();
// 		for (var k=0;k<myFound.length;k++) {
// 			myFound[k].contents = "";
// 		}
// 		app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;
// 	}
// 	doc.save();
// }

function removeTOCcs(paraName) {
	var myDoc = app.activeDocument;

	// removeTOC_ccNC();

	var ps = myDoc.allParagraphStyles;

	for (var i=0; i<ps.length; i++) {
		if (ps[i].name == paraName) {
			var tocPS = ps[i];
		}
	}

	// var removeCS = myDoc.characterStyles.itemByName('C_Below_Heading');
	var None = myDoc.characterStyles[0];

	app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;

	try {
		if (paraName == "TOC2" || paraName == "TOC3") {
			app.findGrepPreferences.findWhat = "(.+?)(\\t\\d{1,}\\-\\d{1,})";

		} else {
			app.findGrepPreferences.findWhat = "(.+)";
		}

		app.findGrepPreferences.appliedParagraphStyle = tocPS;
		// app.findGrepPreferences.appliedCharacterStyle = removeCS;
		
		if (paraName == "TOC2" || paraName == "TOC3") {
			app.changeGrepPreferences.changeTo = "$2";

		} else {
			app.changeGrepPreferences.changeTo = "";
		}

		if (paraName == "TOC2" || paraName == "TOC3") {
			app.changeGrepPreferences.appliedCharacterStyle = null;
		} 

		myDoc.changeGrep();
	} catch(err) {
		alert(myDoc.name + " : " + err.line + " : " + err);
		exit();
	}
	app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;
}



function generateIndex(doc) {
	// doc.indexes[0]: 인덱스 모음
	var myIndex = doc.indexes[0];
	// doc.indexGenerationOptions: 인덱스 형식 지정 방법을 정의하는 인덱스 옵션 속성이다.
	// includeBookDocuments: true인 경우 책에 있는 모든 문서의 주제 및 페이지 참조를 포함
	doc.indexGenerationOptions.includeBookDocuments = true;
	doc.indexGenerationOptions.title = "";
	// Index.generate(): 새로운 인덱스 스토리를 생성
	myIndex.generate();

	app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;
	app.findGrepPreferences.findWhat = "로마자\r";
	app.changeGrepPreferences.changeTo = "";
	doc.changeGrep();
	app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;

	// $.writeln(doc.name + " index update")
}
