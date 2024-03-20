//Save the current application setting.
var currentAppSettings = {checkLinksAtOpen: app.linkingPreferences.checkLinksAtOpen};

// //Set the value to false to prevent the dialog from showing.
// app.linkingPreferences.checkLinksAtOpen = false;
// app.scriptPreferences.userInteractionLevel = UserInteractionLevels.neverInteract;

var doc = app.activeDocument;

// var curFile = doc.filePath.absoluteURI + '/delta.xml';
// doc.importXML(File(curFile));

// need to apply styling to tags
// doc.mapXMLTagsToStyles();

var root = doc.xmlElements[0]; // root
var element = root.xmlElements[0];
root.placeXML(doc.textFrames[0]);

// Set the value back to its original value.
app.linkingPreferences.checkLinksAtOpen = currentAppSettings.checkLinksAtOpen;
for (var i = 0; i < doc.allGraphics.length; i++)
{
    var target = doc.allGraphics[i].parent;
    target.fit(FitOptions.frameToContent);
}


// doc.viewPreferences.horizontalMeasurementUnits = MeasurementUnits.points;
// doc.viewPreferences.verticalMeasurementUnits = MeasurementUnits.points;
// doc.viewPreferences.rulerOrigin = RulerOrigin.pageOrigin;

app.scriptPreferences.userInteractionLevel = UserInteractionLevels.INTERACT_WITH_ALL;