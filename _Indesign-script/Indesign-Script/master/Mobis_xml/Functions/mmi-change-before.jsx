function changeBefore() {
	var doc = app.activeDocument;
	//Enter에 적용된 문자 스타일 해제
	app.findGrepPreferences = app.findChangeGrepOptions = NothingEnum.nothing;
	app.changeGrepPreferences = app.findChangeGrepOptions = NothingEnum.nothing;
	app.findGrepPreferences.properties = {
		findWhat : "(\\r)",
	}
	app.findChangeGrepOptions.properties = {
		includeFootnotes:false,
		includeHiddenLayers:false,
		includeLockedLayersForFind:false,
		includeLockedStoriesForFind:false,
		includeMasterPages:false,
	}
	app.changeGrepPreferences.appliedCharacterStyle = app.characterStyles.item("$ID/[None]");
	app.changeGrepPreferences.changeTo = "";
	doc.changeGrep();
	app.findGrepPreferences = app.findChangeGrepOptions = NothingEnum.nothing;
	app.changeGrepPreferences = app.findChangeGrepOptions = NothingEnum.nothing;
}