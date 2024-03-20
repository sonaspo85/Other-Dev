function setConditionaltxt () {
	var doc = app.activeDocument;
	var Cond = doc.conditions;
	for (var i=0; i<Cond.length; i++) {
		if (Cond[i].name == "MMI") {
			maingo();
		} else {
			continue
		}
	} 
	doc.conditions.add({
		name: "MMI",
		indicatorColor: [255, 247, 102],
		indicatorMethod: ConditionIndicatorMethod.useHighlight
	});
	maingo ();

	function maingo () {
		var MMI = doc.conditions.item("MMI");
		app.findGrepPreferences = NothingEnum.nothing;
		app.changeGrepPreferences = NothingEnum.nothing;

		//set find options
		app.findChangeGrepOptions.includeFootnotes = false;
		app.findChangeGrepOptions.includeHiddenLayers = false;
		app.findChangeGrepOptions.includeLockedLayersForFind = false;
		app.findChangeGrepOptions.includeLockedStoriesForFind = false;
		app.findChangeGrepOptions.includeMasterPages = false;

		app.findGrepPreferences.findWhat = "(\\$\\{MMI-\\d\\d\\d\\d\\}|\\$)";
		var myFound = doc.findGrep();

		for (var i=0; i<myFound.length; i++) {
			myFound[i].appliedConditions = doc.conditions.item("MMI");
		}
		app.findGrepPreferences = NothingEnum.nothing;
		app.changeGrepPreferences = NothingEnum.nothing;

		doc.conditions.item("MMI").visible = false;
	}
}