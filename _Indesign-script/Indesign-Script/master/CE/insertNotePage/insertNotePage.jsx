#targetengine "session";

var w = new Window ("palette","note 페이지 추가");
var ISOcode = [];
var lgs = [];
var fullLang;
// 선택한 언어들을 담을 배열
// var selectedLgs = [];
var postList;

var postListGroup = w.add("group");
    postList = postListGroup.add ("listbox", undefined, ["select languages..."], {multiselect: true});
	// postList = postListGroup.add ("listbox", undefined, ["select languages..."]);
    postList.minimumSize = [190,190]
    postListGroup.alignment = "center";

	btn_00 = w.add ("button", [0,0,190,30], "1. 언어코드 추출");
	
	group = w.add ('group {orientation: "column"}');
	panel_00 = group.add ('panel {text: "단일문서"}');
	btn_001 = panel_00.add ("button", [0,0,190,30], "2. 단일문서(짝수 페이지 만들기)");
	btn_01 = panel_00.add ("button", [0,0,190,30], "3. 단일문서(4의 배수)");
	
	group01 = w.add ('group {orientation: "column"}');
	panel_01 = group01.add ('panel {text: "북 파일"}');
	btn_02 = panel_01.add ("button", [0,0,190,30], "4. 북파일 모든 문서 열기");
	// btn_03 = panel_01.add ("button", [0,0,190,30], "4. 북파일(짝수 페이지 만들기)");
	btn_04 = panel_01.add ("button", [0,0,190,30], "5. 북파일 마지막 언어(4의 배수)");
	

btn_00.onClick = function() {
	var langCode;

	if(app.documents.length > 0 && app.books.length > 0) {
		alert("단일문서 또는 북파일 둘중 하나를 열어 실행 해주세요.");
		exit();	
	}  else if (app.books.length == 0) {
		var curDoc = app.activeDocument;
		var myPath = curDoc.fullName;
		var path = myPath.toString();
		// 4way_AA_EN_.indd 에서 EN_.indd 만 추출 히기 위해 뒤에서 2번째 인 '_' 위치 찾기
		var lastIndex = path.lastIndexOf("_")-2;
		// 문서 이름으로 언어코드 추출
		// langCode = path.slice(lastIndex).replace('(-WEB)?_.indd', '');
		langCode = path.replace(/(.*)(_.*?_)(.*_.indd)/g, "$3").replace(/(.*?)(-.*)?(_.indd)/g, "$1");
		// $.writeln("langCode11: " + langCode);
		// 문서의 언어코드 배열에 저장
		ISOcode.push(langCode);

	// 언어코드 추출
	getMemo0();	

    } else if (app.books.length > 0) {  // 북파일의 모든 문서 열기
        var myBook = app.activeBook;
        var myBookContents = myBook.bookContents.everyItem().getElements();
		
        for(var i=0; i<myBookContents.length; i++) {
            var myPath = myBookContents[i].fullName;
			// $.writeln("myPath: " + myPath);

			var path = myPath.toString();
			// 4way_AA_EN_.indd 에서 EN_.indd 만 추출 히기 위해 뒤에서 2번째 인 '_' 위치 찾기
			// var lastIndex = path.lastIndexOf("_")-2;
			// 문서 이름으로 언어코드 추출
			var langCode = path.replace(/(.*)(_.*?_)(.*_.indd)/g, "$3").replace(/(.*?)(-.*)?(_.indd)/g, "$1");
			// 문서의 언어코드 배열에 저장
			ISOcode.push(langCode);

        }

		// 언어코드 추출
		getMemo0();	
    }
}

btn_01.onClick = function() {
	if(ISOcode.length > 0) {
		var docs = app.documents;
		var curDoc;
		var docName;
		if(app.books.length == 0) {  // 북파일 없이 단일 문서일 경우
			curDoc = app.activeDocument;
			docName = curDoc.name;
			// 각 문서 짝수 페이지로 만들기
			ondDocFourMultiple(curDoc);
		} 
		alert("단일 문서 note 페이지 생성 완료");
	} else {
		alert("언어를 선택 해주세요.");
	}
}

