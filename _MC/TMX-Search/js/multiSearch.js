jQuery.fn.multiselect = function() {
    $(this).each(function() {
        var checkboxes = $(this).find("input:checkbox");
        checkboxes.each(function() {
            var checkbox = $(this);
            // Highlight pre-selected checkboxes
            if (checkbox.prop("checked"))
                checkbox.parent().addClass("multiselect-on");
 
            // Highlight checkboxes that the user selects
            checkbox.click(function() {
                if (checkbox.prop("checked"))
                    checkbox.parent().addClass("multiselect-on");
                else
                    checkbox.parent().removeClass("multiselect-on");
            });
        });
    });
};

$(function() {
	$(".multiselect").multiselect();
});

$('form').submit(function() {
	var selArr = [];
	$('input:checked[name=lang[]]').each(function() {
		selArr.push($(this).val());
	});
	
	$('#lang').val(selArr.join(';'));

	return false
})

function selectOnlyThis(id){
	let myCheckbox = document.getElementsByName("viewoption");
	Array.prototype.forEach.call(myCheckbox,function(el){
	  el.checked = false;
	});
	id.checked = true;
}

function selectAll() {
	$(".multiselect > label:visible > input").each(function(i) {
		$(this).prop('checked', true);
		$(this).parent('label').addClass('multiselect-on')
	});
}

function UnselectAll() {
	$('.multiselect > label > input').each(function(i) {
		$(this).prop('checked', false);
		$(this).parent('label').removeClass('multiselect-on')
	});
}

