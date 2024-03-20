// #targetengine "session";
// #include "common.jsx";

// var mmiFile = 'd:/TCS/_develop/111_Mobis-MMI-Changer-Mod/Feedbak/220331/MMI_List_220330.txt';
// mmiListView(2, 9, mmiFile);

function mmiListView(Lang, sIndex, mmiFile) {
	var findString = app.selection[0].contents;
	var hmiData = readTabDelimitedFile(mmiFile);
	var mywin = new Window ("palette");
	var myList = mywin.add("listbox", undefined,"",
		{
			numberOfColumns:2,
			showHeaders:true,
			columnTitles:["ID", "Language"]
		}
	);
	myList.preferredSize = [300, 300];
	var applyBtn = mywin.add("button", [0, 0, 180, 25], "수동 ID 적용")
	var item, mmiText;

	for (var q = hmiData.length - 1; q >= 1; q--) {
		if (hmiData[q][sIndex].indexOf(findString) != -1) {
			item = myList.add("item", hmiData[q][0]);
			item.subItems[0].text = hmiData[q][sIndex];
		}
	}

	mywin.show();
	applyBtn.onClick = function() {
		var newID = myList.selection.text;
		var doc = app.activeDocument;
		var Cond = doc.conditions;
		if (!doc.conditions.item(newID).isValid) {
			Cond.add({
				name: newID,
				indicatorColor: UIColors.GRID_GREEN,
				indicatorMethod: ConditionIndicatorMethod.useHighlight
			});
			app.selection[0].appliedConditions = doc.conditions.item(newID);
		} else {
			// alert("ID가 존재합니다. 기존 ID를 적용합니다.");
			app.selection[0].appliedConditions = doc.conditions.item(newID);
			doc.conditions.item(newID).indicatorColor = UIColors.GRID_GREEN;
		}
		mywin.close();
		alert(newID + " 아이디를 적용합니다.");
	}
}