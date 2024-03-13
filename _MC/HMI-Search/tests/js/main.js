function copyCell(td) {
	$('td.selectable').each(function(){
		$(this).removeClass('selectable');
	})
	copyToClipboard(td.innerHTML);
	// alert('copied to clipboard');
	$(td).addClass('selectable');
}

function copyToClipboard(textToCopy) {
	let input = document.createElement("input");
    document.body.appendChild(input);
	console.log(textToCopy);
	input.value = textToCopy;
    input.select();
    document.execCommand("Copy");
	input.remove();
}

function selectOnlyThis(id){
	let myCheckbox = document.getElementsByName("viewoption");
	Array.prototype.forEach.call(myCheckbox,function(el){
	  el.checked = false;
	});
	id.checked = true;
  }

$(document).ready(function() {
	
	console.log(location.search);
	let $_GET = {};
	location.search.replace(/([^=&?]+)=([^&]+)/gi, function (a, b, c) {
		$_GET[decodeURIComponent(b)] = decodeURIComponent(c);
	});
	let mainKeyword = $_GET['searchString'];
	let selectedlang = $_GET['lang'];
	// let sPart = $_GET['part'];
	let sCase = $_GET['byCase'];
	let region = $_GET['region'];

	mainKeyword = mainKeyword.replace(/\+/gi, ' ');
	console.log(selectedlang + ";" + mainKeyword + ";" + sCase + ";" + region);
	document.getElementById("searchString").value = mainKeyword;
	document.getElementById("lang").value = selectedlang;
	// document.getElementById("part").value = sPart;
	document.getElementById("region").value = region;

	if (sCase == "on") {
		console.log("대소문자 구분");
		document.getElementById("byCase").checked = true;
	} else {
		console.log("대소문자 구분 X");
		document.getElementById("byCase").checked = false;
	}

	// let keyword = new RegExp('(' + mainKeyword + ')', 'gi');
	console.log("json/mobis.json");
	$.ajax({
		dataType : "json",
		url : "json/mobis.json",
		success : function(data) { 
			$("#wait-container").hide();
			let html = "<table class='result'>";
			html += "<thead><tr>";
			if (region == "all") {
				//header 만들기
				html += "<th>ID</th><th>KOR</th><th>ENG_US</th><th>MSPA</th><th>CFRE</th><th>BPO</th><th>SC_CHI</th><th>JAP</th><th>ENG_AU</th><th>ENG_UK</th><th>GER</th><th>FRE</th><th>ITA</th><th>SPA</th><th>POR</th><th>DUT</th><th>DAN</th><th>SWE</th><th>NOR</th><th>POL</th><th>CZE</th><th>SLK</th><th>RUS</th><th>UKR</th><th>SLN</th><th>GRE</th><th>FIN</th><th>HUN</th><th>TUR</th><th>ARA</th><th>PER</th><th>HEB</th><th>INS</th><th>Hindi</th><th>Bengali</th><th>Marathi</th><th>Telug</th><th>Tamil</th><th>Gujarati</th><th>Kannada</th><th>Odia</th><th>Malayalam</th><th>Punjabi</th>";
			} else if (region == "int") {
				html += "<th>ID</th><th>KOR</th><th>ENG_US</th>";
			} else if (region == "usa") {
				html += "<th>ID</th><th>KOR</th><th>ENG_US</th><th>MSPA</th><th>CFRE</th>";
			} else if (region == "mid") {
				html += "<th>ID</th><th>KOR</th><th>ENG_UK</th><th>FRE</th><th>ARA</th>";
			} else if (region == "ltn") {
				html += "<th>ID</th><th>KOR</th><th>ENG_US</th><th>MSPA</th><th>BPO</th>";
			} else if (region == "gen") {
				html += "<th>ID</th><th>KOR</th><th>ENG_US</th><th>MSPA</th><th>CFRE</th><th>BPO</th><th>ARA</th>";
			} else if (region == "ind") {
				html += "<th>ID</th><th>ENG_UK</th>";
			} else if (region == "chi") {
				html += "<th>ID</th><th>KOR</th><th>SC_CHI</th>";
			}
			html += "</tr></thead><tbody>";
			
			$.each(data, function(key, value) {
				// console.log(key); key는 index
				if (sCase == "on") {
					if (region == "all") { // 전체를 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.indexOf(mainKeyword) > -1) {
								outputTableAll();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.indexOf(mainKeyword) > -1) {
								outputTableAll();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_US.indexOf(mainKeyword) > -1 || value.ENG_UK.indexOf(mainKeyword) > -1) {
								outputTableAll();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "int") { // 내수를 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.indexOf(mainKeyword) > -1) {
								outputTableInt();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.indexOf(mainKeyword) > -1) {
								outputTableInt();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_US.indexOf(mainKeyword) > -1) {
								outputTableInt();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "usa") { // 북미를 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.indexOf(mainKeyword) > -1) {
								outputTableUsa();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.indexOf(mainKeyword) > -1) {
								outputTableUsa();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_US.indexOf(mainKeyword) > -1) {
								outputTableUsa();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "mid") { // 중동을 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.indexOf(mainKeyword) > -1) {
								outputTableMid();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.indexOf(mainKeyword) > -1) {
								outputTableMid();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_UK.indexOf(mainKeyword) > -1) {
								outputTableMid();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "ltn") { // 브라질/멕시코롤 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.indexOf(mainKeyword) > -1) {
								outputTableLtn();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.indexOf(mainKeyword) > -1) {
								outputTableLtn();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_US.indexOf(mainKeyword) > -1) {
								outputTableLtn();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "gen") { // 일반을 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.indexOf(mainKeyword) > -1) {
								outputTableGen();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.indexOf(mainKeyword) > -1) {
								outputTableGen();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_US.indexOf(mainKeyword) > -1) {
								outputTableGen();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "ind") { // 인도를 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.indexOf(mainKeyword) > -1) {
								outputTableInd();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.indexOf(mainKeyword) > -1) {
								outputTableInd();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_UK.indexOf(mainKeyword) > -1) {
								outputTableInd();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "chi") { // 중국을 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.indexOf(mainKeyword) > -1) {
								outputTableChi();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.indexOf(mainKeyword) > -1) {
								outputTableChi();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_UK.indexOf(mainKeyword) > -1 || value.ENG_US.indexOf(mainKeyword) > -1) {
								outputTableChi();
							}
						} else if (selectedlang == "SC_CHI") {
							if (value.SC_CHI.indexOf(mainKeyword) > -1) {
								outputTableChi();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					}
				} else { // 대소문자 구분 X
					if (region == "all") { // 전체를 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.match(new RegExp(mainKeyword, "i"))) {
								outputTableAll();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
								outputTableAll();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_US.match(new RegExp(mainKeyword, "i")) || value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
								outputTableAll();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "int") { // 내수를 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.match(new RegExp(mainKeyword, "i"))) {
								outputTableInt();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
								outputTableInt();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_US.match(new RegExp(mainKeyword, "i"))) {
								outputTableInt();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "usa") {
						if (selectedlang == "ID") {
							if (value.ID.match(new RegExp(mainKeyword, "i"))) {
								outputTableUsa();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
								outputTableUsa();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_US.match(new RegExp(mainKeyword, "i"))) {
								outputTableUsa();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "mid") { // 중동을 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.match(new RegExp(mainKeyword, "i"))) {
								outputTableMid();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
								outputTableMid();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
								outputTableMid();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "ltn") { // 브라질/멕시코롤 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.match(new RegExp(mainKeyword, "i"))) {
								outputTableLtn();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
								outputTableLtn();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_US.match(new RegExp(mainKeyword, "i"))) {
								outputTableLtn();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "gen") { // 일반을 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.match(new RegExp(mainKeyword, "i"))) {
								outputTableGen();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
								outputTableGen();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_US.match(new RegExp(mainKeyword, "i"))) {
								outputTableGen();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "ind") { // 인도를 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.match(new RegExp(mainKeyword, "i"))) {
								outputTableInd();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
								outputTableInd();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
								outputTableInd();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "chi") { // 중국을 선택했을 경우
						if (selectedlang == "ID") {
							if (value.ID.match(new RegExp(mainKeyword, "i"))) {
								outputTableChi();
							}
						} else if (selectedlang == "KOR") {
							if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
								outputTableChi();
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
								outputTableChi();
							}
						} else if (selectedlang == "SC_CHI") {
							if (value.SC_CHI.match(new RegExp(mainKeyword, "i"))) {
								outputTableChi();
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					}
				}
				
				function outputTableAll() {
					html += "<tr>";
					$.each(value, function (index, string) {
						html += "<td ondblclick='copyCell(this)' class=" + index + ">" + string + "</td>";
					});
					html += "</tr>";
				}
				function outputTableInt() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_US + ">" + value.ENG_US + "</td>";
					html += "</tr>";
				}
				function outputTableUsa() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_US + ">" + value.ENG_US + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.MSPA + ">" + value.MSPA + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.CFRE + ">" + value.CFRE + "</td>";
					html += "</tr>";
				}
				function outputTableMid() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_UK + ">" + value.ENG_UK + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.FRE + ">" + value.FRE + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ARA + ">" + value.ARA + "</td>";
					html += "</tr>";
				}
				function outputTableLtn() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_US + ">" + value.ENG_US + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.MSPA + ">" + value.MSPA + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.BPO + ">" + value.BPO + "</td>";
					html += "</tr>";
				}
				function outputTableGen() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_US + ">" + value.ENG_US + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.MSPA + ">" + value.MSPA + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.CFRE + ">" + value.CFRE + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.BPO + ">" + value.BPO + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ARA + ">" + value.ARA + "</td>";
					html += "</tr>";
				}
				function outputTableInd() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_UK + ">" + value.ENG_UK + "</td>";
					html += "</tr>";
				}
				function outputTableChi() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.SC_CHI + ">" + value.SC_CHI + "</td>";
					html += "</tr>";
				}
			});
			html += "</tbody></table>";
			if (html.indexOf("<tbody></tbody>") != -1) {
				// console.log("찾는게 없어");
				html += "<p style='text-align:center'>검색한 내용을 찾을 수 없습니다.</p>"
			}

			$("#result").append(html);
		},
		error : function(){ alert("선택한 언어에 해당하는 번역 데이터가 없습니다."); }
	});
	
	
	$('#textonly').click(function() {
		if ($(this).is(':checked')) {
			$('.stag').each(function() {
				$(this).hide();
			});
			$('characterstyle').each(function() {
				$(this).hide();
			});
			$('languagevariable').each(function() {
				$(this).addClass('hidden');
			});
		}
	});
	$('#simpletag').click(function() {
		if ($(this).is(':checked')) {
			$('.stag').each(function() {
				$(this).show();
			});
			$('characterstyle').each(function() {
				$(this).hide();
			});
			$('languagevariable').each(function() {
				$(this).addClass('hidden');
			});
		}
	});
	$('#fulltag').click(function() {
		if ($(this).is(':checked')) {
			$('.stag').each(function() {
				$(this).show();
			});
			$('characterstyle').each(function() {
				$(this).show();
			});
			$('languagevariable').each(function() {
				$(this).removeClass('hidden');
			});
		}
	});
});