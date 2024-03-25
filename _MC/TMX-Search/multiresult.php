<?php
	$url = $_POST;
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>TMX Search</title>
	<script src="js/jquery-3.0.0.js"></script>
	<script src="js/multiSearch.js"></script>
	<script src="js/tableToExcel.js"></script>
	<script src="js/tableToExcel.js.map"></script>
	<script type="text/javascript">
		var post = '<?php echo json_encode($url);?>';
		console.log(post);

		var myData = $.parseJSON(post);
		console.log(myData.part + ":" + myData.lang + ":" + myData.searchString);
		console.log(myData.lang.length);
		// 파트, 언어, 검색어 옵션 가져오기
		$(document).ready(function() {
			document.getElementById("part").value = myData.part;
			document.getElementById("searchString").value = myData.searchString;
			$(".multiselect").each(function() {
				var checked = $(this).find("input:checkbox");
				checked.each(function() {
					if ($.inArray($(this).val(), myData.lang) != -1 ) {
						$(this).prop("checked", true);
						$(this).parent().addClass("multiselect-on");
					}
				});
			});
			let langCount = myData.lang.length;
			let sPart = myData.part;
			let selectedlang;
			let searchString = myData.searchString;
			console.log(searchString)
			let html = "<table class='result-multi' data-cols-width='20,150'>";
			html += "<tr><th>Source</th>";
			html += "<th>" + searchString.replace(/\</g, "&lt;").replace(/\>/g, "&gt;") + "</th>";
			html += "</tr>";
			for (let i=0;i<langCount;i++) {
				html += "<tr><td>" + myData.lang[i] + "</td><td class='multi' id='" + myData.lang[i] + "' data-a-wrap='true' data-a-v='top'>" + "</td></tr>"
			}
			html += "</table>"
			$("#result-multi").append(html);

			for (let j=0;j<langCount;j++) {
				selectedlang = myData.lang[j];
				html += "<tr><td>" + selectedlang + "</td><td>";
				let targetCont = "";
				$.ajax({
					dataType : "json",
					cache: false,
					url : "json/"+ sPart + "/" + selectedlang + ".json",
					success : function(data){
						$("#wait-container").hide();
						$.each(data, function(key, value) {
							// 괄호를 날려서 검색...
							let sourcText = value.ST.replace(/<\/?[A-Za-z][^>]*>/, "")
								.replace(/&lt;span class=&quot;stag&quot;&gt;/g, "")
								.replace(/&lt;img src=&quot;flag\/(\d+).png&quot;\/&gt;/g, "").replace(/&lt;\/span&gt;/g, "")
								.replace(/&lt;img src=&quot;flag\\\/(\d+).png&quot;\/&gt;/g, "")
								.replace(/&lt;span class=&quot;pic&quot;&gt;/g, "").replace(/\(/g, "").replace(/\)/g, "")
								.replace(/\${MMI-\d{1,}\}/g, "").replace(/\$/g, "")
								.replace(/&lt;C_MMI ID\=&quot;\d{1,}&quot; Chapter\=&quot;(.+?)&quot;&gt;/g, "").replace(/&lt;\/C_MMI&gt;/g, "")
								.replace(/###lt;/g, '<').replace(/###gt;/g, '>');
							let targetText = value.TT.replace(/<\/?[A-Za-z][^>]*>/, "")
								.replace(/&lt;span class=&quot;stag&quot;&gt;/g, "")
								.replace(/&lt;img src=&quot;flag\/(\d+).png&quot;\/&gt;/g, "").replace(/&lt;\/span&gt;/g, "")
								.replace(/&lt;img src=&quot;flag\\\/(\d+).png&quot;\/&gt;/g, "")
								.replace(/&lt;span class=&quot;pic&quot;&gt;/g, "").replace(/\(/g, "").replace(/\)/g, "")
								.replace(/###lt;/g, '&lt;').replace(/###gt;/g, '&gt;');
							
							// searchString도 괄호를 제거한 후 sourceText와 일치 여부를 판단하도록 한다.
							searchString = searchString.replace(/\(|\)/g, "");
							if (sourcText.indexOf("Underside") > -1) {
								console.log("1111 " + sourcText + "::" + searchString);
							}
							if (searchString == sourcText) {
								console.log(myData.lang[j] + ":" + sourcText);
								let targetText1 = value.TT.replace(/&quot;/g, '"').replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/###lt;/g, '&lt;').replace(/###gt;/g, '&gt;');
								console.log(targetText1);
								if (myData.lang[j] == "ARA" || myData.lang[j] == "ARA-AS" || myData.lang[j] == "ARA-EU" || myData.lang[j] == "HEB" || myData.lang[j] == "FAR" || myData.lang[j] == "URD") {
									targetCont += "<p class='rtl' style='direction:rtl'>" + targetText1 + "<span class='create'>" + value.creationdate.replace("T", " time: ").replace("Z", "") + " - " + value.creationid + "</span></p><br/>";
								} else {
									targetCont += "<p>" + targetText1 + "<span class='create'>" + value.creationdate.replace("T", " time: ").replace("Z", "") + " - " + value.creationid + "</span></p><br/>";
								}
							}
						});
						
						let target = "table.result-multi #" + myData.lang[j];
						$(target).append(targetCont);
					},
					error : function(){ 
						alert("선택한 언어 " + myData.lang[j] + "에는 해당하는 번역 데이터가 없습니다.");
					}
				});
			}
			if (sPart == "MOBIS") {
				let arr = ['ARM', 'ARA', 'BUL', 'BEN', 'S-CHI', 'KOR2TPE', 'EST', 'FRE', 'CA-FRE', 'GUJ', 'HIN', 'IND', 'IRL', 'JPN', 'KAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB' ,'KOR2ENG-US', 'LAT', 'LIT', 'MAY', 'ODI', 'PUN', 'KOR2S-CHI', 'M-SPA', 'TAM', 'TEL'];
				$('.multiselect > label > input').each(function(i) {
					if ($.inArray($(this).attr('value'), arr) != -1) {
						$(this).parent('label').css('display', 'block');
					} else {
						$(this).parent('label').hide();
					}
				});
			} else if (sPart == "MOBIS-CCNC") {
				let arrcc = ['ARM', 'ARA', 'BEN', 'S-CHI', 'SG-CHI', 'TPE', 'KOR2TPE', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FIN', 'FRE', 'CA-FRE', 'GER', 'GRE', 'GUJ', 'HEB', 'HIN', 'HUN', 'IND', 'IRL', 'ITA', 'JPN', 'KAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAT', 'LIT', 'MAY', 'MAL', 'MAR', 'NOR', 'ODI', 'POL', 'POR', 'B-POR', 'ROM', 'RUS', 'KOR2S-CHI', 'SLK', 'SLV', 'M-SPA', 'SWE', 'TAM', 'TEL', 'TUR', 'UKR'];
				$('.multiselect > label > input').each(function(i) {
					if ($.inArray($(this).attr('value'), arrcc) != -1) {
						$(this).parent('label').css('display', 'block');
					} else {
						$(this).parent('label').hide();
					}
				});
			} else if (sPart == "MOBIS-external") {
				let arrex = ['ARA', 'BUL', 'BEN', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FIN', 'FRE', 'CA-FRE', 'GER', 'GRE', 'GUJ', 'HEB', 'HIN', 'HUN', 'IND', 'ITA', 'KAN', 'ENGB2KOR', 'LIT', 'LAT', 'MAY', 'MAR', 'NOR', 'ODI', 'PUN', 'POL', 'POR', 'B-POR', 'ROM', 'RUS', 'SLK', 'SLV', 'SPA', 'M-SPA', 'SWE', 'TAM', 'TEL', 'TUR', 'UKR', 'TPE'];
				$('.multiselect > label > input').each(function(i) {
					if ($.inArray($(this).attr('value'), arrex) != -1) {
						$(this).parent('label').css('display', 'block');
					} else {
						$(this).parent('label').hide();
					}
				});
			} else if (sPart == "TV") {
				let arrtv = [ 'ARA', 'BEN', 'BUR', 'HIN', 'JPN', 'ENGB2KOR', 'KOR2ENG-GB', 'LAO', 'Main-KHM', 'Vendor-KHM', 'MAL', 'Malta', 'SG-CHI', 'KOR2S-CHI', 'SC2ENG', 'Ltn-SPA', 'URD', 'IRI', 'MAL', 'Malta', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
				$('.multiselect > label > input').each(function(i) {
					if ($.inArray($(this).attr('value'), arrtv) == -1) {
						$(this).parent('label').css('display', 'block');
					} else {
						$(this).parent('label').hide();
					}
				});
			} else if (sPart == "EBT") {
				let arrebt = [ 'ALB', 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'HIN', 'HKG', 'ENGB2KOR', 'KOR2ENG-GB', 'LAO', 'Main-KHM', 'Vendor-KHM', 'MAL', 'Malta', 'MKD', 'MON', 'SG-CHI', 'KOR2S-CHI', 'SC2ENG', 'Ltn-SPA', 'THA', 'URD', 'UZB', 'Zawgyi-BUR', 'SamsungOne-BUR', 'IRI', 'MAL', 'Malta', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
				$('.multiselect > label > input').each(function(i) {
					if ($.inArray($(this).attr('value'), arrebt) == -1) {
						$(this).parent('label').css('display', 'block');
					} else {
						$(this).parent('label').hide();
					}
				});
			} else if (sPart == "MA-Device") {
				let arreMad = [ 'ARA-AS', 'ARA-EU', 'JPN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'B-POR', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR', 'IRI', 'MAL', 'Malta', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
				$('.multiselect > label > input').each(function(i) {
					if ($.inArray($(this).attr('value'), arreMad) == -1) {
						$(this).parent('label').css('display', 'block');
					} else {
						$(this).parent('label').hide();
					}
				});
			} else if (sPart == "MA-external") {
				let arrex = ['ALB', 'ARA', 'ARM', 'AZE', 'BEN', 'BUL', 'BUR', 'CA-FRE', 'S-CHI', 'SG-CHI', 'TPE', 'HKG', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FAR', 'FIN', 'FRE', 'GEORGIAN', 'GER', 'GRE', 'HEB', 'HIN', 'HUN', 'IND', 'ITA', 'JPN', 'KAZ', 'Main-KHM', 'KIR', 'LAO', 'Ltn-SPA', 'LAT', 'LIT', 'MKD', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SLK', 'SLV', 'SPA', 'SWE', 'RGK', 'THA', 'TUR', 'TUK', 'UKR', 'URD', 'UZB', 'VIE'];
				$('.multiselect > label > input').each(function(i) {
					if ($.inArray($(this).attr('value'), arrex) != -1) {
						$(this).parent('label').css('display', 'block');
					} else {
						$(this).parent('label').hide();
					}
				});
			} else if (sPart == "MA-Feature") {
				let arreMad = [ 'ARA-AS', 'ARA-EU', 'AZE', 'CA-FRE', 'JPN', 'GEORGIAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'B-POR', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR', 'BOS', 'KIR', 'RGK', 'TUK', 'CNR', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
				$('.multiselect > label > input').each(function(i) {
					if ($.inArray($(this).attr('value'), arreMad) == -1) {
						$(this).parent('label').css('display', 'block');
					} else {
						$(this).parent('label').hide();
					}
				});
			} else if (sPart == "MA-AC") {
				let arrMac = [ 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAO', 'Main-KHM', 'MON', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR', 'IRI', 'MAL', 'Malta', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
				$('.multiselect > label > input').each(function(i) {
					if ($.inArray($(this).attr('value'), arrMac) == -1) {
						$(this).parent('label').css('display', 'block');
					} else {
						$(this).parent('label').hide();
					}
				});
			} else if (sPart == "HA") {
				let arrMac = [ 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'JPN', 'LAO', 'ENUS2KOR', 'KOR2S-CHI', 'SC2ENG', 'SG-CHI', 'Main-KHM', 'Zawgyi-BUR', 'URD', 'SamsungOne-BUR', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
				$('.multiselect > label > input').each(function(i) {
					if ($.inArray($(this).attr('value'), arrMac) == -1) {
						$(this).parent('label').css('display', 'block');
					} else {
						$(this).parent('label').hide();
					}
				});
			} else {
				$('.multiselect > label > input').each(function(i) {
						$(this).css('display', 'block');
				});
			}
		});
		function exportReportToExcel() {
			$(".create").remove();
			let table = document.getElementsByClassName("result-multi"); // you can use document.getElementById('tableId') as well by providing id to the table tag
			// table = table.replace(/\<br\/\>/g, "\r\n");
			TableToExcel.convert(table[0], { // html code may contain multiple tables so here we are refering to 1st table tag
			name: `export.xlsx`, // fileName you could use any name
			sheet: {
				name: 'Sheet 1' // sheetName
			}
			});
		}
	</script>
	<link type="text/css" rel="stylesheet" href="css/style.css"/>
</head>
<body>
<body>
	<header></header>
	<div class='view'>
		<input type="checkbox" name="viewoption" id="textonly" onclick="selectOnlyThis(this)"/>
		<label for="textonly">Text Only</label>
		<input type="checkbox" name="viewoption" id="simpletag" onclick="selectOnlyThis(this)"/>
		<label for="simpletag">Simple Tag</label>
		<input type="checkbox" name="viewoption" id="fulltag" onclick="selectOnlyThis(this)"/>
		<label for="fulltag">Full Tag</label>
		<div class="gototop1" style="cursor:pointer;" onclick="window.scrollTo(0,0);">TOP</div>
		<div class="gototophome"><a href="multisearch.html">초기 화면으로 이동</a></div>
		<div class="help">텍스트를 드래그한 후에 Ctrl + C 키를 눌러 텍스트를 복사할 수 있습니다.</div>
	</div>
	<div class="multi-searchForm" id="search">
		<form id="tmxSearch" action="multiresult.php" method="post" autocomplete="off">
			<!-- <input name="byCase" id="byCase" type="checkbox" checked/><lable for="byCase">대소문자 구분</lable> -->
			<div class="condition">
				<div class="part">
					<select name="part" id="part">
						<option lang="defalut" value="defalut" selected>파트를 선택하세요.</option>
						<option lang="EBT" value="EBT">EBT</option>
						<option lang="TV" value="TV">TV</option>
						<option lang="MOBIS" value="MOBIS">MOBIS</option>
						<option lang="MOBIS-CCNC" value="MOBIS-CCNC">MOBIS-CCNC</option>
						<option lang="MOBIS-external" value="MOBIS-external">MOBIS-타사</option>
						<option lang="MA-Device" value="MA-Device">MA-Device</option>
						<option lang="MA-AC" value="MA-AC">MA-AC</option>
						<option lang="MA-Feature" value="MA-Feature">MA-Feature</option>
						<option lang="HA" value="HA">HA</option>
						<!-- <option lang="HY-Auto" value="HY-Auto">HY-Auto</option> -->
					</select>
				</div>
				<div class="select"><a href="javascript:selectAll()">전체 선택</a> / <a href="javascript:UnselectAll()">해제</a></div>
				<div name="lang" id="lang" class="multiselect">
				<label><input type="checkbox" name="lang[]" value="ALB"/>Albanian</label>
					<label><input type="checkbox" name="lang[]" value="ARA"/>Arabic</label>
					<label><input type="checkbox" name="lang[]" value="ARA-AS"/>Arabic(Asia)</label>
					<label><input type="checkbox" name="lang[]" value="ARA-EU"/>Arabic(EU)</label>
					<label><input type="checkbox" name="lang[]" value="AZE"/>Azerbaijani</label>
					<label><input type="checkbox" name="lang[]" value="BEN"/>Bengali</label>
					<label><input type="checkbox" name="lang[]" value="BUL"/>Bulgarian</label>
					<label><input type="checkbox" name="lang[]" value="Zawgyi-BUR"/>Burmese(Zawgyi)</label>
					<label><input type="checkbox" name="lang[]" value="SamsungOne-BUR"/>Burmese(SamsungOne)</label>
					<label><input type="checkbox" name="lang[]" value="S-CHI"/>Chinese(중국)</label>
					<label><input type="checkbox" name="lang[]" value="HKG"/>Chinese(홍콩)</label>
					<label><input type="checkbox" name="lang[]" value="SG-CHI"/>Chinese(싱가폴)</label>
					<label><input type="checkbox" name="lang[]" value="TPE"/>Chinese(대만)</label>
					<label><input type="checkbox" name="lang[]" value="CRO"/>Croatian</label>
					<label><input type="checkbox" name="lang[]" value="CZE"/>Czech</label>
					<label><input type="checkbox" name="lang[]" value="DAN"/>Danish</label>
					<label><input type="checkbox" name="lang[]" value="DUT"/>Dutch</label>
					<label><input type="checkbox" name="lang[]" value="EST"/>Estonian</label>
					<label><input type="checkbox" name="lang[]" value="FAR"/>Farsi</label>
					<label><input type="checkbox" name="lang[]" value="FIN"/>Finnish</label>
					<label><input type="checkbox" name="lang[]" value="FRE"/>French</label>
					<label><input type="checkbox" name="lang[]" value="CA-FRE"/>French(캐나다)</label>
					<label><input type="checkbox" name="lang[]" value="GEORGIAN"/>Georgian</label>
					<label><input type="checkbox" name="lang[]" value="GER"/>German</label>
					<label><input type="checkbox" name="lang[]" value="GRE"/>Greek</label>
					<label><input type="checkbox" name="lang[]" value="GUJ"/>Gujarati</label>
					<label><input type="checkbox" name="lang[]" value="HEB"/>Hebrew</label>
					<label><input type="checkbox" name="lang[]" value="HIN"/>Hindi</label>
					<label><input type="checkbox" name="lang[]" value="HUN"/>Hungarian</label>
					<label><input type="checkbox" name="lang[]" value="IND"/>Indonesian(인도네시아)</label>
					<label><input type="checkbox" name="lang[]" value="IRI"/>Irish(Ireland)</label>
					<label><input type="checkbox" name="lang[]" value="ITA"/>Italian</label>
					<label><input type="checkbox" name="lang[]" value="JPN"/>Japanese</label>
					<label><input type="checkbox" name="lang[]" value="KAN"/>Kannada</label>
					<label><input type="checkbox" name="lang[]" value="KAZ"/>Kazakh</label>
					<label><input type="checkbox" name="lang[]" value="ENGB2KOR"/>English(GB)2Korean</label>
					<label><input type="checkbox" name="lang[]" value="ENUS2KOR"/>English(US)2Korean</label>
					<label><input type="checkbox" name="lang[]" value="KOR2ENG-GB"/>Korean2English(GB)</label>
					<label><input type="checkbox" name="lang[]" value="KOR2ENG-US"/>Korean2English(US)</label>
					<label><input type="checkbox" name="lang[]" value="LAO"/>Lao</label>
					<label><input type="checkbox" name="lang[]" value="LAT"/>Latvian</label>
					<label><input type="checkbox" name="lang[]" value="LIT"/>Lithuanian</label>
					<label><input type="checkbox" name="lang[]" value="Main-KHM"/>Khmer</label>
					<label><input type="checkbox" name="lang[]" value="MAL"/>Malaysia</label>
					<label><input type="checkbox" name="lang[]" value="MAY"/>Malayalam</label>
					<label><input type="checkbox" name="lang[]" value="MAR"/>Marathi</label>
					<label><input type="checkbox" name="lang[]" value="Malta"/>Maltese(Malta)</label>
					<label><input type="checkbox" name="lang[]" value="MKD"/>Macedonian</label>
					<label><input type="checkbox" name="lang[]" value="MON"/>Mongolian</label>
					<label><input type="checkbox" name="lang[]" value="NOR"/>Norwegian</label>
					<label><input type="checkbox" name="lang[]" value="BUR"/>Myanmar</label>
					<label><input type="checkbox" name="lang[]" value="ODI"/>Odia</label>
					<label><input type="checkbox" name="lang[]" value="POL"/>Polish</label>
					<label><input type="checkbox" name="lang[]" value="POR"/>Portuguese</label>
					<label><input type="checkbox" name="lang[]" value="PUN"/>Punjabi</label>
					<label><input type="checkbox" name="lang[]" value="B-POR"/>Portuguese(브라질)</label>
					<label><input type="checkbox" name="lang[]" value="ROM"/>Romanian</label>
					<label><input type="checkbox" name="lang[]" value="RUS"/>Russian</label>
					<label><input type="checkbox" name="lang[]" value="SER"/>Serbian</label>
					<label><input type="checkbox" name="lang[]" value="KOR2S-CHI"/>Korean2Chinese(중국)</label>
					<label><input type="checkbox" name="lang[]" value="SC2ENG"/>Chinese(S)2English</label>
					<label><input type="checkbox" name="lang[]" value="SLK"/>SlovaK</label>
					<label><input type="checkbox" name="lang[]" value="SLV"/>Slovenian</label>
					<label><input type="checkbox" name="lang[]" value="SPA"/>Spanish</label>
					<label><input type="checkbox" name="lang[]" value="M-SPA"/>Spanish(멕시코)</label>
					<label><input type="checkbox" name="lang[]" value="Ltn-SPA"/>Spanish(라틴)</label>
					<label><input type="checkbox" name="lang[]" value="SWE"/>Swedish</label>
					<label><input type="checkbox" name="lang[]" value="TAM"/>Tamil</label>
					<label><input type="checkbox" name="lang[]" value="TEL"/>Telugu</label>
					<label><input type="checkbox" name="lang[]" value="THA"/>Thai</label>
					<label><input type="checkbox" name="lang[]" value="TUR"/>Turkish</label>
					<label><input type="checkbox" name="lang[]" value="UKR"/>Ukrainian</label>
					<label><input type="checkbox" name="lang[]" value="URD"/>Urdu</label>
					<label><input type="checkbox" name="lang[]" value="UZB"/>Uzbek</label>
					<label><input type="checkbox" name="lang[]" value="VIE"/>Vietnamese</label>
				</div>
			</div>
			<div class="input_text">
				<input name="searchString" id="searchString" type="text"/>
				<input type="submit" value="검색" />
			</div>
		</form>
	</div>
	<div id="wait-container">
		잠시만 기다려 주세요...
	</div>
	<div id="result-multi">
	<p><button id="btnExport" onclick="exportReportToExcel(this)">Export To Excel</button></p>
	</div>
	<div class="gototop2" style="cursor:pointer;" onclick="window.scrollTo(0,0);">TOP</div>
</body>
</html>



