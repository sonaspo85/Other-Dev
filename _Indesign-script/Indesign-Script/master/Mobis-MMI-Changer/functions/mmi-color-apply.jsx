function applyColorMMIall() {
	var doc = app.activeDocument;
	var cSmmi = doc.characterStyles.item("C_MMI");
	var cSmmiNobold = doc.characterStyles.item("C_MMI_NoBold");
	var cSmmiKo = doc.characterStyles.item("C_MMI_KO");
	var cSmmiWA = doc.characterStyles.item("C_Web_App");
	var cSmmiWAnb = doc.characterStyles.item("C_Web_App_NoBold");
	var cSmmiLtR1 = doc.characterStyles.item("C_MMI_LtoR");
	var cSmmiLtR2 = doc.characterStyles.item("C_LtoR");
	var mmiCS = [ cSmmi, cSmmiNobold, cSmmiKo, cSmmiWA, cSmmiWAnb, cSmmiLtR1, cSmmiLtR2 ]

	change_None_book(); //checkMMI 색상 여부 확인하기
	
	function change_None_book() {
		var doc = app.activeDocument;
		//색상 만들기
		var myColorToCheckProperties = {
			name : "checkMMI",
			colorValue : [0,68,100,0],
			space : ColorSpace.CMYK
		};
		
		// 색상이 있는지 없는지 확인하기
		var myColorToCheck = doc.colors.itemByName( myColorToCheckProperties.name );  
		
		if(myColorToCheck.isValid) {  
			// check_notrans 색상이 있을 경우 
			for (var i=0; i < mmiCS.length; i++) {
				// applyColorMMI(mmiCS[i]);
				if (mmiCS[i].isValid) {
					applyColorMMI(mmiCS[i]);
				} else
					continue;
			}
		} else if (!myColorToCheck.isValid) {  
			// check_notrans 색상이 없을 경우 추가하고 진행
			doc.colors.add (myColorToCheckProperties);
			for (var i=0; i < mmiCS.length; i++) {
				// applyColorMMI(mmiCS[i]);
				if (mmiCS[i].isValid) {
					applyColorMMI(mmiCS[i]);
				} else
					continue;
			}
		};
	}

	function applyColorMMI(mmiCS) {
		if (mmiCS.fillColor == null) {
			mmiCS.fillColor = "checkMMI";
		} else {
			mmiCS.fillColor = null;
		} 
	}
}