btn_001.onClick = function() {
	if(ISOcode.length > 0) {
		// var docs = app.documents;
		var curDoc = app.activeDocument;
		var docName = curDoc.name;
		evenPage(curDoc);
		
		alert("단일 문서 짝수 페이지 생성 완료");
	} else {
		alert("언어를 선택 해주세요.");
		exit();
	}
}

// 북파일 문서 열기
btn_02.onClick = function() { 
    if (app.books.length == 0) {
        alert("북 파일을 열어주세요");

    } else if (app.books.length > 0) {
        var myBook = app.activeBook;
        var myBookContents = myBook.bookContents.everyItem().getElements();
        // 경고창 비활성화
        app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;
        for (var b=0; b<myBookContents.length; b++) {
            var myPath = myBookContents[b].fullName;
            var myDoc = File(myPath);
            app.open(myDoc);
        }
        // 경고창 활성화
        app.scriptPreferences.userInteractionLevel = UserInteractionLevels.interactWithAll;
        alert("모든 문서를 열었습니다.");
    }
}

// 북파일 각 문서 짝수 페이지 만들기
// btn_03.onClick = function() {
//     var docs = app.documents;
//     var curDoc;
// 	var docName;

// 	for (n=0; n<docs.length; n++) {
// 		curDoc = docs[n];
// 		docName = docs[n].name;
// 		// 각 문서 짝수 페이지로 만들기
// 		evenPage(curDoc);
// 	}

//     alert("북 파일의 각 문서 짝수 페이지 생성 완료");
// }

// 언어코드 listbox의 목록으로 저장하기
function getMemo0() {
	// $.writeln("a1");
    var cScript = new File($.fileName);
    var path = cScript.parent.fsName;
    var myXMLFile = File(path + '\\lang.xml')

	myXMLFile.open('r');
    var allElements = new XML(myXMLFile.read());
    myXMLFile.close();
    var nodes = allElements[0].xpath("//Row");


	for(var i=0; i<nodes.length(); i++){
        var row = nodes[i];

		for(var k=0; k<ISOcode.length; k++){
			var isoL = ISOcode[k];

			if(row.@ISO == isoL) {
				// $.writeln(row.@lang);
				lgs.push(row.@lang);
				// listbox 컨트롤 목록으로 추가, 
				// 여기서의 언어코드는 xml 에서 해당하는 모든 언어코드를 추출하여 listbox의 목록으로 추가 시킴
				postList.add("item", row.@lang);
			}
		}

    }
 return null;
}

// 각 문서를 짝수페이지로 만들기
function evenPage(curDoc) {
	// $.writeln("evenPage 시작");
    var myPages = curDoc.pages;
    var docName = curDoc.name;
    var lastPageNum = myPages.lastItem().name;

    for (a=0; a<myPages.length; a++) {
        var pageName = myPages[a].name;
        // $.writeln("페이지 번호: " + pageName);

        if(lastPageNum % 2 != 0) {
            if (lastPageNum == myPages[a].name) {
                myPages.add(LocationOptions.AFTER, myPages[a-1], {appliedMaster:null});
                // $.writeln(docName + " 에 문서 추가함");
				myPages[a].appliedMaster = curDoc.masterSpreads.item('Memo-Memo');
				var memoStyleList = curDoc.masterSpreads.item('Memo-Memo');
				// $.writeln(docName + " 에 문서 추가함");
				
				// Memo 텍스트를 찾기/바꾸기
				changeText(curDoc);
            }
        }

    }
    
}

