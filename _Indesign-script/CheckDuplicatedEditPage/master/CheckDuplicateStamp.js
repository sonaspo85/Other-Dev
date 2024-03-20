var d = app.activeDocs;
if (d.length > 2 || d.length < 2) {
	app.alert("2개 문서만 열어놓은 상태에서 다시 실행하세요.");
	exit();
}
var edited = [];
for (var i=0; i<d.length; i++) {
	// console.println(d[i].documentFileName);
	d[i].syncAnnotScan();
	for (var p=0; p<d[i].numPages; p++) {
		var annots = d[i].getAnnots({nPage: p});
		if (annots == null || annots.length == 0) continue;
		for (var j in annots) {
			if (annots[j].subject == "D-dtp") {
				// console.println(p);
				edited.push(p+1);
			}
		}
	}
}
var result = duplicateRemove(edited);
if (result == "") {
	app.alert("중복된 페이지가 없습니다.");
} else {
	app.alert(result + " 페이지에 스탬프가 겹칩니다.");
}
// console.println(edited.sort());

function duplicateRemove(nPage) { // 중복 제거
	var m = {};
	var newarr = [];
	for (var x=0; x<nPage.length; x++) {
		var v = nPage[x];
		if (!m[v]) {
			m[v] = true;
		} else {
			newarr.push(nPage[x]);
		}
	}
	return newarr
}