$(document).ready(function() {
	$('#part').on('change', function(e) {
		if ($(this).val() == "MOBIS") {
			// let arr = [ 'ALB', 'ARA-AS', 'ARA-EU', 'AZE', 'BUL', 'BUR', 'CRO', 'CZE', 'DAN', 'DUT', 'FAR', 'FIN', 'GEORGIAN', 'GER', 'GRE', 'HEB', 'HKG', 'HUN', 'ITA', 'JPN', 'KAZ', 'LAO', 'Main-KHM', 'MKD', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SG-CHI', 'SC2ENG', 'SLK', 'SLV', 'SPA', 'Ltn-SPA', 'SWE', 'THA', 'TPE', 'TUR', 'UKR', 'URD', 'UZB', 'VIE', 'Zawgyi-BUR', 'SamsungOne-BUR', 'IRI', 'MAL', 'Malta' ];
			let arr = ['ARM', 'ARA', 'BUL', 'BEN', 'S-CHI', 'KOR2TPE', 'EST', 'FRE', 'CA-FRE', 'GUJ', 'HIN', 'IND', 'IRL', 'JPN', 'KAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB' ,'KOR2ENG-US', 'LAT', 'LIT', 'MAY', 'ODI', 'PUN', 'KOR2S-CHI', 'SPA', 'M-SPA',, 'MAR', 'TAM', 'TEL'];
			$('.multiselect > label > input').each(function(i) {
				$(this).prop('checked', false);
				$(this).parent('label').removeClass('multiselect-on')
				if ($.inArray($(this).attr('value'), arr) != -1) {
					$(this).parent('label').css('display', 'block');
				} else {
					$(this).parent('label').hide();
				}
			});
		} else if ($(this).val() == "MOBIS-CCNC") {
			// let arrcc = [ 'ALB', 'ARA-AS', 'ARA-EU', 'AZE', 'BUR', 'EST', 'FAR', 'GEORGIAN', 'HKG', 'KAZ', 'LAO', 'Main-KHM', 'Vendor-KHM', 'Malta', 'MKD', 'MON', 'SER', 'SC2ENG', 'Ltn-SPA', 'THA', 'URD', 'UZB', 'VIE', 'Zawgyi-BUR', 'SamsungOne-BUR', 'BOS', 'KIR', 'RGK', 'TUK', 'CNR' ];
			let arrcc = ['ARM', 'ARA', 'BUL', 'BEN', 'S-CHI', 'SG-CHI', 'TPE', 'KOR2TPE', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FIN', 'FRE', 'CA-FRE', 'GER', 'GRE', 'GUJ', 'HEB', 'HIN', 'HUN', 'IND', 'IRL', 'ITA', 'JPN', 'KAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAT', 'LIT', 'MAY', 'MAL', 'MAR', 'NOR', 'ODI', 'POL', 'POR', 'B-POR', 'ROM', 'RUS', 'KOR2S-CHI', 'SLK', 'SLV', 'SPA', 'M-SPA', 'MAR', 'SWE', 'TAM', 'TEL', 'TUR', 'UKR'];
			$('.multiselect > label > input').each(function(i) {
				$(this).prop('checked', false);
				$(this).parent('label').removeClass('multiselect-on')
				if ($.inArray($(this).attr('value'), arrcc) != -1) {
					$(this).parent('label').css('display', 'block');
				} else {
					$(this).parent('label').hide();
				}
			});
		} else if ($(this).val() == "MOBIS-external") {
			let arrex = ['ARA', 'BUL', 'BEN', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FIN', 'FRE', 'CA-FRE', 'GER', 'GRE', 'GUJ', 'HEB', 'HIN', 'HUN', 'IND', 'ITA', 'KAN', 'ENGB2KOR', 'ENUS2KOR', 'LIT', 'LAT', 'MAY', 'MAR', 'NOR', 'ODI', 'PUN', 'POL', 'POR', 'B-POR', 'ROM', 'RUS', 'SLK', 'SLV', 'SPA', 'M-SPA', 'MAR', 'SWE', 'TAM', 'TEL', 'TUR', 'UKR', 'TPE'];
			$('.multiselect > label > input').each(function(i) {
				$(this).prop('checked', false);
				$(this).parent('label').removeClass('multiselect-on')
				if ($.inArray($(this).attr('value'), arrex) != -1) {
					$(this).parent('label').css('display', 'block');
				} else {
					$(this).parent('label').hide();
				}
			});
		} else if ($(this).val() == "TV") {
			let arrtv = [ 'ARA', 'BEN', 'BUR', 'HIN', 'JPN', 'ENGB2KOR', 'KOR2ENG-GB', 'LAO', 'Main-KHM', 'Vendor-KHM', 'MAL', 'Malta', 'SG-CHI', 'KOR2S-CHI', 'SC2ENG', 'Ltn-SPA', 'URD', 'IRI', 'MAL', 'Malta', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN', 'KIR'];
			$('.multiselect > label > input').each(function(i) {
				$(this).prop('checked', false);
				$(this).parent('label').removeClass('multiselect-on')
				if ($.inArray($(this).attr('value'), arrtv) == -1) {
					$(this).parent('label').css('display', 'block');
				} else {
					$(this).parent('label').hide();
				}
			});
		} else if ($(this).val() == "EBT") {
			let arrebt = [ 'ALB', 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'HIN', 'HKG', 'ENGB2KOR', 'KOR2ENG-GB', 'LAO', 'Main-KHM', 'Vendor-KHM', 'MAL', 'Malta', 'MKD', 'MON', 'SG-CHI', 'KOR2S-CHI', 'SC2ENG', 'Ltn-SPA', 'THA', 'URD', 'UZB', 'Zawgyi-BUR', 'SamsungOne-BUR', 'IRI', 'MAL', 'Malta', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN', 'KIR'];
			$('.multiselect > label > input').each(function(i) {
				$(this).prop('checked', false);
				$(this).parent('label').removeClass('multiselect-on')
				if ($.inArray($(this).attr('value'), arrebt) == -1) {
					$(this).parent('label').css('display', 'block');
				} else {
					$(this).parent('label').hide();
				}
			});
		} else if ($(this).val() == "MA-Device") {
			let arreMad = [ 'ARA-AS', 'ARA-EU', 'JPN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'B-POR', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR', 'IRI', 'MAL', 'Malta', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
			$('.multiselect > label > input').each(function(i) {
				$(this).prop('checked', false);
				$(this).parent('label').removeClass('multiselect-on')
				if ($.inArray($(this).attr('value'), arreMad) == -1) {
					$(this).parent('label').css('display', 'block');
				} else {
					$(this).parent('label').hide();
				}
			});
		} else if ($(this).val() == "MA-external") {
			let arreMAex = ['ALB', 'ARA', 'ARM', 'AZE', 'BEN', 'BUL', 'BUR', 'CA-FRE', 'S-CHI', 'SG-CHI', 'TPE', 'HKG', 'CRO', 'CZE', 'DAN', 'DUT', 'EST', 'FAR', 'FIN', 'FRE', 'GEORGIAN', 'GER', 'GRE', 'HEB', 'HIN', 'HUN', 'IND', 'ITA', 'JPN', 'KAZ', 'Main-KHM', 'KIR', 'LAO', 'Ltn-SPA', 'LAT', 'LIT', 'MKD', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SLK', 'SLV', 'SPA', 'SWE', 'RGK', 'THA', 'TUR', 'TUK', 'UKR', 'URD', 'UZB', 'VIE'];
			$('.multiselect > label > input').each(function(i) {
				$(this).prop('checked', false);
				$(this).parent('label').removeClass('multiselect-on')
				if ($.inArray($(this).attr('value'), arreMAex) != -1) {
					$(this).parent('label').css('display', 'block');
				} else {
					$(this).parent('label').hide();
				}
			});
		} else if ($(this).val() == "MA-Feature") {
			let arreMad = [ 'ARA-AS', 'ARA-EU', 'AZE', 'CA-FRE', 'JPN', 'GEORGIAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'B-POR', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR', 'BOS', 'KIR', 'RGK', 'TUK', 'CNR', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
			$('.multiselect > label > input').each(function(i) {
				$(this).prop('checked', false);
				$(this).parent('label').removeClass('multiselect-on')
				if ($.inArray($(this).attr('value'), arreMad) == -1) {
					$(this).parent('label').css('display', 'block');
				} else {
					$(this).parent('label').hide();
				}
			});
		} else if ($(this).val() == "MA-AC") {
			let arrMac = [ 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'ENGB2KOR', 'ENUS2KOR', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAO', 'Main-KHM', 'MON', 'KOR2S-CHI', 'SC2ENG', 'M-SPA', 'Zawgyi-BUR', 'SamsungOne-BUR', 'IRI', 'MAL', 'Malta', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
			$('.multiselect > label > input').each(function(i) {
				$(this).prop('checked', false);
				$(this).parent('label').removeClass('multiselect-on')
				if ($.inArray($(this).attr('value'), arrMac) == -1) {
					$(this).parent('label').css('display', 'block');
				} else {
					$(this).parent('label').hide();
				}
			});
		} else if ($(this).val() == "HA") {
			// let arrHa = [ 'ALB', 'ARA', 'BUL', 'B-POR', 'S-CHI', 'HKG', 'TPE', 'CRO', 'CZE', 'CA-FRE', 'DAN', 'FRE', 'DUT', 'ENGB2KOR', 'EST', 'FAR', 'FIN', 'GER', 'GRE', 'HEB', 'HUN', 'IND', 'ITA', 'KAZ', 'KOR2ENG-GB', 'KOR2ENG-US', 'LAT', 'LIT', 'Ltn-SPA', 'MKD', 'MAL', 'Malta', 'MON', 'NOR', 'POL', 'POR', 'ROM', 'RUS', 'SER', 'SLK', 'SLV', 'SPA', 'SWE', 'THA', 'TUR', 'UKR', 'UZB', 'VIE' ];
			let arrHa = [ 'ARA-AS', 'ARA-EU', 'AZE', 'BEN', 'BUR', 'GEORGIAN', 'JPN', 'LAO', 'ENUS2KOR', 'KOR2S-CHI', 'SC2ENG', 'SG-CHI', 'Main-KHM', 'Zawgyi-BUR', 'URD', 'SamsungOne-BUR', 'MAR', 'TEL', 'TAM', 'GUJ', 'KAN', 'ODI', 'MAY', 'PUN' ];
			$('.multiselect > label > input').each(function(i) {
				$(this).prop('checked', false);
				$(this).parent('label').removeClass('multiselect-on')
				if ($.inArray($(this).attr('value'), arrHa) == -1) {
					// $(this).parent('label').hide();
					$(this).parent('label').css('display', 'block');
				} else {
					// $(this).parent('label').css('display', 'block');
					$(this).parent('label').hide();
				}
			});
		} else {
			$('.multiselect > label > input').each(function(i) {
				$(this).prop('checked', false);
				$(this).parent('label').removeClass('multiselect-on')
				$(this).parent('label').css('display', 'block');
			});
		}
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

