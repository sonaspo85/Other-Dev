Func _eXtractSpec($specFile)
	If Not FileExists($specFile) Then
		MsgBox(0, "오류", "스펙 엑셀 파일이 존재하지 않습니다.")
		Return -2 ;~ 엑셀 파일이 없으면 프로세스를 종료한다.
	EndIf
	
	;~ Validation.xml 파일을 생성 =============================================================================
	Local $specXML = @ScriptDir & '\xsls\' & 'Validation.xml'
	_FileCreate($specXML)
	FileWriteLine($specXML, '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
	FileWriteLine($specXML, '<root>')
	;~ ========================================================================================================

	;~ 엑셀 파일 열기 =========================================================================================
	Local $oExcel = _Excel_Open(False, False, False)
	Local $oWorkbook = _Excel_BookOpen($oExcel, $specFile, False, False, Default, Default, 3)
	Local $i, $division, $bandmode, $ouputpower, $supports, $sItem, $sValue, $deviceSht, $prodType
	Local $eArray = []
	;~ ========================================================================================================
	
	;~ 배열에 시트 명을 추가하고 각 시트마다 시트명이 일치하는지 확인 ==========================================
	Local $shtCnt = $oWorkbook.Sheets.Count
	For $i = 1 To $shtCnt
		_ArrayAdd($eArray, $oWorkbook.Sheets($i).Name)
	Next

	;~ Device 시트명 일치 여부 확인 ============================================================================
	If _ArraySearch($eArray, "Device") = -1 Then
		alertError()
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf
	;~ ========================================================================================================
	
	Local $deviceSht = $oWorkbook.Sheets(6) ;~ device의 시트 순서 6, 이 경우에도 시트명이 일치하는지 확인 ======
	If $deviceSht.Name <> "Device" Then
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf

	Local $k, $chItem, $chVal
	For $k = 2 To 5 ;~ Device 시트는 5행까지 있음
		$chVal = $deviceSht.Cells($k, 3).Value
		$chItem = $deviceSht.Cells($k, 2).Value

		If $chVal = "" Then
			;~ 값이 비어있을 경우 skip
		Else
			If $chItem = "모델명" Then ;~ $chItem 값에 따라 xml 요소를 작성
				FileWriteLine($specXML, @TAB & '<model name="' & $chVal & '" />')
			ElseIf $chItem = "제품 유형" Then
				FileWriteLine($specXML, @TAB & '<product type="' & $chVal & '" />')
				$prodType = $chVal
				ConsoleWrite($prodType & @CRLF)
			ElseIf $chItem = "화면 지문 인식 유형" Then
				FileWriteLine($specXML, @TAB & '<optical type="' & $chVal & '" />')
			EndIf
		EndIf
	Next
	
	If _ArraySearch($eArray, "RED Band Mode") = -1 Then
		alertError()
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf
	Local $bandSht = $oWorkbook.Sheets(1)
	If $bandSht.Name <> "RED Band Mode" Then
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf
	
	;~ 엑셀 시트의 마지막 row를 구함, 밴드 시트는 모델 네트워크 사양에 따라 항목이 달라짐 ======================
	Local $xlDown = -4121 
	Local $lLastRow = Number($bandSht.Range("C3").End($xlDown).Row)
	;~ ========================================================================================================

	FileWriteLine($specXML, @TAB & '<bandmode>')
	With $bandSht
		For $i = 4 To $lLastRow
			If .Cells($i, 2).Value = "" Then
				;~ 셀을 병합한 경우 이전의 네트워크 사양을 사용 2G, 3G 등...
				$division = $division
			Else
				$division = .Cells($i, 2).Value
			EndIf
			;~ band mode 값은 소문자화, ~ -> _ 변경, 강제 줄바꿈 삭제
			$bandmode = StringLower(StringReplace(StringReplace(.Cells($i, 3).Value, "~", "_"), @LF, ""))

			If StringInStr($bandmode, "LTE") Then
				$bandmode = StringReplace($bandmode, " ", "_")
			ElseIf StringInStr($bandmode, "(FR1)") Then ;~ 러시아 밴드 사양의 경우 (FR1)으로 인한 오류를 없애기 위한 처리
				$bandmode = StringReplace($bandmode, "(FR1)", "_(FR1)")
			ElseIf $bandmode = "WCDMA Band VIII" Then ;~ 스펙 사용 값과 인디자인에 작성된 값이 다르기 때문에 별도 처리
				$bandmode = "wcdma900"
			ElseIf $bandmode = "WCDMA Band I" Then ;~ 스펙 사용 값과 인디자인에 작성된 값이 다르기 때문에 별도 처리
				$bandmode = "wcdma2100"
			ElseIf StringInStr($bandmode, "(not all regions/countries)") Then ;~ wifi 사양에 해당 값이 들어가 있을 수 있음
				$bandmode = "wifi5_9_6_4ghz"
			Else
				$bandmode = StringReplace(StringReplace(StringReplace($bandmode, " ", ""), ".", "_"), "Wi-Fi", "wifi")
				$bandmode = StringReplace($bandmode, ",", "_")
			EndIf
			If StringInStr($bandmode, "nfc13_56mhz") Then ;~ nfc의 경우 별도 처리
				$bandmode = "nfc1"
			EndIf
			;~ output power 값에 강제 개행, 특수 유니코드가 들어간 경우 replace 실행, 인디자인의 값을 엑셀에 입력하기 때문에 발생하는 오류 대비
			$ouputpower = StringRegExpReplace(StringReplace(.Cells($i, 4).Value, @LF, " "), "\x{00A0}", " ")
			$supports = .Cells($i, 5).Value ;~ support 값에 따라 검증 유무 확인 용
			
			;~ 위 변수로 설정한 값을 xml 요소로 작성
			FileWriteLine($specXML, @TAB & @TAB & '<spec division="' & $division & '" bandandmode="' & $bandmode & '" outputpower="' & $ouputpower & '" supportstatus="' & $supports & '" />')
		Next
	EndWith
	FileWriteLine($specXML, @TAB & '</bandmode>') ;~ xml 태그 닫음

	;~ 우크라이의 경우 밴드 사양 항목이 추가되거나 값이 다르기 때문에 별도 처리 =======================================================
	If _ArraySearch($eArray, "Ukr-RED Band Mode") <> -1 Then
		Local $bandSht = $oWorkbook.Sheets("Ukr-RED Band Mode")
		If $bandSht.Name <> "Ukr-RED Band Mode" Then
			CloseExcel($oWorkbook, $oExcel)
			Return -1
		EndIf
		Local $xlDown = -4121
		Local $lLastRow = Number($bandSht.Range("C3").End($xlDown).Row)

		FileWriteLine($specXML, @TAB & '<ukr-bandmode>')
		With $bandSht
			For $i = 4 To $lLastRow
				If .Cells($i, 2).Value = "" Then
					$division = $division
				Else
					$division = .Cells($i, 2).Value
				EndIf
				$bandmode = StringLower(StringReplace(StringReplace(.Cells($i, 3).Value, "~", "_"), @LF, ""))
				If StringInStr($bandmode, "LTE") Then
					$bandmode = StringReplace($bandmode, " ", "_")
				ElseIf StringInStr($bandmode, "(FR1)") Then
					$bandmode = StringReplace($bandmode, "(FR1)", "_(FR1)")
				ElseIf $bandmode = "WCDMA Band VIII" Then
					$bandmode = "wcdma900"
				ElseIf $bandmode = "WCDMA Band I" Then
					$bandmode = "wcdma2100"
				ElseIf StringInStr($bandmode, "(not all regions/countries)") Then
					$bandmode = "wifi5_9_6_4ghz"
				Else
					$bandmode = StringReplace(StringReplace(StringReplace($bandmode, " ", ""), ".", "_"), "Wi-Fi", "wifi")
					$bandmode = StringReplace($bandmode, ",", "_")
				EndIf
				If StringInStr($bandmode, "nfc13_56mhz") Then
					$bandmode = "nfc1"
				EndIf
				$ouputpower = StringRegExpReplace(StringReplace(.Cells($i, 4).Value, @LF, " "), "\x{00A0}", " ")
				$supports = .Cells($i, 5).Value

				FileWriteLine($specXML, @TAB & @TAB & '<spec division="' & $division & '" bandandmode="' & $bandmode & '" outputpower="' & $ouputpower & '" supportstatus="' & $supports & '" />')
			Next
		EndWith
		FileWriteLine($specXML, @TAB & '</ukr-bandmode>') ;~ 태그 닫음
	EndIf
	;~ ========================================================================================================
	
	;~ SAR 사양 추출 ==========================================================================================
	If _ArraySearch($eArray, "SAR") = -1 Then
		alertError()
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf
	
	Local $SarSht = $oWorkbook.Sheets(2)
	If $SarSht.Name <> "SAR" Then
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf
	$lLastRow = Number($SarSht.Range("C3").End($xlDown).Row)

	FileWriteLine($specXML, @TAB & '<sars>')
	With $SarSht
		For $i = 3 To $lLastRow
			If .Cells($i, 2).Value = "" Then
				$division = $division
			Else
				If .Cells($i, 2).Value = "Chi(TC)" Then
					;~ Chi(Taiwan)이나 Chi(TC)를 사용하는 경우가 있음
					$division = "Chi(Taiwan)"
				Else
					$division = .Cells($i, 2).Value
				EndIf
			EndIf
			$sItem = StringLower(StringReplace(.Cells($i, 3).Value, " ", ""))
			$sValue = StringRegExpReplace(.Cells($i, 4).Value, "\x{00A0}", " ") ;~ 특수 유니코드를 공백으로 처리
			
			;~ SAR 값이 비어있을 경우 value 값을 0 처리하여 검증 로직에서 skip 하도록 하였으나 비어있는 경우 Error 처리하도록 로직 수정
			;~ 사용자가 직접 0으로 입력해야 함
			;~ If $sValue = "" Then
			;~ 	$sValue = "0"
			;~ EndIf
			
			FileWriteLine($specXML, @TAB & @TAB & '<spec division="' & $division & '" item="' & $sItem & '" value="' & $sValue & '" />')
		Next
	EndWith
	FileWriteLine($specXML, @TAB & '</sars>') ;~ 태그 닫음
	;~ ========================================================================================================
	;~ 라틴 스페인 사양 검증을 위한 xml 추출 로직, QSG에서 내용 삭제로 주석 처리함, 후에 사양이 추가될 경우 대비 남겨놓음
	;~ If _ArraySearch($eArray, "LTN_Spanish") = -1 Then
	;~ 	alertError()
	;~ 	CloseExcel($oWorkbook, $oExcel)
	;~ 	Return -1
	;~ EndIf
	;~ Local $ltnSpaSht = $oWorkbook.Sheets("LTN_Spanish")
	
	;~ FileWriteLine($specXML, @TAB & '<electronic>')

	;~ $lLastRow = Number($ltnSpaSht.Range("E3").End($xlDown).Row)
	;~ ;~ 코드 수정 필요
	;~ With $ltnSpaSht
	;~ 	$sValue = .Cells(3, 5).Value & " " & .Cells(4, 5).Value & " " & .Cells(5, 5).Value
	;~ 	FileWriteLine($specXML, @TAB & @TAB & '<spec division="adapter" item="entry1" value="' & $sValue & '" />')

	;~ 	$sValue = StringReplace(.Cells(6, 5).Value, Chr(10), " ") & " " & StringReplace(.Cells(7, 5).Value, Chr(10), " ")
	;~ 	FileWriteLine($specXML, @TAB & @TAB & '<spec division="adapter" item="departure1" value="' & $sValue & '" />')

	;~ 	$sValue = .Cells(8, 5).Value
	;~ 	FileWriteLine($specXML, @TAB & @TAB & '<spec division="device" item="entry1" value="' & $sValue & '" />')
	;~ EndWith
	;~ FileWriteLine($specXML, @TAB & '</electronic>')
	;~ ========================================================================================================

	;~ 터기 사양 추출 =========================================================================================
	If _ArraySearch($eArray, "MEA_Turkish") = -1 Then
		alertError()
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf

	Local $turSht = $oWorkbook.Sheets(3)
	If $turSht.Name <> "MEA_Turkish" Then
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf
	FileWriteLine($specXML, @TAB & '<productSpec>')
	$lLastRow = Number($turSht.Range("A4").End($xlDown).Row)

	With $turSht
		For $i = 5 To $lLastRow
			$division = StringRegExpReplace(StringReplace(.Cells($i, 1).Value, @LF, ""), '\(.+?\)', '')
			$sItem = StringRegExpReplace(StringLower(StringReplace($division, " ", "")), '\(.+?\)', '')
			$sValue = StringReplace(StringReplace(StringReplace(.Cells($i, 2).Value, @LF, " "), '"', ''), '”', '')
			If $i = 5 Or $i = 9 Then ;~ CPU 정보
				$sValue = StringReplace($sValue, " /", ",")
				$division = StringReplace($division, " ", "")
			EndIf
			FileWriteLine($specXML, @TAB & @TAB & '<spec division="' & $division & '" item="' & $sItem & '" value="' & $sValue & '" />')
		Next
	EndWith

	FileWriteLine($specXML, @TAB & '</productSpec>') ;~ 태그 닫음
	;~ ========================================================================================================

	;~ SEA Indonesian 추출 (국가등록번호) =====================================================================
	If _ArraySearch($eArray, "SEA_Indonesian") = -1 Then
		alertError()
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf

	Local $indSht = $oWorkbook.Sheets(4)
	If $indSht.Name <> "SEA_Indonesian" Then
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf
	
	FileWriteLine($specXML, @TAB & '<registration>')

	With $indSht
		FileWriteLine($specXML, @TAB & @TAB & '<spec division="regNum" item="regNum" value="' & .Cells(2, 3).Value & '" />')
	EndWith
	FileWriteLine($specXML, @TAB & '</registration>') ;~ 태그 닫음
	;~ ========================================================================================================

	;~ 구성품 정보 추출 ========================================================================================
	If _ArraySearch($eArray, "Package contents") = -1 Then
		alertError()
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf

	Local $packageSht = $oWorkbook.Sheets(5)
	If $packageSht.Name <> "Package contents" Then
		CloseExcel($oWorkbook, $oExcel)
		Return -1
	EndIf
	
	FileWriteLine($specXML, @TAB & '<packages>')
	$lLastRow = Number($packageSht.Range("B2").End($xlDown).Row)
	;~ 구성품 정보 구성
	With $packageSht
		For $i = 3 To $lLastRow
			$division = .Cells($i, 2).Value
			$sItem = StringLower(StringReplace($division, " ", ""))
			$sItem = StringRegExpReplace($sItem, "(\(|\))", "_")
			$support = .Cells($i, 3).Value
			FileWriteLine($specXML, @TAB & @TAB & '<spec division="' & $division & '" item="' & $sItem & '" supportstatus="' & $support & '" />')
		Next
	EndWith
	FileWriteLine($specXML, @TAB & '</packages>')
	;~ ========================================================================================================

	FileWriteLine($specXML, '</root>') ;~ 모든 태그 닫음
	FileClose($specXML) ;~ xml 작성 파일 메모리 끄기
	
	_Excel_BookClose($oWorkbook, False)
	_Excel_Close($oExcel, True, True)
	$oExcel = "" ;~ 엑셀 오브젝트 메모리 제거
	Return $prodType ;~ 제품 유형을 반환한다. 제품 유형에 따라 검증 로직을 선택하도록 설정하기 위함
EndFunc

;~ 중간에 오류가 발생해 엑셀을 종료할 경우 사용하기 위한 함수 =============================================
Func CloseExcel($oWorkbook, $oExcel) 
	_Excel_BookClose($oWorkbook, False)
	_Excel_Close($oExcel, True, True)
	$oExcel = ""
EndFunc
;~ ========================================================================================================

;~ 오류 메시지 출력 함수 ==================================================================================
Func alertError()
	MsgBox(0, "오류", "스펙 엑셀 파일의 시트 이름 또는 순서가 올바르지 않습니다.")
EndFunc
;~ ========================================================================================================