function DeleteCondtionalText () {
	var doc = app.activeDocument;
	var MMI = doc.conditions.item("MMI");
	try {
		if (MMI.isValid == true) {
			if (MMI.visible == true) {
				gogo();
			} else if (MMI.visible == false) {
				MMI.visible = true;
				gogo();
			}
		} if (MMI.isValid == false) {
			gogo();
		}
	} catch(e) {
		// alert("문서에 문제가 있습니다. 개발자에게 문의하세요.");
	}
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

		app.findGrepPreferences.appliedConditions = ["MMI"];
		app.changeGrepPreferences.changeTo = "";

		doc.changeGrep();
		MMI.remove();
	}
}