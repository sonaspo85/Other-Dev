console.show();
console.println(this.documentFileName + " 견적 페이지 출력 ---------------------------------");
Note_check ();
console.println("------------------------------------------------------------------");
function Note_check () {
	this.syncAnnotScan();
	var Stamp01 = [], Stamp02 = [], Stamp03 = [], Stamp04 = [], Stamp05 = [], Stamp06 = [], Stamp07 = [], Stamp08 = [], Stamp09 = [], Stamp10 = [], Stamp11 = [], Stamp12 = [], Stamp13 = [], Stamp14 = [], Stamp15 = [], Stamp16 = [];
	var count01 = count02 = count03 = count04 = count05 = count06 = count07 = count08 = count09 = count10 = count11 = count12 = count13 = count14 = count15 = count16 = 0;
	for (var p=0; p<this.numPages; p++) {
		var annots = this.getAnnots({nPage: p});
		if (annots==null || annots.length==0) continue;
		for (var i in annots) {  
			if (annots[i].subject == "S-ivi") {
				var stampName01 = "IVI시스템운영";
				Stamp01.push(p+1);
				count01 ++;
			}
			if (annots[i].subject == "P-new_1") {
				var stampName02 = "신규기획(I)";
				Stamp02.push(p+1);
				count02 ++;
			}
			if (annots[i].subject == "P-new_2") {
				var stampName03 = "신규기획(II)";
				Stamp03.push(p+1);
				count03 ++;
			}
			if (annots[i].subject == "P-modif_1") {
				var stampName04 = "파생검토(일반)";
				Stamp04.push(p+1);
				count04 ++;
			}
			if (annots[i].subject == "P-modif_2") {
				var stampName05 = "파생검토(정업)";
				Stamp05.push(p+1);
				count05 ++;
			}
			if (annots[i].subject == "P-design") {
				var stampName06 = "디자인기획";
				Stamp06.push(p+1);
				count06 ++;
			}
			if (annots[i].subject == "W-new") {
				var stampName07 = "신규작성";
				Stamp07.push(p+1);
				count07 ++;
			}
			if (annots[i].subject == "W-modif") {
				var stampName08 = "파생작성";
				Stamp08.push(p+1);
				count08 ++;
			}
			if (annots[i].subject == "I-new_1") {
				var stampName09 = "신규도안(I)";
				Stamp09.push(p+1);
				count09 ++;
			}
			if (annots[i].subject == "I-new_2") {
				var stampName10 = "신규도안(II)";
				Stamp10.push(p+1);
				count10 ++;
			}
			if (annots[i].subject == "I-modif") {
				var stampName11 = "수정도안";
				Stamp11.push(p+1);
				count11 ++;
			}
			if (annots[i].subject == "B-bacode") {
				var stampName12 = "바코드";
				Stamp12.push(p+1);
				count12 ++;
			}
			if (annots[i].subject == "D-dtp") {
				var stampName13 = "편집";
				Stamp13.push(p+1);
				count13 ++;
			}
			if (annots[i].subject == "H-trans") {
				var stampName14 = "기본HTML";
				Stamp14.push(p+1);
				count14 ++;
			}
			if (annots[i].subject == "H-trans_4") {
				var stampName15 = "추가HTML";
				Stamp15.push(p+1);
				count15 ++;
			}
			if (annots[i].subject == "Q-qrcode") {
				var stampName16 = "QR코드검수";
				Stamp16.push(p+1);
				count16 ++;
			}
		}
	}
	if (Stamp01.length > 0) {
		console.println(stampName01 + " [" + count01 + "]" + ": " + Stamp01.join(", "));
	}
	if (Stamp02.length > 0) {
		console.println(stampName02 + " [" + count02 + "]" + ": " + Stamp02.join(", "));
	}
	if (Stamp03.length > 0) {
		console.println(stampName03 + " [" + count03 + "]" + ": " + Stamp03.join(", "));
	}
	if (Stamp04.length > 0) {
		console.println(stampName04 + " [" + count04 + "]" + ": " + Stamp04.join(", "));
	}
	if (Stamp05.length > 0) {
		console.println(stampName05 + " [" + count05 + "]" + ": " + Stamp05.join(", "));
	}
	if (Stamp06.length > 0) {
		console.println(stampName06 + " [" + count06 + "]" + ": " + Stamp06.join(", "));
	}
	if (Stamp07.length > 0) {
		console.println(stampName07 + " [" + count07 + "]" + ": " + Stamp07.join(", "));
	}
	if (Stamp08.length > 0) {
		console.println(stampName08 + " [" + count08 + "]" + ": " + Stamp08.join(", "));
	}
	if (Stamp09.length > 0) {
		console.println(stampName09 + " [" + count09 + "]" + ": " + Stamp09.join(", "));
	}
	if (Stamp10.length > 0) {
		console.println(stampName10 + " [" + count10 + "]" + ": " + Stamp10.join(", "));
	}
	if (Stamp11.length > 0) {
		console.println(stampName11 + " [" + count11 + "]" + ": " + Stamp11.join(", "));
	}
	if (Stamp12.length > 0) {
		console.println(stampName12 + " [" + count12 + "]" + ": " + Stamp12.join(", "));
	}
	if (Stamp13.length > 0) {
		console.println(stampName13 + " [" + count13 + "]" + ": " + Stamp13.join(", "));
	}
	if (Stamp14.length > 0) {
		console.println(stampName14 + " [" + count14 + "]" + ": " + Stamp14.join(", "));
	}
	if (Stamp15.length > 0) {
		console.println(stampName15 + " [" + count15 + "]" + ": " + Stamp15.join(", "));
	}
	if (Stamp16.length > 0) {
		console.println(stampName16 + " [" + count16 + "]" + ": " + Stamp16.join(", "));
	}
}
