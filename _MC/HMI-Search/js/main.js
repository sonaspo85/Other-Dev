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
	let sMatch = $_GET['matchAll'];
	let region = $_GET['region'];
	let yesNo = $_GET['yesNo'];

	mainKeyword = mainKeyword.replace(/\+/gi, ' ');
	console.log(selectedlang + ";" + mainKeyword + ";" + sCase + ";" + region + ";" + yesNo + ";");
	document.getElementById("searchString").value = mainKeyword;
	document.getElementById("lang").value = selectedlang;
	// document.getElementById("part").value = sPart;
	document.getElementById("region").value = region;
	document.getElementById("yesNo").value = yesNo;

	if(yesNo == 'aaa') {
		const element1 = document.querySelector('select[name="region"] > option[value="usa"]');
		element1.innerText = '북미';
		
		const element2 = document.querySelector('select[name="region"] > option[value="ltn"]');
		element2.innerText = '브라질/멕시코';

		const element3 = document.querySelector('select[name="region"] > option[value="eur"]');
        element3.innerText = '유럽';

	} 

	if (sCase == "on") {
		console.log("대소문자 구분");
		document.getElementById("byCase").checked = true;
	} else {
		console.log("대소문자 구분 X");
		document.getElementById("byCase").checked = false;
	}

	if (sMatch == "on") {
		document.getElementById("matchAll").checked = true;
	} else {
		document.getElementById("matchAll").checked = false;
	}

	let termdb;
	// if (region == "ind") {
	// 	termdb = "json/mobis_ind.json"
	// } else {
	// 	termdb = "json/mobis.json"
	// }

	if(yesNo == "aaa") {
		if (region == "ind") {
			termdb = "json/mobis_ind.json"

		} else {
			termdb = "json/mobis.json"
		}
	} else if(yesNo == "bbb") {
		termdb = "json/mobis_ccnc.json"

	}

	// let keyword = new RegExp('(' + mainKeyword + ')', 'gi');
	// console.log("rrr:" + termdb);
	$.ajax({
		dataType : "json",
		url : termdb,
		success : function(data) { 
			$("#wait-container").hide();
			let html = "<table class='result'>";
			html += "<thead><tr>";
			if (region == "all") {
				//header 만들기
				html += "<th>ID</th><th>KOR</th><th>ENG_US</th><th>MSPA</th><th>CFRE</th><th>BPO</th><th>SC_CHI</th><th>JAP</th><th>ENG_AU</th><th>ENG_UK</th><th>GER</th><th>FRE</th><th>ITA</th><th>SPA</th><th>POR</th><th>ROM</th><th>DUT</th><th>DAN</th><th>SWE</th><th>NOR</th><th>POL</th><th>CZE</th><th>SLK</th><th>RUS</th><th>UKR</th><th>SLN</th><th>CRO</th><th>BUL</th><th>GRE</th><th>FIN</th><th>HUN</th><th>TUR</th><th>ARA</th><th>PER</th><th>HEB</th><th>Hindi</th><th>Bengali</th><th>Marathi</th><th>Telug</th><th>Tamil</th><th>Gujarati</th><th>Kannada</th><th>Odia</th><th>Malayalam</th><th>Punjabi</th><th>INS</th>";
			} else if (region == "int") {  // 내수
				html += "<th>ID</th><th>KOR</th><th>ENG_US</th>";
			} else if (region == "usa") {  // 북미
				html += "<th>ID</th><th>KOR</th><th>ENG_US</th><th>MSPA</th><th>CFRE</th>";
			} else if (region == "mid") {  // 중동
				html += "<th>ID</th><th>KOR</th><th>ENG_UK</th><th>FRE</th><th>ARA</th>";
			} 
			
			else if (region == "ltn") {  // 브라질/멕시코
				html += "<th>ID</th><th>KOR</th><th>ENG_US</th><th>MSPA</th><th>BPO</th>";
			} 
			
			else if (region == "gen") {  // 일반
				html += "<th>ID</th><th>KOR</th><th>ENG_US</th><th>MSPA</th><th>FRE</th><th>BPO</th><th>ARA</th><th>HEB</th><th>TAIWAN</th>";
			} else if (region == "pio") {  // 인도
				html += "<th>ID</th><th>ENG_UK</th>";
			} else if (region == "chi") {  // 중국
				html += "<th>ID</th><th>KOR</th><th>SC_CHI</th>";
			} else if (region == "jpn") {  // 일본
				html += "<th>ID</th><th>KOR</th><th>ENG_US</th><th>JPN</th><th>SC_CHI</th>";
			} else if (region == "ind") {  // 인도
				html += "<th>ID</th><th>KOR</th><th>ENG_UK</th><th>Hindi</th><th>Bengali</th><th>Marathi</th><th>Telug</th><th>Tamil</th><th>Gujarati</th><th>Kannada</th><th>Odia</th><th>Malayalam</th><th>Punjabi</th>";
			} else if (region == "inn") {  // 인도네시아
				html += "<th>ID</th><th>KOR</th><th>ENG_UK</th><th>Indonesian</th>";
			} else if (region == "aus") {  // 호주
				html += "<th>ID</th><th>KOR</th><th>ENG_AU</th>";
			} else if (region == "sin") {  // 싱가폴
				html += "<th>ID</th><th>KOR</th><th>ENG_UK</th><th>Chinese singapore</th>";
			} else if (region == "eur") {  // 유럽
				html += "<th>ID</th><th>KOR</th><th>ENG_UK</th><th>GER</th><th>FRE</th><th>ITA</th><th>SPA</th><th>POR</th><th>ROM</th><th>DUT</th><th>DAN</th><th>SWE</th><th>NOR</th><th>POL</th><th>CZE</th><th>SLK</th><th>RUS</th><th>UKR</th><th>SLN</th><th>CRO</th><th>BUL</th><th>GRE</th><th>FIN</th><th>HUN</th><th>TUR</th>";
			}

			html += "</tr></thead><tbody>";
			
			$.each(data, function(key, value) {
				// console.log(key); //key는 index
				if (sCase == "on") {
					console.log("aaaaaaaaa");
					if (region == "all") { // 전체를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableAll();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableAll();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableAll();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableAll();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_US == mainKeyword || value.ENG_UK == mainKeyword) {
									outputTableAll();
								}
							} else {
								if (value.ENG_US.indexOf(mainKeyword) > -1 || value.ENG_UK.indexOf(mainKeyword) > -1) {
									outputTableAll();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "int") { // 내수를 선택했을 경우
						// console.log("111111111111111111")
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableInt();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableInt();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableInt();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableInt();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_US == mainKeyword) {
									outputTableInt();
								}
							} else {
								if (value.ENG_US.indexOf(mainKeyword) > -1) {
									outputTableInt();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "usa") { // 북미를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableUsa();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableUsa();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableUsa();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableUsa();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_US == mainKeyword) {
									outputTableUsa();
								}
							} else {
								if (value.ENG_US.indexOf(mainKeyword) > -1) {
									outputTableUsa();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "mid") { // 중동을 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableMid();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableMid();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableMid();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableMid();
								}
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
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableLtn();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableLtn();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableLtn();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableLtn();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_US == mainKeyword) {
									outputTableLtn();
								}
							} else {
								if (value.ENG_US.indexOf(mainKeyword) > -1) {
									outputTableLtn();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "gen") { // 일반을 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableGen();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableGen();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableGen();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableGen();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_US == mainKeyword) {
									outputTableGen();
								}
							} else {
								if (value.ENG_US.indexOf(mainKeyword) > -1) {
									outputTableGen();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "inn") { // 인도를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableInn();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableInn();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableInn();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableInn();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK == mainKeyword) {
									outputTableInn();
								}
							} else {
								if (value.ENG_UK.indexOf(mainKeyword) > -1) {
									outputTableInn();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "aus") { // 인도를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableAus();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableAus();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableAus();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableAus();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_AU == mainKeyword) {
									outputTableAus();
								}
							} else {
								if (value.ENG_AU.indexOf(mainKeyword) > -1) {
									outputTableAus();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "pio") { // 인도를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTablePio();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTablePio();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTablePio();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTablePio();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK == mainKeyword) {
									outputTablePio();
								}
							} else {
								if (value.ENG_UK.indexOf(mainKeyword) > -1) {
									outputTablePio();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "ind") { // 인도를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableInd();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableInd();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableInd();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableInd();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK == mainKeyword) {
									outputTableInd();
								}
							} else {
								if (value.ENG_UK.indexOf(mainKeyword) > -1) {
									outputTableInd();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "chi") { // 중국을 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableChi();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableChi();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableChi();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableChi();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK == mainKeyword || value.ENG_US == mainKeyword) {
									outputTableChi();
								}
							} else {
								if (value.ENG_UK.indexOf(mainKeyword) > -1 || value.ENG_US.indexOf(mainKeyword) > -1) {
									outputTableChi();
								}
							}
						} else if (selectedlang == "SC_CHI") {
							if (sMatch == "on") {
								if (value.SC_CHI == mainKeyword) {
									outputTableChi();
								}
							} else {
								if (value.SC_CHI.indexOf(mainKeyword) > -1) {
									outputTableChi();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "jpn") { // 일본을 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableJpn();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableJpn();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableJpn();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableJpn();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_US == mainKeyword) {
									outputTableJpn();
								}
							} else {
								if (value.ENG_US.indexOf(mainKeyword) > -1) {
									outputTableJpn();
								}
							}
						} else if (selectedlang == "SC_CHI") {
							if (sMatch == "on") {
								if (value.SC_CHI == mainKeyword) {
									outputTableChi();
								}
							} else {
								if (value.SC_CHI.indexOf(mainKeyword) > -1) {
									outputTableChi();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "sin") { // 싱가폴을 선택했을 경우
						// console.log("111111111111111111")
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableSin();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableSin();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableSin();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableSin();
								}
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_UK.indexOf(mainKeyword) > -1) {
					            outputTableSin();
					        }
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "eur") { // 일본을 선택했을 경우
						// console.log("111111111111111111")
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID == mainKeyword) {
									outputTableEur();
								}
							} else {
								if (value.ID.indexOf(mainKeyword) > -1) {
									outputTableEur();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR == mainKeyword) {
									outputTableEur();
								}
							} else {
								if (value.KOR.indexOf(mainKeyword) > -1) {
									outputTableEur();
								}
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_UK.indexOf(mainKeyword) > -1) {
					           outputTableEur();
					        }
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					}
				} else { // 대소문자 구분 X
					if (region == "all") { // 전체를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableAll();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableAll();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableAll();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableAll();
								}
							}
						} else if (selectedlang == "ENG") {
							if (value.ENG_US.match(new RegExp("^" + mainKeyword + "$", "ig")) || value.ENG_UK.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableAll();
							} else {
								if (value.ENG_US.match(new RegExp(mainKeyword, "i")) || value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
									outputTableAll();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "int") { // 내수를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableInt();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableInt();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableInt();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableInt();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_US.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableInt();
								}
							} else {
								if (value.ENG_US.match(new RegExp(mainKeyword, "i"))) {
									outputTableInt();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "usa") {
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableUsa();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableUsa();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableUsa();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableUsa();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_US.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableUsa();
								}
							} else {
								if (value.ENG_US.match(new RegExp(mainKeyword, "i"))) {
									outputTableUsa();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "mid") { // 중동을 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableMid();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableMid();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableMid();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableMid();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableMid();
								}
							} else {
								if (value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
									outputTableMid();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "ltn") { // 브라질/멕시코롤 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableLtn();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableLtn();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableLtn();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableLtn();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_US.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableLtn();
								}
							} else {
								if (value.ENG_US.match(new RegExp(mainKeyword, "i"))) {
									outputTableLtn();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "gen") { // 일반을 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableGen();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableGen();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableGen();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableGen();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_US.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableGen();
								}
							} else {
								if (value.ENG_US.match(new RegExp(mainKeyword, "i"))) {
									outputTableGen();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "inn") { // 인도를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableInn();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableInn();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableInn();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableInn();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableInn();
								}
							} else {
								if (value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
									outputTableInn();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "aus") { // 호주를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableAus();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableAus();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableAus();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableAus();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableAus();
								}
							} else {
								if (value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
									outputTableAus();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "pio") { // 인도를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTablePio();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTablePio();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTablePio();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTablePio();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTablePio();
								}
							} else {
								if (value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
									outputTablePio();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "ind") { // 인도를 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableInd();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableInd();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableInd();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableInd();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableInd();
								}
							} else {
								if (value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
									outputTableInd();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "chi") { // 중국을 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableChi();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableChi();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableChi();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableChi();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableChi();
								}
							} else {
								if (value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
									outputTableChi();
								}
							}
						} else if (selectedlang == "SC_CHI") {
							if (sMatch == "on") {
								if (value.SC_CHI.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableChi();
								}
							} else {
								if (value.SC_CHI.match(new RegExp(mainKeyword, "i"))) {
									outputTableChi();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "jpn") { // 일본을 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableJpn();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableJpn();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableJpn();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableJpn();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_US.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableJpn();
								}
							} else {
								if (value.ENG_US.match(new RegExp(mainKeyword, "i"))) {
									outputTableJpn();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "sin") { // 싱가폴을 선택했을 경우
						// console.log("sinsinsinsinis");
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableSin();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableSin();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableSin();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableSin();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableSin();
								}
							} else {
								if (value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
									outputTableSin();
								}
							}
						} else {
							alert("현재의 출향지 기준으로 선택한 언어를 검색할 수 없습니다.")
							return false;
						}
					} else if (region == "eur") { // 싱가폴을 선택했을 경우
						if (selectedlang == "ID") {
							if (sMatch == "on") {
								if (value.ID.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableEur();
								}
							} else {
								if (value.ID.match(new RegExp(mainKeyword, "i"))) {
									outputTableEur();
								}
							}
						} else if (selectedlang == "KOR") {
							if (sMatch == "on") {
								if (value.KOR.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableEur();
								}
							} else {
								if (value.KOR.match(new RegExp(mainKeyword, "i"))) {
									outputTableEur();
								}
							}
						} else if (selectedlang == "ENG") {
							if (sMatch == "on") {
								if (value.ENG_UK.match(new RegExp("^" + mainKeyword + "$", "ig"))) {
									outputTableEur();
								}
							} else {
								if (value.ENG_UK.match(new RegExp(mainKeyword, "i"))) {
									outputTableEur();
								}
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
					html += "<td ondblclick='copyCell(this)' class=" + value.FRE + ">" + value.FRE + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.BPO + ">" + value.BPO + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ARA + ">" + value.ARA + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Hebrew + ">" + value.Hebrew + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Chinese_Traditional + ">" + value.Chinese_Traditional + "</td>";
					html += "</tr>";
				}
				function outputTableInn() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_UK + ">" + value.ENG_UK + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Indonesian + ">" + value.Indonesian + "</td>";
					html += "</tr>";
				}
				function outputTableAus() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_AU + ">" + value.ENG_AU + "</td>";
					html += "</tr>";
				}
				function outputTablePio() {
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
				function outputTableJpn() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_US + ">" + value.ENG_US + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.JPN + ">" + value.JPN + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.SC_CHI + ">" + value.SC_CHI + "</td>";
					html += "</tr>";
				}
				function outputTableSin() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_UK + ">" + value.ENG_UK + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.SGP + ">" + value.SGP + "</td>";
					html += "</tr>";
				}
				function outputTableInd() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_UK + ">" + value.ENG_UK + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Hindi + ">" + value.Hindi + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Bengali + ">" + value.Bengali + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Marathi + ">" + value.Marathi + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Telugu + ">" + value.Telugu + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Tamil + ">" + value.Tamil + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Gujarati + ">" + value.Gujarati + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Kannada + ">" + value.Kannada + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Odia + ">" + value.Odia + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Malayalam + ">" + value.Malayalam + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.Punjabi + ">" + value.Punjabi + "</td>";
					html += "</tr>";
				}
				function outputTableEur() {
					html += "<tr>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ID + ">" + value.ID + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.KOR + ">" + value.KOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ENG_UK + ">" + value.ENG_UK + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.GER + ">" + value.GER + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.FRE + ">" + value.FRE + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ITA + ">" + value.ITA + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.SPA + ">" + value.SPA + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.POR + ">" + value.POR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.ROM + ">" + value.ROM + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.DUT + ">" + value.DUT + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.DAN + ">" + value.DAN + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.SWE + ">" + value.SWE + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.NOR + ">" + value.NOR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.POL + ">" + value.POL + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.CZE + ">" + value.CZE + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.SLK + ">" + value.SLK + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.RUS + ">" + value.RUS + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.UKR + ">" + value.UKR + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.SLN + ">" + value.SLN + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.CRO + ">" + value.CRO + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.BUL + ">" + value.BUL + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.GRE + ">" + value.GRE + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.FIN + ">" + value.FIN + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.HUN + ">" + value.HUN + "</td>";
					html += "<td ondblclick='copyCell(this)' class=" + value.TUR + ">" + value.TUR + "</td>";
					html += "</tr>";
				}

			});
			html += "</tbody></table>";
			if (html.indexOf("<tbody></tbody>") != -1) {
				console.log("찾는게 없어");
				html += "<p style='text-align:center'>검색한 내용을 찾을 수 없습니다.</p>"
			}

			$("#result").append(html);
		},
		error : function(){ alert("선택한 언어에 해하는 번역 데이터가 없습니다."); }
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
