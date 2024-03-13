Func _importBasicPrice($wkSht, $dbSht, $n, $cols, $mtype)
	With $wkSht
		.Cells(7, 7).Value = $dbSht.Cells(68 + $n, $cols).Value ;~ 신규기획
		.Cells(8, 7).Value = $dbSht.Cells(72 + $n, $cols).Value ;~ 신규작성
		.Cells(9, 7).Value = $dbSht.Cells(48 + $n, $cols).Value ;~ 수정작성 A
		.Cells(10, 7).Value = $dbSht.Cells(52 + $n, $cols).Value ;~ 수정작성 B
		.Cells(11, 7).Value = $dbSht.Cells(27 + $n, $cols).Value ;~ 내용확인
		.Cells(12, 7).Value = $dbSht.Cells(80 + $n, $cols).Value ;~ 신규편집 A
		.Cells(13, 7).Value = $dbSht.Cells(84 + $n, $cols).Value ;~ 신규편집 B
		.Cells(14, 7).Value = $dbSht.Cells(56 + $n, $cols).Value ;~ 수정편집 A
		.Cells(15, 7).Value = $dbSht.Cells(60 + $n, $cols).Value ;~ 수정편집 B
		.Cells(16, 7).Value = $dbSht.Cells(64 + $n, $cols).Value ;~ 수정편집 C

		Local $pcols
		If $mtype = 0 Then
			$pcols = 6
		ElseIf $mType = 1 Then
			$pcols = 4
		EndIf
		.Cells(17, 7).Value = $dbSht.Cells(104 + $n, $cols + $pcols).Value ;~ 책자합본표지
		.Cells(18, 7).Value = $dbSht.Cells(100 + $n, $cols + $pcols).Value ;~ 책자합본목차
		.Cells(19, 7).Value = $dbSht.Cells(32 + $n, $cols).Value ;~ 법인검수
		.Cells(23, 7).Value = $dbSht.Cells(226, 7).Value ;~ 정밀묘사A-1
		.Cells(24, 7).Value = $dbSht.Cells(227, 7).Value ;~ 정밀묘사A-2
		.Cells(25, 7).Value = $dbSht.Cells(228, 7).Value ;~ 표준묘사B-1
		.Cells(26, 7).Value = $dbSht.Cells(229, 7).Value ;~ 표준묘사B-2
		.Cells(27, 7).Value = $dbSht.Cells(230, 7).Value ;~ 표준묘사B-3
		.Cells(28, 7).Value = $dbSht.Cells(231, 7).Value ;~ 표준묘사B-4
		.Cells(29, 7).Value = $dbSht.Cells(222, 7).Value ;~ 부분묘사C-1
		.Cells(30, 7).Value = $dbSht.Cells(223, 7).Value ;~ 부분묘사C-2
		.Cells(31, 7).Value = $dbSht.Cells(224, 7).Value ;~ 부분변형D
		.Cells(32, 7).Value = $dbSht.Cells(220, 7).Value ;~ 단순형E-1
		.Cells(33, 7).Value = $dbSht.Cells(221, 7).Value ;~ 단순형E-2
		.Cells(34, 7).Value = $dbSht.Cells(232, 7).Value ;~ 캡쳐가공
		.Cells(35, 7).Value = $dbSht.Cells(219, 7).Value ;~ 단순변경
		.Cells(36, 7).Value = $dbSht.Cells(21 + $n, $cols).Value ;~ 기타상급
	EndWith
EndFunc

