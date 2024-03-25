$(document).ready(function() {
	if (sPart == "MOBIS") {
		let arr = ['ARM', 'ARA', 'BUL', 'BEN', 'S-CHI', 'KOR2TPE', 'EST', 'FRE', 'CA-FRE', 'GUJ', 'HIN', 'IND', 'IRL', 'JPN', 'KAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB' ,'KOR2ENG-US', 'LAT', 'LIT', 'MAY', 'ODI', 'PUN', 'KOR2S-CHI', 'SPA', 'M-SPA', 'MAR', 'TAM', 'TEL'];
		$('#part').each(function(i) {
			if ($.inArray($(this).attr('value'), arr) != -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} if (sPart == "MOBIS-CCNC") {
		let arrcc = ['ARM', 'ARA', 'BUL', 'BEN', 'S-CHI', 'SG-CHI', 'TPE', 'KOR2TPE', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FIN', 'FRE', 'CA-FRE', 'GER', 'GRE', 'GUJ', 'HEB', 'HIN', 'HUN', 'IND', 'IRL', 'ITA', 'JPN', 'KAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAT', 'LIT', 'MAY', 'MAL', 'MAR', 'NOR', 'ODI', 'POL', 'POR', 'B-POR', 'ROM', 'RUS', 'KOR2S-CHI', 'SLK', 'SLV', 'MAR', 'SPA', 'M-SPA', 'SWE', 'TAM', 'TEL', 'TUR', 'UKR'];
		$('#part').each(function(i) {
			if ($.inArray($(this).attr('value'), arrcc) != -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} if (sPart == "MOBIS-external") {
		let arrex = ['ARA', 'BUL', 'BEN', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FIN', 'FRE', 'CA-FRE', 'GER', 'GRE', 'GUJ', 'HEB', 'HIN', 'HUN', 'IND', 'ITA', 'KAN', 'ENGB2KOR', 'ENUS2KOR', 'LIT', 'LAT', 'MAY', 'MAR', 'NOR', 'ODI', 'PUN', 'POL', 'POR', 'B-POR', 'ROM', 'RUS', 'SLK', 'SLV', 'SPA', 'M-SPA', 'MAR', 'SWE', 'TAM', 'TEL', 'TUR', 'UKR', 'TPE'];
		$('#part').each(function(i) {
			if ($.inArray($(this).attr('value'), arrcc) != -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "TV") {
		let arrtv = [ 'ARA', 'BEN', 'BUR', 'HIN', 'JPN', 'ENGB2KOR', 'KOR2ENG-GB', 'LAO', 'Main-KHM', 'SG-CHI', 'KOR2S-CHI', 'SC2ENG', 'Ltn-SPA', 'URD', 'KIR'];
		$('#part').each(function(i) {
			if ($.inArray($(this).attr('value'), arrtv) == -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "EBT") {
		let arrebt = [ 'ALB', 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'HIN', 'HKG', 'ENGB2KOR', 'KOR2ENG-GB', 'LAO', 'Main-KHM', 'Vendor-KHM', 'MAL', 'Malta', 'MKD', 'MON', 'SG-CHI', 'KOR2S-CHI', 'SC2ENG', 'Ltn-SPA', 'THA', 'URD', 'UZB', 'Zawgyi-BUR', 'SamsungOne-BUR' 'KIR'];
		$('#part').each(function(i) {
			if ($.inArray($(this).attr('value'), arrebt) == -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "MA-Device") {
		let arreMad = [ 'ARA-AS', 'ARA-EU', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'B-POR', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR' ];
		$('#part').each(function(i) {
			if ($.inArray($(this).attr('value'), arreMad) == -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} if (sPart == "MA-external") {
		let arreMAex = ['ALB', 'ARA', 'ARM', 'AZE', 'BEN', 'BUL', 'BUR', 'CA-FRE', 'S-CHI', 'SG-CHI', 'TPE', 'HKG', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FAR', 'FIN', 'FRE', 'GEORGIAN', 'GER', 'GRE', 'HEB', 'HIN', 'HUN', 'IND', 'ITA', 'JPN', 'KAZ', 'Main-KHM', 'KIR', 'LAO', 'Ltn-SPA', 'LAT', 'LIT', 'MKD', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SLK', 'SLV', 'SPA', 'SWE', 'RGK', 'THA', 'TUR', 'TUK', 'UKR', 'URD', 'UZB', 'VIE'];
		$('#part').each(function(i) {
			if ($.inArray($(this).attr('value'), arreMAex) != -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "MA-Feature") {
		let arreMad = [ 'ARA-AS', 'ARA-EU', 'AZE', 'CA-FRE', 'JPN', 'GEORGIAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'B-POR', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR', 'BOS', 'KIR', 'RGK', 'TUK', 'CNR' ];
		$('#part').each(function(i) {
			if ($.inArray($(this).attr('value'), arreMad) == -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	} else if (sPart == "MA-AC") {
		let arrMac = [ 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAO', 'Main-KHM', 'MON', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR' ];
		$('#part').each(function(i) {
			if ($.inArray($(this).attr('value'), arrMac) == -1) {
				$(this).css('display', 'inline-block');
			} else {
				$(this).hide();
			}
		});
	}  else if (sPart == "HA") {
		let arrHa = [ 'ALB', 'ARA', 'BUL', 'B-POR', 'S-CHI', 'HKG', 'TPE', 'CRO', 'CZE', 'CA-FRE', 'DAN', 'FRE', 'DUT', 'ENGB2KOR', 'EST', 'FAR', 'FIN', 'GER', 'GRE', 'HEB', 'HUN', 'IND', 'ITA', 'KAZ', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAT', 'LIT', 'Ltn-SPA', 'MKD', 'MAL', 'Malta', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SLK', 'SLV', 'SPA', 'SWE', 'THA', 'TUR', 'UKR', 'UZB', 'VIE' ];
		$('#part').each(function(i) {
			if ($.inArray($(this).attr('value'), arrHa) == -1) {
				$(this).hide();
			} else {
				$(this).css('display', 'inline-block');
			}
		});
	} else {
		$('#part').each(function(i) {
				$(this).css('display', 'inline-block');
		});
	}
});