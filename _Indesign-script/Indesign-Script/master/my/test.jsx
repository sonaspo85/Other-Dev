
var doc = app.activeDocument;
var cstyles = doc.allCharacterStyles;
for (var i = 1 ; i < cstyles.length ; i++) {
	var cstyle = cstyles[i];
	doc.xmlExportMaps.add(cstyle, "span");
}
doc.mapStylesToXMLTags();