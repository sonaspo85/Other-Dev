// Version 0.0.1
//
// 설치
// 1. 이 파일을 아래 폴더에 복사하고, 아크로뱃 시작
//    C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\JavaScripts
// 2. 편집 > 기본 설정 메뉴를 클릭하고, JavaScript를 클릭하고, 다음 항목들을 선택.
//    * Acrobat JavaScript 사용 가능
//    * 메뉴 항목 JavaScript 실행 권한 활성화
// 사용
// 파일 > MC MOBIS > Remove memo pages 메뉴를 클릭
//
app.addSubMenu({ cName: "MC Mobis", cParent: "File", nPos:0	}
)
app.addMenuItem({ 
 		cName: "Remove memo pages", 
 		cParent: "MC Mobis", 
		cExec: "RemoveMemoPages();",
		cEnable: "event.rc = (event.target != null);",
	}
)
app.addMenuItem({ 
 		cName: "Show Acrobat JavaScript folder", 
 		cParent: "MC Mobis", 
		cExec: "ShowPathJS();"
	}
)

function ShowPathJS()
{
	var JSfolder = app.getPath("app", "javascript");
	JSfolder = JSfolder.split('/').join('\\');
	JSfolder = JSfolder.replace('\\C\\', 'C:\\');
	app.alert(JSfolder)
}

function RemoveMemoPages()
{
	var memoPages = [];
	var startPage = -1;
	var endPage = this.numPages-1;

	// 마지막부터 8 페이지를 검사하여 빈 페이지의 번호를 memoPages 배열에 추가
	for (i=0; i<8; i++) {
		pageNo = endPage - i;
		if (this.getPageNumWords(pageNo) == 0) {
			startPage = pageNo;
			memoPages.push(pageNo+1);
		} 
	}

	if (memoPages.length == 0) {
		app.alert("No memo pages are found.");
		return;
	}

	// 마지막 페이지가 빈 페이지가 아니라면 표지 3과 4가 있다고 간주하여 제외
	if (memoPages[0] != this.numPages) {
		// remove cover #3
		memoPages.splice(0, 1)
		endPage = endPage - 2;
	}

	if (startPage > -1) {
		this.deletePages({nStart:startPage, nEnd:endPage});
		app.execMenuItem("Save");
		var msg = "Page " + memoPages.reverse().toString() + " are deleted, and the file is saved.";
		msg = msg.replace('/,/g', ', ');
		app.alert(msg);
	}
}

