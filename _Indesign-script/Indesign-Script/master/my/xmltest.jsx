var doc = app.activeDocument;
var allTables = doc.stories.everyItem().tables.everyItem().getElements();
var myXMLTag = doc.xmlTags.item("Columns");


for (var i=0;i<allTables.length;i++) {
	var myTable = allTables[i];
	var Cols = myTable.columns;
	for (var j=0;j<Cols.length;j++) {
		
		var myXMLElement = doc.xmlElements.item(0).xmlElements.add(myXMLTag);
	}
}

