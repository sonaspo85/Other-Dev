function mmiStyleChecker() {
	var doc = app.activeDocument;
	var MMI = doc.conditions.item("MMI");
	try {
		if (MMI.isValid == true) {
			if (MMI.visible == true) {
				MMI.visible = true;
			} else if (MMI.visible == false) {
				MMI.visible = true;
			}
			gogo();
		} if (MMI.isValid == false) {
			alert("MMI 조건부 텍스트 설정이 적용되어 있지 않습니다. 문서를 확인한 후 다시 실행해주세요.");
			exit();
		}
	} catch(e) {
		alert("문서에 문제가 있습니다. 개발자에게 문의하세요.");
	}
	
	
	// var MMI = doc.conditions.item("MMI");
	// if (!MMI.visible.isValid) {
	// 	alert("MMI Conditional 설정을 해제한 다음 진행합니다. MMI 검사를 모두 진행한 다음에는 MMI Set Conditions를 클릭하세요.")
	// 	MMI.remove();
	// } else 
	function gogo() {
		//reset search
		app.findGrepPreferences = NothingEnum.nothing;
		app.changeGrepPreferences = NothingEnum.nothing;

		//set find options
		app.findChangeGrepOptions.includeFootnotes = false;
		app.findChangeGrepOptions.includeHiddenLayers = false;
		app.findChangeGrepOptions.includeLockedLayersForFind = false;
		app.findChangeGrepOptions.includeLockedStoriesForFind = false;
		app.findChangeGrepOptions.includeMasterPages = false;

		app.findGrepPreferences.findWhat = "(\\{MMI-\\d\\d\\d\\d\\})";
		app.findGrepPreferences.appliedCharacterStyle = doc.characterStyles.item("$ID/[None]");

		var myFind = doc.findGrep();
		var counter = 0
		for (var i=0; i<myFind.length; i++) {
			//myFind[i];
			counter ++;
			if (counter > 0) {
				app.activeWindow.activePage = myFind[0].parentTextFrames[0].parentPage;
				myFind[0].select();
				alert("선택된 부분에서 MMI ID의 문자스타일이 적용되어 있지 않습니다. 문자 스타일을 적용해주세요.");
				//reset search
				app.findGrepPreferences = NothingEnum.nothing;
				app.changeGrepPreferences = NothingEnum.nothing;
				exit();
			} else if (counter < 1) {
				continue;
			}
		}
	} alert ("문서에 이상이 없습니다.");
	//reset search
	app.findGrepPreferences = NothingEnum.nothing;
	app.changeGrepPreferences = NothingEnum.nothing;
}