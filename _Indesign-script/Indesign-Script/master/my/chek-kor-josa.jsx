function CheckKOR(state) {
	var doc = app.activeDocument;
	try {
		if (MMI.isValid == true) {
			if (MMI.visible == true) {
				MMI.visible == false;
			} else if (MMI.visible == false) {
				// continue;
			}
		} if (MMI.isValid == false) {
			// continue;
		}
	} catch(e) {
		// alert("문서에 문제가 있습니다. 개발자에게 문의하세요.");
	}

	var noneChar = String.fromCharCode(0xFEFF)
	app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;
	app.findGrepPreferences.findWhat = "(\\w+)(이|가|을|를)(\\s)";
	var myFound = doc.findGrep();
	var excludecon1 = "디스플레이";
	var excludecon2 = "m를";
	var excludecon3 = "불가";
	var excludecon4 = "가까이";
	var excludecon5 = "평가";

	for (var i=state; i<myFound.length; i++) {
		app.activeWindow.activePage = myFound[i].parentTextFrames[0].parentPage;
		var selection = myFound[i].select();
		if (app.selection[0].contents.indexOf(excludecon1) != -1) {
			continue;
		} 
		if (app.selection[0].contents.indexOf(excludecon2) != -1) {
			continue;
		}
		if (app.selection[0].contents.indexOf(excludecon3) != -1) {
			continue;
		}
		if (app.selection[0].contents.indexOf(excludecon4) != -1) {
			continue;
		}
		if (app.selection[0].contents.indexOf(excludecon5) != -1) {
			continue;
		}
		if (app.selection[0].contents.indexOf(noneChar) != -1) {
			CheckKORWOW2();
		}
		else {
			CheckKORWOW1();
		}
	}
	app.findGrepPreferences = app.changeGrepPreferences = NothingEnum.NOTHING;
	//예외 단어
	alert("모든 검사 완료!!");

	function CheckKORWOW1() {
		var selWord = app.selection[0];
		var lastLetter = selWord.characters[-3];
		var uni = lastLetter.contents.charCodeAt(0);

		// alert(selWord.contents + " | " + lastLetter.contents + " | " + uni);
		if (uni < 44032 || uni > 55203) {
			//uni1이 한글이 아닌 경우 uni2로 넘긴다.
			// alert("uni1이 한글이 아니다");
			// exit();
			return false;
		} else {
			//uni1이 한글인 경우
			if ((uni - 44032) % 28 !=0) {
				// alert ("한글이다. 받침이 있다.");
				if (selWord.characters[-2].contents == "가") {
					// selWord.characters[-2].contents = "이";
					alert("'가' → '이' 수정하세요");
					exit();
				} 
				if (selWord.characters[-2].contents == "를") {
					// selWord.characters[-2].contents = "을";
					alert("'를' → '을' 수정하세요");
					exit();
				}
				if (selWord.characters[-2].contents == "는") {
					// selWord.characters[-2].contents = "을";
					alert("'는' → '은' 수정하세요");
					exit();
				}
			}
			if ((uni - 44032) % 28 == 0) {
				// alert ("받침이 없다");
				if (selWord.characters[-2].contents == "이") {
					// selWord.characters[-2].contents = "가";
					alert("'이' → '가' 수정하세요");
					exit();
				}
				if (selWord.characters[-2].contents == "을") {
					// selWord.characters[-2].contents = "를";
					alert("'을' → '를' 수정하세요");
					exit();
				}
				if (selWord.characters[-2].contents == "은") {
					// selWord.characters[-2].contents = "를";
					alert("'은' → '는' 수정하세요");
					exit();
				}
			}
		}
	} // function End

	function CheckKORWOW2() {
		var selWord = app.selection[0];
		var lastLetter = selWord.characters[-4];
		var uni = lastLetter.contents.charCodeAt(0);

		// alert(selWord.contents + " | " + lastLetter.contents + " | " + uni);
		if (uni < 44032 || uni > 55203) {
			//uni1이 한글이 아닌 경우 uni2로 넘긴다.
			// alert("uni1이 한글이 아니다");
			// exit();
			return false;
		} else {
			//uni1이 한글인 경우
			if ((uni - 44032) % 28 !=0) {
				// alert ("한글이다. 받침이 있다.");
				if (selWord.characters[-2].contents == "가") {
					// selWord.characters[-2].contents = "이";
					alert("'가' → '이' 수정하세요");
					exit();
				} 
				if (selWord.characters[-2].contents == "를") {
					// selWord.characters[-2].contents = "을";
					alert("'를' → '을' 수정하세요");
					exit();
				}
			}
			if ((uni - 44032) % 28 == 0) {
				// alert ("받침이 없다");
				if (selWord.characters[-2].contents == "이") {
					// selWord.characters[-2].contents = "가";
					alert("'이' → '가' 수정하세요");
					exit();
				}
				if (selWord.characters[-2].contents == "을") {
					// selWord.characters[-2].contents = "를";
					alert("'을' → '를' 수정하세요");
					exit();
				}
			}
		}
	} // function End
}