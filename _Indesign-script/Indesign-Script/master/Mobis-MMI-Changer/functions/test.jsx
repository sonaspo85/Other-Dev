var newID = "MMI-0530"
var doc = app.activeDocument;
var Cond = doc.conditions;
if (!doc.conditions.item(newID).isValid) {
    // $.writeln("add " + mmiIDx);
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
alert(newID + " 아이디를 적용합니다.");