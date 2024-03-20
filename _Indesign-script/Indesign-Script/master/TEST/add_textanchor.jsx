var doc = app.activeDocument;

app.findTextPreferences = NothingEnum.nothing;
app.changeTextPreferences = NothingEnum.nothing;

app.findTextPreferences.findWhat = "Learn the Menu Screen";
app.findTextPreferences.appliedParagraphStyle = "Heading1"

var found = doc.findText();

if (found.length == 1) {
	doc.hyperlinkTextDestinations.add(found[0].insertionPoints[0]);
}


app.findTextPreferences = NothingEnum.nothing;
app.changeTextPreferences = NothingEnum.nothing;