function ondDocFourMultiple(curDoc) {
	// $.writeln("ondDocFourMultiple 시작");
	var myPages = curDoc.pages;

	for (var i=0; i<myPages.length; i++) {
		var pageName = myPages[i].name;
		var lastPageNum = curDoc.pages.lastItem().name;
		
		if (lastPageNum % 4 != 0) {
			if(lastPageNum == myPages[i].name) {
				// book 문서일 경우 각 문서를 짝수로 맞춤
				// myPages.add(LocationOptions.AFTER, myPages[i-1], {appliedMaster:null});
			
				if(lastPageNum % 4 != 0) {
					var upVal = lastPageNum / 4;  // 4로 나누었을때 윗몫
					// var decimalTint = Math.floor(upVal);
					var decimalTint = parseInt(upVal);
					// $.writeln("페이지 번호: " + decimalTint);
					var multipleVal = (decimalTint + 1) * 4;
					// 추가할 페이지
					var extraPage = multipleVal - lastPageNum;
					
					// backcover 페이지 앞에 빈페이지 넣기
					for(var j=0; j<extraPage; j++) {
						myPages.add(LocationOptions.AFTER, myPages[i-1], {appliedMaster:null});
						myPages[i].appliedMaster = curDoc.masterSpreads.item('Memo-Memo');
						// var ddd = curDoc.masterSpreads.item('Memo-Memo');
						// d1(ddd, j);	
					}
					
					changeText(curDoc);
				}
			}

		}
	}
}

btn_04.onClick = function() {
	if(ISOcode.length == 0) {
		alert("언어를 선택해 주세요.");
	} else {
		var docs = app.documents;
		// 모든 페이지 개수 파악 하기
		var allDocPage = 0;
	
		for (n=0; n<docs.length; n++) {
			var curDoc = docs[n];
			var myPages = curDoc.pages;
			var lastPageNum = myPages.lastItem().name;

			// allDocPage += Math.floor(lastPageNum);
			allDocPage += parseInt(lastPageNum);
			// $.writeln("모든 문서 페이지 합계: " + allDocPage);
		}

		// 마지막 문서 이름 추출하기
		var myBook = app.activeBook;
		var lastDoc = myBook.bookContents[-1];
		// var lastDoc1 = myBook.bookContents[-1];
		// $.writeln("lastDoc: " + lastDoc.name);
		
		for (k=0; k<docs.length; k++) {
			var curDoc = docs[k];

			if(curDoc.name == lastDoc.name) {
				// $.writeln("마지막 문서일 경우");
				var myPages = curDoc.pages;
				var lastPageNum = myPages.lastItem().name;
				// $.writeln("마지막 문서 lastPageNum: " + lastPageNum);

				if (allDocPage % 4 != 0) {
					// $.writeln("총 페이지 4의 배수가 아님");
					if(lastPageNum) {
						// $.writeln("마지막 페이지에 위치: " +lastPageNum);
						// book 문서일 경우 각 문서를 짝수로 맞춤

						// var upVal = lastPageNum / 4;  // 4로 나누었을때 윗몫
						var upVal = allDocPage / 4;  // 4로 나누었을때 윗몫

						// var decimalTint = Math.floor(upVal);
						var decimalTint = parseInt(upVal);
						// $.writeln("decimalTint: " + decimalTint);
						var multipleVal = (decimalTint + 1) * 4;
						// $.writeln("multipleVal: " + multipleVal);
						
						// 추가할 페이지
						var extraPage = parseInt(multipleVal - allDocPage);
						// $.writeln("추가할 페이지: " +extraPage);
						// backcover 페이지 앞에 빈페이지 넣기
						for(var j=0; j<extraPage; j++) {
							myPages.add(LocationOptions.BEFORE, myPages[lastPageNum-1], {appliedMaster:null});
							myPages[lastPageNum-1].appliedMaster = curDoc.masterSpreads.item('Memo-Memo');
						}
						
						changeText(curDoc);
					}
				}
			}
		}

		alert("북파일 마지막 언어 note 페이지 추가 완료");	
	}
}



function changeText(curDoc) {
	if(app.books.length == 0) {
		// $.writeln("단일문서 changeText 시작");
		singleDocChangeText(curDoc);

	} else {
		// $.writeln("북파일 changeText 시작");
		for(var i=0; i<postList.selection.length; i++) {
			var curLg = postList.selection[i].text;
			// selectedLgs.push(cur);
			// $.writeln("선택한 언어: " + cur);

			multiDocChangeText(curDoc, curLg);
		}
	}
}

