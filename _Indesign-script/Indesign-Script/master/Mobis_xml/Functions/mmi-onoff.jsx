function mmiOnOff () {
	var doc = app.activeDocument;
	var MMI = doc.conditions.item("MMI");
	try {
		if (MMI.visible == true) {
			MMI.visible = false;
		} 
		else if (MMI.visible == false) {
			MMI.visible = true;
		}
	} catch (err) {
		alert(err);
	}
}