$(document).ready(function() {
	$('#part').on('change', function(e) {
		if ($(this).val() == "MOBIS") {
			let arr = [ 'ALB', 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUL', 'BUR', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FAR', 'FIN', 'GEORGIAN', 'GER', 'GRE', 'HEB', 'HIN', 'HKG', 'HUN', 'IND', 'ITA', 'JPN', 'KAZ', 'LAO', 'LAT', 'LIT', 'Main-KHM', 'Vendor-KHM', 'MAL', 'Malta', 'MKD', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SG-CHI', 'SC2ENG', 'SLK', 'SLV', 'SPA', 'Ltn-SPA', 'SWE', 'THA', 'TPE', 'TUR', 'UKR', 'URD', 'UZB', 'VIE', 'Zawgyi-BUR', 'Noto-BUR', 'MSPA' ];
			$('#lang option').each(function(i) {
				if ($.inArray($(this).attr('value'), arr) == -1) {
					$(this).css('display', 'inline-block');
				} else {
					$(this).hide();
				}
			});
		} else if ($(this).val() == "TV") {
			let arrtv = [ 'ARA', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'HIN', 'JPN', 'ENGB2KOR', 'KOR2ENG-GB', 'LAO', 'Main-KHM', 'Vendor-KHM', 'MAL', 'Malta', 'SG-CHI', 'KOR2S-CHI', 'SC2ENG', 'Ltn-SPA', 'URD' ];
			$('#lang option').each(function(i) {
				if ($.inArray($(this).attr('value'), arrtv) == -1) {
					$(this).css('display', 'inline-block');
				} else {
					$(this).hide();
				}
			});
		} else if ($(this).val() == "EBT") {
			let arrebt = [ 'ALB', 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'HIN', 'HKG', 'ENGB2KOR', 'KOR2ENG-GB', 'LAO', 'Main-KHM', 'Vendor-KHM', 'MAL', 'Malta', 'MKD', 'MON', 'SG-CHI', 'KOR2S-CHI', 'SC2ENG', 'Ltn-SPA', 'THA', 'URD', 'UZB', 'Zawgyi-BUR', 'Noto-BUR' ];
			$('#lang option').each(function(i) {
				if ($.inArray($(this).attr('value'), arrebt) == -1) {
					$(this).css('display', 'inline-block');
				} else {
					$(this).hide();
				}
			});
		} else if ($(this).val() == "MA-Device") {
			let arreMad = [ 'ARA-AS', 'ARA-EU', 'JPN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'B-POR', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'Noto-BUR' ];
			$('#lang option').each(function(i) {
				if ($.inArray($(this).attr('value'), arreMad) == -1) {
					$(this).css('display', 'inline-block');
				} else {
					$(this).hide();
				}
			});
		} else if ($(this).val() == "MA-AC") {
			let arrMac = [ 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAO', 'Main-KHM', 'MON', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'Noto-BUR' ];
			$('#lang option').each(function(i) {
				if ($.inArray($(this).attr('value'), arrMac) == -1) {
					$(this).css('display', 'inline-block');
				} else {
					$(this).hide();
				}
			});
		} else {
			$('#lang option').each(function(i) {
					$(this).css('display', 'inline-block');
			});
		}
	});
});

