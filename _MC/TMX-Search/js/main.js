function copyCell(td) {
	$('td.selectable').each(function(){
		$(this).removeClass('selectable');
	})
	copyToClipboard(td.childNodes[0].innerHTML);
	// alert('copied to clipboard');
	$(td).addClass('selectable');
}

function copyToClipboard(textToCopy) {
	let input = document.createElement("input");
    document.body.appendChild(input);
	console.log(textToCopy);
	input.value = textToCopy.replace(/(<([^>]+)>)/g, "").replace(/&nbsp;/g, " ").replace(/&lt;/g, "<").replace(/&gt;/g, ">");
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
	let sPart = $_GET['part'];
	let sCase = $_GET['byCase'];

	if (sPart == "MOBIS") {
		// let arr = [ 'ALB', 'ARA-AS', 'ARA-EU', 'AZE', 'BUL', 'BUR', 'CRO', 'CZE', 'DAN', 'DUT', 'FAR', 'FIN', 'GEORGIAN', 'GER', 'GRE', 'HEB', 'HKG', 'HUN', 'ITA', 'KAZ', 'LAO', 'Main-KHM', 'Vendor-KHM', 'Malta', 'MKD', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SG-CHI', 'SC2ENG', 'SLK', 'SLV', 'SPA', 'Ltn-SPA', 'SWE', 'THA', 'TPE', 'TUR', 'UKR', 'URD', 'UZB', 'VIE', 'Zawgyi-BUR', 'SamsungOne-BUR', 'IRI', 'MAL', 'Malta', 'BOS', 'KIR', 'RGK', 'TUK', 'CNR' ];
		let arr = ['ARM', 'ARA', 'BUL', 'BEN', 'S-CHI', 'KOR2TPE', 'EST', 'FRE', 'CA-FRE', 'GUJ', 'HIN', 'IND', 'IRL', 'JPN', 'KAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB' ,'KOR2ENG-US', 'LAT', 'LIT', 'MAY', 'ODI', 'PUN', 'KOR2S-CHI', 'SPA', 'M-SPA', 'MAR', 'TAM', 'TEL'];
		$('#lang option').each(function(i) {
			if ($.inArray($(this).attr('value'), arr) != -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "MOBIS-CCNC") {
		// let arrcc = [ 'ALB', 'ARA-AS', 'ARA-EU', 'AZE', 'BUL', 'BUR', 'CRO', 'CZE', 'DAN', 'DUT', 'FAR', 'FIN', 'GEORGIAN', 'GER', 'GRE', 'HEB', 'HKG', 'HUN', 'ITA', 'KAZ', 'LAO', 'Main-KHM', 'Vendor-KHM', 'MKD', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SG-CHI', 'SC2ENG', 'SLK', 'SLV', 'SPA', 'Ltn-SPA', 'SWE', 'THA', 'TPE', 'TUR', 'UKR', 'URD', 'UZB', 'VIE', 'Zawgyi-BUR', 'SamsungOne-BUR', 'BOS', 'KIR', 'RGK', 'TUK', 'CNR', 'IRI', 'MAL', 'Malta' ];
		let arrcc = ['ARM', 'ARA', 'BUL', 'BEN', 'S-CHI', 'SG-CHI', 'TPE', 'KOR2TPE', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FIN', 'FRE', 'CA-FRE', 'GER', 'GRE', 'GUJ', 'HEB', 'HIN', 'HUN', 'IND', 'IRL', 'ITA', 'JPN', 'KAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAT', 'LIT', 'MAY', 'MAL', 'MAR', 'NOR', 'ODI', 'POL', 'POR', 'B-POR', 'ROM', 'RUS', 'KOR2S-CHI', 'SLK', 'SLV', 'SPA', 'M-SPA', 'SWE', 'TAM', 'TEL', 'TUR', 'UKR', 'MAR'];
		$('#lang option').each(function(i) {
			if ($.inArray($(this).attr('value'), arrcc) != -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "MOBIS-external") {
		// let arrex = [ 'ALB', 'ARA-AS', 'ARA-EU', 'AZE', 'BUL', 'BUR', 'CRO', 'CZE', 'DAN', 'DUT', 'FAR', 'FIN', 'GEORGIAN', 'GER', 'GRE', 'HEB', 'HKG', 'HUN', 'ITA', 'KAZ', 'LAO', 'Main-KHM', 'Vendor-KHM', 'MKD', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SG-CHI', 'SC2ENG', 'SLK', 'SLV', 'SPA', 'Ltn-SPA', 'SWE', 'THA', 'TPE', 'TUR', 'UKR', 'URD', 'UZB', 'VIE', 'Zawgyi-BUR', 'SamsungOne-BUR', 'BOS', 'KIR', 'RGK', 'TUK', 'CNR', 'IRI', 'MAL', 'Malta' ];
		let arrex = ['ARA', 'BUL', 'BEN', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FIN', 'FRE', 'CA-FRE', 'GER', 'GRE', 'GUJ', 'HEB', 'HIN', 'HUN', 'IND', 'ITA', 'KAN', 'ENGB2KOR', 'ENUS2KOR', 'LIT', 'LAT', 'MAY', 'MAR', 'NOR', 'ODI', 'PUN', 'POL', 'POR', 'B-POR', 'ROM', 'RUS', 'SLK', 'SLV', 'SPA', 'M-SPA', 'MAR', 'SWE', 'TAM', 'TEL', 'TUR', 'UKR', 'TPE'];
		$('#lang option').each(function(i) {
			if ($.inArray($(this).attr('value'), arrex) != -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	}  else if (sPart == "TV") {
		let arrtv = [ 'ARA', 'BEN', 'BUR', 'HIN', 'JPN', 'ENGB2KOR', 'KOR2ENG-GB', 'LAO', 'Main-KHM', 'Vendor-KHM', 'MAL', 'MAY', 'Malta', 'SG-CHI', 'KOR2S-CHI', 'SC2ENG', 'Ltn-SPA', 'URD', 'BOS', 'RGK', 'TUK', 'IRI', 'CNR', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'PUN' ];
		$('#lang option').each(function(i) {
			if ($.inArray($(this).attr('value'), arrtv) == -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "EBT") {
		let arrebt = [ 'ALB', 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'HIN', 'HKG', 'ENGB2KOR', 'KOR2ENG-GB', 'LAO', 'Main-KHM', 'Vendor-KHM', 'MAL', 'Malta', 'MKD', 'MON', 'SG-CHI', 'KOR2S-CHI', 'SC2ENG', 'Ltn-SPA', 'THA', 'URD', 'UZB', 'Zawgyi-BUR', 'SamsungOne-BUR', 'BOS', 'RGK', 'TUK', 'CNR', 'IRI', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
		$('#lang option').each(function(i) {
			if ($.inArray($(this).attr('value'), arrebt) == -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "MA-Device") {
		let arreMad = [ 'ARA-AS', 'ARA-EU', 'JPN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'B-POR', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR', 'BOS', 'KIR', 'RGK', 'TUK', 'CNR', 'IRI', 'MAL', 'Malta', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
		$('#lang option').each(function(i) {
			if ($.inArray($(this).attr('value'), arreMad) == -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "MA-external") {
		let arreMAex = ['ALB', 'ARA', 'ARM', 'AZE', 'BEN', 'BUL', 'BUR', 'CA-FRE', 'S-CHI', 'SG-CHI', 'TPE', 'HKG', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FAR', 'FIN', 'FRE', 'GEORGIAN', 'GER', 'GRE', 'HEB', 'HIN', 'HUN', 'IND', 'ITA', 'JPN', 'KAZ', 'Main-KHM', 'KIR', 'LAO', 'Ltn-SPA', 'LAT', 'LIT', 'MKD', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SLK', 'SLV', 'SPA', 'SWE', 'RGK', 'THA', 'TUR', 'TUK', 'UKR', 'URD', 'UZB', 'VIE'];
		$('#lang option').each(function(i) {
			if ($.inArray($(this).attr('value'), arreMAex) != -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "MA-Feature") {
		let arrefad = [ 'ARA-AS', 'ARA-EU', 'AZE', 'CA-FRE', 'JPN', 'GEORGIAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'B-POR', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR', 'BOS', 'KIR', 'RGK', 'TUK', 'CNR', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
		$('#lang option').each(function(i) {
			if ($.inArray($(this).attr('value'), arrefad) == -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "MA-AC") {
		let arrMac = [ 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAO', 'Main-KHM', 'MON', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR', 'IRI', 'MAL', 'Malta', 'BOS', 'KIR', 'RGK', 'TUK', 'CNR', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
		$('#lang option').each(function(i) {
			if ($.inArray($(this).attr('value'), arrMac) == -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "HA") {
		// let arrHa = [ 'ALB', 'ARA', 'BUL', 'B-POR', 'S-CHI', 'HKG', 'TPE', 'CRO', 'CZE', 'CA-FRE', 'DAN', 'FRE', 'DUT', 'ENGB2KOR', 'EST', 'FAR', 'FIN', 'GER', 'GRE', 'HEB', 'HUN', 'IND', 'ITA', 'KAZ', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAT', 'LIT', 'Ltn-SPA', 'MKD', 'MAL', 'Malta', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SLK', 'SLV', 'SPA', 'SWE', 'THA', 'TUR', 'UKR', 'UZB', 'VIE', 'KOR2TPE', 'IRL'];
		let arrHa = [ 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'JPN', 'LAO', 'ENUS2KOR', 'KOR2S-CHI', 'SC2ENG', 'SG-CHI', 'Main-KHM', 'Zawgyi-BUR', 'URD', 'SamsungOne-BUR', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
		$('#lang option').each(function(i) {
			if ($.inArray($(this).attr('value'), arrHa) == -1) {
				// $(this).hide();
				$(this).css('display', 'inline-block');
			} else {
				// $(this).css('display', 'inline-block');
				$(this).hide();
			}
		});
	} else {
		$('#lang option').each(function(i) {
				$(this).css('display', 'inline-block');
		});
	}
	
	var inputText = mainKeyword.replace(/\+/gi, ' ');
	mainKeyword = mainKeyword.replace(/\+/gi, ' ').replace(/\</g, '').replace(/\>/g, '');
	console.log(sPart + ";" +selectedlang + ";" + mainKeyword + ";" + sCase);
	document.getElementById("searchString").value = inputText;
	document.getElementById("lang").value = selectedlang;
	document.getElementById("part").value = sPart;
	mainKeyword = mainKeyword.replace('(', "").replace(')', '');

	if (sCase == "on") {
		console.log("대소문자 구분");
		document.getElementById("byCase").checked = true;
	} else {
		console.log("대소문자 구분 X");
		document.getElementById("byCase").checked = false;
	}

	let keyword = new RegExp('(' + mainKeyword.replace(".", "\\.") + ')', 'gi');
	console.log("json/"+ sPart + "/" + selectedlang + ".json");
	// console.log(keyword);
	$.ajax({
		dataType : "json",
		cache: false,
		url : "json/"+ sPart + "/" + selectedlang + ".json",
		success : function(data){ 
			$("#wait-container").hide();
			let html = "<table class='result'>";
			//header 만들기
			html += "<colgroup><col class='c3-1'/><col class='c3-2'/><col class='c3-3'/></colgroup><thead><tr>";
			html += "<th>Source</th>";
			html += "<th>Target: " + $('#lang option:selected').text() + "</th>";
			html += "<th>Info</th>";
			html += "</tr></thead><tbody>";
			
			$.each(data, function(key, value) {
				// console.log(key); key는 index
				let sourcText = value.ST.replace(/<\/?[A-Za-z][^>]*>/, "")
					.replace(/&lt;span class=&quot;stag&quot;&gt;/g, "")
					.replace(/&lt;img src=&quot;flag\/(\d+).png&quot;\/&gt;/g, "")
					.replace(/&lt;img src=&quot;flag\\\/(\d+).png&quot;\/&gt;/g, "").replace(/&lt;\/span&gt;/g, "")
					.replace(/&lt;span class=&quot;pic&quot;&gt;/g, "").replace(/\(/g, "").replace(/\)/g, "").replace(/&quot;/g, '"');
				// if (value.creationdate == "20210208T140711Z") {
				// 	console.log(value.ST + " - " + value.creationdate);
				// }
				let targetText = value.TT.replace(/<\/?[A-Za-z][^>]*>/, "")
					.replace(/&lt;span class=&quot;stag&quot;&gt;/g, "")
					.replace(/&lt;img src=&quot;flag\\\/(\d+).png&quot;\/&gt;/g, "").replace(/&lt;\/span&gt;/g, "")
					.replace(/&lt;span class=&quot;pic&quot;&gt;/g, "&lt;span class=&quot;pic&quot;\/&gt;");
				if (sCase == "on") { // 대소문자 구분
					// console.log("대소문자 구분 실행");
					if (sourcText.indexOf(mainKeyword) > -1 || targetText.indexOf(mainKeyword) > -1) { //검색어인 경우에만 출력한다.
						// console.log(value.ST + "\r" + value.TT);
						console.log(sourcText);
						html += "<tr>";
						// source 언어
						html += "<td class='str' ondblclick='copyCell(this)'><p style='direction:ltr'>" + value.ST
								.replace(keyword, '<mark>' + mainKeyword + '</mark>')
								.replace(/&lt;/g, '<')
								.replace(/&gt;/g, '>')
								.replace(/&quot;/g, '"').replace(/###lt;/g, '&lt;').replace(/###gt;/g, '&gt;')
								+ "</p></td>";
						// target 언어
						if (selectedlang == "ARA" || selectedlang == "ARA-AS" || selectedlang == "ARA-EU" || selectedlang == "HEB" || selectedlang == "FAR" || selectedlang == "URD") { // rtl 언어일 경우
							html += "<td class='str' ondblclick='copyCell(this)'><p class='rtl' style='direction:rtl'>"
						} else { // ltr 언어일 경우
							html += "<td class='str' ondblclick='copyCell(this)'><p style='direction:ltr'>"
						}
						
						html += targetText
								.replace(keyword, '<mark>' + mainKeyword + '</mark>')
								.replace(/&gt;/g, '>')
								.replace(/&lt;/g, '<')
								.replace(/&quot;/g, '"').replace(/###lt;/g, '&lt;').replace(/###gt;/g, '&gt;')
								+ "</p></td>"
						html += "<td><p class='info'>" + "created: " 
								+ value.creationdate.replace("T", " time: ").replace("Z", "") + " - " + value.creationid + "</p>";
						html += "<p class='info'>" + "changed: " + value.changedate.replace("T", " time: ").replace("Z", "") + " - " + value.changeid;
						html += "</p></td>";
						html += "</tr>";
					}
				} else { // 대소문자 구분 X
					// console.log("대소문자 구분 X 실행");
					if (sourcText.match(new RegExp(mainKeyword, "i")) || targetText.match(new RegExp(mainKeyword, "i"))) {
						let smatchs = sourcText.match(new RegExp(mainKeyword, "i"));
						let tmatchs = targetText.match(new RegExp(mainKeyword, "i"));
						html += "<tr>";
						// source 언어
						if (smatchs == null) {
							html += "<td class='str' ondblclick='copyCell(this)'><p style='direction:ltr'>" + value.ST
									.replace(/&lt;/g, '<')
									.replace(/&gt;/g, '>')
									.replace(/&quot;/g, '"').replace(/###lt;/g, '&lt;').replace(/###gt;/g, '&gt;')
									+ "</p></td>";
						} else {
							html += "<td class='str' ondblclick='copyCell(this)'><p style='direction:ltr'>" + value.ST
									.replace(smatchs[0], '<mark>' + smatchs[0] + '</mark>')
									.replace(/&lt;/g, '<')
									.replace(/&gt;/g, '>')
									.replace(/&quot;/g, '"').replace(/###lt;/g, '&lt;').replace(/###gt;/g, '&gt;')
									+ "</p></td>";
						}
						// target 언어
						if (selectedlang == "ARA" || selectedlang == "ARA-AS" || selectedlang == "ARA-EU" || selectedlang == "HEB" || selectedlang == "FAR" || selectedlang == "URD") { // rtl 언어일 경우
							html += "<td class='str' ondblclick='copyCell(this)'><p class='rtl' style='direction:rtl'>";
						} else { // ltr 언어일 경우
							html += "<td class='str' ondblclick='copyCell(this)'><p style='direction:ltr'>";
						}
						if (tmatchs == null) {
							html += value.TT
									.replace(/&gt;/g, '>')
									.replace(/&lt;/g, '<')
									.replace(/&quot;/g, '"').replace(/###lt;/g, '&lt;').replace(/###gt;/g, '&gt;')
									+ "</p></td>";
						} else {
							html += value.TT
									.replace(tmatchs[0], '<mark>' + tmatchs[0] + '</mark>')
									.replace(/&gt;/g, '>')
									.replace(/&lt;/g, '<')
									.replace(/&quot;/g, '"').replace(/###lt;/g, '&lt;').replace(/###gt;/g, '&gt;')
									+ "</p></td>";
						}
						
						html += "<td><p class='info'>" + "created: " 
								+ value.creationdate.replace("T", " time: ").replace("Z", "") + " - " + value.creationid + "</p>";
						html += "<p class='info'>" + "changed: " + value.changedate.replace("T", " time: ").replace("Z", "") + " - " + value.changeid;
						html += "</p></td>";
						html += "</tr>";
					}
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