function mmiChecker() {
	var doc = app.activeDocument;
	var cSmmi = doc.characterStyles.item("C_MMI");
	var cSmmiNobold = doc.characterStyles.item("C_MMI_NoBold");
	var cSmmiKo = doc.characterStyles.item("C_MMI_KO");
	var cSmmiWA = doc.characterStyles.item("C_Web_App");
	var cSmmiWAnb = doc.characterStyles.item("C_Web_App_NoBold");
	var cSmmiLtR1 = doc.characterStyles.item("C_MMI_LtoR");
	var cSmmiLtR2 = doc.characterStyles.item("C_LtoR");
	var mmiCS = [ cSmmi, cSmmiNobold, cSmmiKo, cSmmiWA, cSmmiWAnb, cSmmiLtR1, cSmmiLtR2 ]
	
	var MMI = doc.conditions.item("MMI");
	try {
		if (MMI.isValid == true) {
			if (MMI.visible == true) {
				MMI.visible = true;
			} else if (MMI.visible == false) {
				MMI.visible = true;
			}
			returngogo()
		} if (MMI.isValid == false) {
			alert("MMI 조건부 텍스트 설정이 적용되어 있지 않습니다. 문서를 확인한 후 다시 실행해주세요.");
			exit();
		}
	} catch(e) {
		alert("문서에 문자 스타일이 모두 들어있지 않을 수 있습니다. 스타일 동기화를 실행하세요.");
	}
	function returngogo() {
		for (var i=0; i < mmiCS.length; i++) {
			if (mmiCS[i].isValid) {
				gogo(mmiCS[i]);
			} else
				continue;
		}
		alert ("MMI ID가 모두 적용되었습니다.");
	}
	
	// var MMI = doc.conditions.item("MMI");
	// if (!MMI.visible.isValid) {
	// 	alert("MMI Conditional 설정을 해제한 다음 진행합니다. MMI 검사를 모두 진행한 다음에는 MMI Set Conditions를 클릭하세요.")
	// 	MMI.remove();
	// } else 
	function gogo(mmiCS) {
		//reset search
		app.findGrepPreferences = NothingEnum.nothing;
		app.changeGrepPreferences = NothingEnum.nothing;

		//set find options
		app.findChangeGrepOptions.includeFootnotes = false;
		app.findChangeGrepOptions.includeHiddenLayers = false;
		app.findChangeGrepOptions.includeLockedLayersForFind = false;
		app.findChangeGrepOptions.includeLockedStoriesForFind = false;
		app.findChangeGrepOptions.includeMasterPages = false;

		app.findGrepPreferences.findWhat = "(\\$)(?!\\{)(?!M)(?!M)(?!I)(?!-)(?!\\d)(?!\\d)(?!\\d)(?!\\d)(?!\\})([^>]+)(\\$)";
		app.findGrepPreferences.appliedCharacterStyle = mmiCS;

		var myFind = doc.findGrep();
		var counter = 0
		for (var i=0; i<myFind.length; i++) {
			//myFind[i];
			counter ++;
			if (counter > 0) {
				app.activeWindow.activePage = myFind[0].parentTextFrames[0].parentPage;
				myFind[0].select();
				exit();
			} else if (counter < 1) {
				continue;
			}
		}
	} 
}