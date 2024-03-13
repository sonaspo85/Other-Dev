let cURL = location.href;
let jsondb = [ 'mobis.json', 'mobis_ind.json' ]

for (var x=0;x<jsondb.length;x++) {
	let xhr = new XMLHttpRequest();
	xhr.open('GET', cURL + 'json/' + jsondb[x]);
	xhr.onload = function() {
		date = xhr.getResponseHeader('Last-Modified');
		let myUrl = xhr.responseURL;
		$('.uptodate').append('<p><b>' + myUrl.replace(cURL + 'json/', '') + "</b> - 업데이트: " + date2korType(date) + '<br/></p>');
	}
	xhr.send(null);
}

function date2korType(date) {
	let upTodate = new Date();
	upTodate = date.replace("Mon,", "월요일").replace("Tue,", "화요일").replace("Wed,", "수요일").replace("Thu,", "목요일").replace("Fri,", "금요일").replace("Sat,", "토요일").replace("Sun,", "일요일").replace("Jan", "01").replace("Feb", "02").replace("Mar", "03").replace("Apr", "04").replace("May", "05").replace("Jun", "06").replace("Jul", "07").replace("Aug", "08").replace("Sep", "09").replace("Oct", "10").replace("Nov", "11").replace("Dec", "11").replace("Dec", "12").replace(" GMT", "");
	upTodate = upTodate.replace(/([ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{3})\s(\d\d)\s(\d\d)\s(\d\d\d\d)/g, "$4-$3-$2 $1");
	let time = upTodate.match(new RegExp(/(\d\d):(\d\d):(\d\d)/, "i"));
	let hour = time[1]*1;
	let min = time[2];
	let korDate = upTodate.replace(/(\d\d):(\d\d):(\d\d)/g, "") + hour + ":" + min
	return korDate;
}

$(document).ready(function () {
	$('#region').append(
		'<option value="int">내수</option>' +
		'<option value="usa">북미</option>' +
		'<option value="mid">중동</option>' +
		'<option value="ltn">브라질/멕시코</option>' +
		'<option value="gen">일반</option>' +
		'<option value="pio">인도(PIO)</option>' +
		'<option value="chi">중국</option>' +
		'<option value="jpn">일본</option>' +
		'<option value="ind">인도</option>' +
		'<option value="inn">인도네시아</option>'
	);
	$('#lang').append(
		'<option value="ID">ID</option>' +
		'<option value="KOR">국어</option>' +
		'<option value="ENG">영어</option>' +
		'<option value="SC_CHI">중국어</option>' +
		'<option value="JPN">일본어</option>'
	);
	setTimeout(function () {
		$('.uptodate').append('<p class="bottom">※ 셀을 더블 클릭하면 해당 셀의 내용을 클립보드로 복사합니다. ※ <br/>HMI Table 다운로드 경로 : /mc/Hyundai/Source/WIDE 표준매뉴얼/#HMI_Match#/#HMI_Table#</p>')
	}, 200);
});