function multiDocChangeText(curDoc, curLg) {
	// var cur = postList.selection.text;
	// $.writeln("multiDocChangeText 시작");
	// $.writeln("선택한 언어: " + curLg);
	var fullLang = curLg;

	// findGrep 로 찾기/바꾸기
	app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;

	//Set the find options.
	app.findChangeGrepOptions.includeFootnotes = true;
	app.findChangeGrepOptions.includeHiddenLayers = true;
	app.findChangeGrepOptions.includeLockedLayersForFind = true;
	app.findChangeGrepOptions.includeLockedStoriesForFind = true;
	app.findChangeGrepOptions.includeMasterPages = true;

	var noteStyle = [ "Heading1-NoTOC", "Heading1_NoTOC" ];
	
	for (var x=0; x<noteStyle.length; x++) {
		app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;

		var curStyle = curDoc.paragraphStyles.itemByName(noteStyle[x]);
		
		changeEachText(curDoc, fullLang, curStyle);
	}
}

function singleDocChangeText(curDoc) {
	var cur = postList.selection[0].text;
	// $.writeln("선택한 언어: " + cur);
	var fullLang = cur;

	// findGrep 로 찾기/바꾸기
	// app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;

	//Set the find options.
	app.findChangeGrepOptions.includeFootnotes = true;
	app.findChangeGrepOptions.includeHiddenLayers = true;
	app.findChangeGrepOptions.includeLockedLayersForFind = true;
	app.findChangeGrepOptions.includeLockedStoriesForFind = true;
	app.findChangeGrepOptions.includeMasterPages = true;

	// var noteStyle = curDoc.paragraphStyles.itemByName('Heading1-NoTOC');
	var noteStyle = [ "Heading1-NoTOC", "Heading1_NoTOC" ];
	
	for (var x=0; x<noteStyle.length; x++) {
		app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;

		var curStyle = curDoc.paragraphStyles.itemByName(noteStyle[x]);
		
		changeEachText(curDoc, fullLang, curStyle);
	}
}

function changeEachText(curDoc, fullLang, curStyle) {
	if(curStyle != null) {
		var docName = curDoc.name;
		// var lastIndex = docName.lastIndexOf("_")-2;
		// 2자리 ISO 코드 추출
		// var langCode = docName.slice(lastIndex).replace('(-WEB)?_.indd', '');
		var langCode = docName.replace(/(.*)(_.*?_)(.*_.indd)/g, "$3").replace(/(.*?)(-.*)?(_.indd)/g, "$1");
		// $.writeln("langCode: " + langCode);
		var concatStr = '(' + langCode + ')' + fullLang;
		// $.writeln("concatStr: " + concatStr);
		// var concatStr = "aabb";

		var cScript = new File($.fileName);
		var path = cScript.parent.fsName;
		
		var myXMLFile = File(path + '\\lang.xml')

		myXMLFile.open('r');
		var allElements = new XML(myXMLFile.read());
		myXMLFile.close();
		
		// lang.xml 파일 읽기
		var nodes = allElements[0].xpath('//Row[@fullLang="' + concatStr + '"]');
		// 해당 언어에 맞는 note 번역값 추출
		var noteStr = nodes.@value;
		
		// $.writeln("noteStr: " + noteStr);
		
		// 문서 이름으로 언어코드 추출
		// var langCode = path.slice(lastIndex).replace('(-WEB)?_.indd', '');
		// 문서의 언어코드 배열에 저장
		// ISOcode.push(langCode);

		app.findGrepPreferences.findWhat = "^Memo$";  
		app.findGrepPreferences.appliedParagraphStyle = curStyle;
		app.changeGrepPreferences.changeTo = noteStr.toString();  
		app.changeGrepPreferences.appliedParagraphStyle = curStyle;
		
		curDoc.changeGrep();
	}
}

w.show();