Func _importMulitPrice($wkSht, $dbSht, $cols, $rows, $mtype, $lang)
	Local $nCols
	With $wkSht
		.Cells(7, 7).Value = $dbSht.Cells(169 + $rows, $cols).Value ;~ 초기DTP
		.Cells(8, 7).Value = $dbSht.Cells(154 + $rows, $cols).Value ;~ DTP 수정편집 A
		.Cells(9, 7).Value = $dbSht.Cells(159 + $rows, $cols).Value ;~ DTP 수정편집 B
		.Cells(10, 7).Value = $dbSht.Cells(164 + $rows, $cols).Value ;~ DTP 수정편집 C

		If $mtype = 0 Then ;~ UM
			$nCols = 14
		ElseIf $mtype = 1 Then ;~ QSG
			$nCols = 13
		EndIf
		.Cells(11, 7).Value = $dbSht.Cells(189 + $rows, $nCols).Value ;~ 책자합본표지
		.Cells(12, 7).Value = $dbSht.Cells(164 + $rows, $nCols).Value ;~ 책자합본목차

		If StringInStr($lang, 'Chinese') Or StringInStr($lang, 'Hongkong') Or StringInStr($lang, 'Taiwan') Then
			$nCols = 15
		Else
			$nCols = $cols
		EndIf
		.Cells(13, 7).Value = $dbSht.Cells(119 + $rows, $nCols).Value ;~ 기능 및 MMI 확인
		.Cells(14, 7).Value = $dbSht.Cells(124 + $rows, $cols).Value ;~ 구글ID
		.Cells(15, 7).Value = $dbSht.Cells(114 + $rows, $cols).Value ;~ MMI 수동
		.Cells(16, 7).Value = $dbSht.Cells(129 + $rows, $cols).Value ;~ MMI Matcher
		.Cells(17, 7).Value = $dbSht.Cells(135 + $rows, $cols).Value ;~ 법인검수
		.Cells(28, 7).Value = $dbSht.Cells(226, 7).Value ;~ 정밀묘사A-1
		.Cells(29, 7).Value = $dbSht.Cells(227, 7).Value ;~ 정밀묘사A-2
		.Cells(30, 7).Value = $dbSht.Cells(228, 7).Value ;~ 표준묘사B-1
		.Cells(31, 7).Value = $dbSht.Cells(229, 7).Value ;~ 표준묘사B-2
		.Cells(32, 7).Value = $dbSht.Cells(230, 7).Value ;~ 표준묘사B-3
		.Cells(33, 7).Value = $dbSht.Cells(231, 7).Value ;~ 표준묘사B-4
		.Cells(34, 7).Value = $dbSht.Cells(222, 7).Value ;~ 부분묘사C-1
		.Cells(35, 7).Value = $dbSht.Cells(223, 7).Value ;~ 부분묘사C-2
		.Cells(36, 7).Value = $dbSht.Cells(224, 7).Value ;~ 부분변형D
		.Cells(37, 7).Value = $dbSht.Cells(220, 7).Value ;~ 단순형E-1
		.Cells(38, 7).Value = $dbSht.Cells(221, 7).Value ;~ 단순형E-2
		.Cells(39, 7).Value = $dbSht.Cells(232, 7).Value ;~ 캡쳐가공
		.Cells(40, 7).Value = $dbSht.Cells(219, 7).Value ;~ 단순변경
	EndWith
EndFunc

Func _importTRprice($wkSht, $lngSht, $rows)
	With $wkSht
		.Cells(22, 6).Value = $lngSht.Cells($rows, 9).Value ;~ 95-99%
		.Cells(23, 6).Value = $lngSht.Cells($rows, 10).Value ;~ 75-94%
		If Number(.Cells(24, 4).Value) <= 250 Then
			.Cells(24, 6).Value = $lngSht.Cells($rows, 11).Value ;~ 74-No match - new
		Else
			.Cells(24, 6).Value = $lngSht.Cells($rows, 8).Value ;~ 74-No match - new
		EndIf
	EndWith
EndFunc

Func _importHTMLPrice($wkSht, $dbSht, $rows, $lang)
	Local $htmlrow1_3, $htmlrow4, $iconrow, $altA, $altB
	With $wkSht
		If $lang = 'Arabic' Or $lang = 'Farsi' Or $lang = 'Urdu' Or $lang = 'Hebrew' Or $lang = 'Khmer' Or $lang = 'Lao' Or $lang = 'Myanmar' Or $lang = 'Myanmar(Zawgyi>Unicode)' Or $lang = 'Bengali' Then
			$htmlrow1_3 = 6
			$htmlrow4 = 13
		Else
			$htmlrow1_3 = 8
			$htmlrow4 = 15
		EndIf
		.Cells(7, 7).Value = $dbSht.Cells($htmlrow1_3, 10).Value ;~ HTML 변환 1-3
		.Cells(8, 7).Value = $dbSht.Cells($htmlrow4, 10).Value ;~ HTML 변환 4
		.Cells(9, 7).Value = $dbSht.Cells(17, 10).Value ;~ HTML 확인

		If StringInStr($lang, 'Korean') Then
			$iconrow = 214
			$altA = 198
			$altB = 206
		ElseIf StringInStr($lang, 'English') Then
			$iconrow = 212
			$altA = 196
			$altB = 204
		Else
			$iconrow = 214
			$altA = 198
			$altB = 206
		EndIf
		.Cells(10, 7).Value = $dbSht.Cells($iconrow + $rows, 7).Value ;~ 아이콘 확인
		.Cells(11, 7).Value = $dbSht.Cells($altA + $rows, 7).Value ;~ 대체텍스트입력A
		.Cells(12, 7).Value = $dbSht.Cells($altB + $rows, 7).Value ;~ 대체텍스트입력B
	EndWith
EndFunc