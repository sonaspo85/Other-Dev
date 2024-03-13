;~ 액세서리 관련 QSG의 사양을 검증하는 모듈, checkSpec.au3 와 거의 비슷하기 때문에 자세한 주석 설명은 생략
;~ 일부 검증 로직은 함수로 분리하여 진행하도록 설정
Func _CheckSpecAcc($manualN, $Area, $Product, $ver)
	Global $Scrpath = FileGetShortName(@ScriptDir)
	Local $logfile = $Scrpath & '\log.txt'
	Local $hFile = FileOpen($logfile, 1)
	
	ConsoleWrite($manualN & ":" & $Area & ":" & $Product & @CRLF)
	_FileWriteLog($hFile, $manualN & ":" & $Area & ":" & $Product)
	
	Local $region = $Area
	Local $mergedXML = $Scrpath & "\temp\" & "idmlMergedXML.xml"
	Local $specXML = $Scrpath & "\xsls\" & "Validation.xml"
	Local $langXML = $Scrpath & "\xsls\" & "languages.xml"
	Local $tempXslx = $Scrpath & "\resource\" & "template.xlsx"
	Local $ReadMerge = FileRead($mergedXML)

	Local $oXMLObj = ObjCreate('Microsoft.XMLDOM') ;~ idml merged XML 파일 불러오기
	Local $vXMLObj = ObjCreate('Microsoft.XMLDOM') ;~ validation XML 파일 불러오기
	Local $LangXMLObj = ObjCreate('Microsoft.XMLDOM') ;~ languages.xml 파일 불러오기

	If FileExists($mergedXML) = 1 Then
		_FileWriteLog($hFile, "Merged XML 파일이 확인, 검증 프로세스 진행")
	Else
		_FileWriteLog($hFile, "Merged XML 파일이 없습니다.")
		Return "NoneMerge" ;~ idmlMergedXML.xml 파일이 없을 경우
	EndIf

	$oXMLObj.load($mergedXML)

	;~ 문서에 포함된 언어 확인
	Local $XMLNodeList = $oXMLObj.selectNodes('//doc')
	Local $i, $j, $langList = [], $Langs, $CheckVal
	
	For $i in $XMLNodeList
		$Langs = $i.getAttribute("lang")
		If $Langs = "QSG" Or $Langs = "Cover" Then
			;~ Nothing
		Else
			_ArrayAdd($langList, $Langs)
		EndIf
	Next
	Local $LangLists = _ArrayUnique($langList)
	
	For $j = 2 To UBound($LangLists) - 1
		$CheckVal = _checkLangs($Scrpath, $LangLists[$j])
		If $CheckVal = -1 Then
			_FileWriteLog($hFile, $LangLists[$j] & " 언어 표기가 올바르지 않음, 프로세스 중단")
			Return "WrongLang"
		EndIf
	Next
	;~ 문서에 포함된 언어 확인 끝

	;~ 템플릿 엑셀 파일 열기
	Local $oExcel = _Excel_Open(False, False, False) ;~ _Excel_Open(True, False, False)
	Local $templateWkb = _Excel_BookOpen($oExcel, $tempXslx, True, True) ;~ _Excel_BookOpen($oExcel, $tempXslx, True, True)
	Local $wkSht = $templateWkb.Sheets(1)
	
	$wkSht.Cells(1, 7).Value = $ver ;버전 입력
	$vXMLObj.load($specXML) ;~ Spec XML 파일
	$LangXMLObj.load($langXML) ;~ languages.xml 파일
	Local $vModelName = $vXMLObj.selectSingleNode('//model').getAttribute('name')
	
	;~ 일반 정보 입력
	_checkGeneral($hFile, $vXMLObj, $wkSht, $manualN)

	Local $q = 8 ;~ 엑셀 사양 입력 첫 줄
	;~ 모델명 사양 검증
	$q = _checkModelName($hFile, $vXMLObj, $oXMLObj, $wkSht, $q)

	;~ 문서에 포함된 언어마다 사양을 검증한다.
	For $j = 2 To UBound($LangLists) - 1
		_FileWriteLog($hFile, $LangLists[$j] & " 검사 시작...")
		$wkSht.Cells($q, 2).Value = $LangLists[$j]

		;~ 구성품 정보 검증
		_FileWriteLog($hFile, "구성품 정보 사양 검증")
		$q = _checkPackage($hFile, $LangLists[$j], $vXMLObj, $oXMLObj, $LangXMLObj, $ReadMerge, $wkSht, $q)
		;~ 구성품 정보 검증

		;~ SAR 사양 검증
		_FileWriteLog($hFile, "SAR 사양 검증")
		$q = _checkSARspec($hFile, $Product, $region, $LangLists[$j], $vXMLObj, $oXMLObj, $LangXMLObj, $ReadMerge, $wkSht, $q, $oExcel)
		If $q = "Fail" Then
			Return "Fail SAR"
		EndIf
		;~ SAR 사양 검증 끝

		;~ Band and mode  사양 검증
		If ($region = "EUA-EUH" And $LangLists[$j] <> "") Or ($region = "EUB" And $LangLists[$j] <> "") Or ($region = "EUC" And $LangLists[$j] <> "") Or ($region = "EUE" And $LangLists[$j] <> "") Or ($region = "EU-alone" And $LangLists[$j] <> "") Or ($region = "MEA" And $LangLists[$j] = "Tur") Or ($region = "CIS" And $LangLists[$j] = "Ukr") Or ($region = "CIS" And $LangLists[$j] = "Rus") Or ($region = "UKRAINE_ONLY" And $LangLists[$j] = "Ukr") Or ($region = "UKRAINE_ONLY" And $LangLists[$j] = "Rus") Then
			_FileWriteLog($hFile, $LangLists[$j] & " Bandmode 사양 검증")
			If $LangLists[$j] = "Rus" Then
				Local $RusBandData = $LangXMLObj.selectSingleNode("//bandmode/items[@lang='" & $LangLists[$j] & "']/item[@id='bandandmode']").text
				Local $idmlLists = $oXMLObj.selectNodes("//p[@class='Description-Band']")
				For $i in $idmlLists
					If $i.text = $RusBandData Then
						$q = _checkBandspec($hFile, $Product, $Scrpath, $region, $LangLists[$j], $vXMLObj, $oXMLObj, $LangXMLObj, $ReadMerge, $wkSht, $q)
					EndIf
				Next
			Else
				$q = _checkBandspec($hFile, $Product, $Scrpath, $region, $LangLists[$j], $vXMLObj, $oXMLObj, $LangXMLObj, $ReadMerge, $wkSht, $q)
			EndIf
		EndIf
		;~ Band and mode  사양 검증

		;~ Tur 전용 사양
		If ($region = "MEA" And $LangLists[$j] = "Tur") Or ($LangLists[$j] = "Tur") Then
			$q = _checkTurSpec($hFile, $Scrpath, $LangLists[$j], $ReadMerge, $wkSht, $vXMLObj, $oXMLObj, $LangXMLObj, $Product, $q)
		EndIf
		;~ Tur 전용 사양

		;~ e-Doc 사양 검증
		If ($region = "EUA-EUH" And $LangLists[$j] <> "") Or ($region = "EUB" And $LangLists[$j] <> "") Or ($region = "EUC" And $LangLists[$j] <> "") Or ($region = "EUE" And $LangLists[$j] <> "") Or ($region = "EU-alone" And $LangLists[$j] <> "") Or ($region = "CIS" And $LangLists[$j] = "Rum") Or ($region = "CIS" And $LangLists[$j] = "Ukr") Or ($region = "UKRAINE_ONLY" And $LangLists[$j] = "Rum") Or ($region = "UKRAINE_ONLY" And $LangLists[$j] = "Ukr") Or ($region = "CIS" And $LangLists[$j] = "Kaz") Then
			_FileWriteLog($hFile, $LangLists[$j] & " eDoc 사양 검증")
			$q = _checkEdoc($LangLists[$j], $LangXMLObj, $ReadMerge, $wkSht, $q)
		EndIf
		;~ e-Doc 사양 검증

		;~ Hearable이라면 opensource 문구 검증
		;~ If $Product = "Hearable" Then
		;~ 	$q = _checkOpensource($hFile, $Scrpath, $LangLists[$j], $vXMLObj, $LangXMLObj, $wkSht, $q)
		;~ EndIf
		;~ Hearable이라면 opensource 문구 검증

		;~ India Bis 문구 확인
		If $region = "India" And $LangLists[$j] = "Eng(India)" And $Product = "Watch" Then
			_FileWriteLog($hFile, $LangLists[$j] & " Bis 문구 사양 검증")
			Local $langBis = "Depending on the region or model, some devices are required to receive approval from the Bureau of Indian Standards (BIS)."
			Local $idmlLists = $oXMLObj.selectNodes("//p[@class='Description_UpSp1']")
			Local $i
			$wkSht.Cells($q, 3).Value = "India BIS 사양"
			$wkSht.Cells($q, 6).Value = $langBis
			For $i in $idmlLists
				If StringInStr($i.text, $langBis) Then
					$wkSht.Cells($q, 5).Value = "True"
					$wkSht.Cells($q, 7).Value = "Success"
					ContinueLoop
				EndIf
			Next
			If $wkSht.Cells($q, 5).Value <> "True" Then
				$wkSht.Cells($q, 5).Value = "Not Found"
				$wkSht.Cells($q, 7).Value = "Fail"
			EndIf
			_CheckFail($wkSht, $q)
			$q = $q + 1
		EndIf
		_FileWriteLog($hFile, $LangLists[$j] & " 검증 완료")
		;~ India Bis 문구 확인

		;~ SEA, Ind 국가등록번호 사양, 보증서 모델 사양 확인
		If ($region = "SEA" And $LangLists[$j] = "Ind") Then
			_FileWriteLog($hFile, $LangLists[$j] & " 보증서 모델 사양 검증")
			$wkSht.Cells($q, 3).Value = "Ind 보증서 모델 사양"
			$wkSht.Cells($q, 4).Value = $vModelName
			Local $r, $regNumCnt = 0
			Local $modLists = $oXMLObj.selectNodes("//p[@class='ModelName-Cover-ID']")
			If $modLists.length = 0 Then
				$wkSht.Cells($q, 5).Value = "Not Found"
				$wkSht.Cells($q, 7).Value = "Fail"
			Else
				For $r in $modLists
					If StringInStr($r.text, $vModelName) Then
						$regNumCnt = $regNumCnt + 1
						$wkSht.Cells($q, 5).Value = $r.text
						$wkSht.Cells($q, 7).Value = "Success"
					EndIf
				Next
				If $regNumCnt = 0 Then
					$wkSht.Cells($q, 5).Value = "Not Found"
					$wkSht.Cells($q, 7).Value = "Fail"
				EndIf
			EndIf
			_CheckFail($wkSht, $q)
			$q = $q + 1
		EndIf
		;~ SEA, Ind 국가등록번호 사양, 보증서 모델 사양 확인

		;~ 러시아 루즈리프 사양 $vModelName
		If $region = "CIS" Or $region = "UKRAINE_ONLY" And ($LangLists[$j] = "Rus" Or $LangLists[$j] = "Kaz") Then
			If (StringInStr($manualN, "HHP_KAZAKHSTAN_ONLY")) Or (StringInStr($manualN, "CIS_TYPE_B") And $LangLists[$j] = "Rus") Or (StringInStr($manualN, "UKRAINE_ONLY") And $LangLists[$j] = "Rus") Then
				;~ HHP_KAZAKHSTAN_ONLY의 경우, CIS_TYPE_B - Rus 검증하지 않음
			Else
				_FileWriteLog($hFile, $LangLists[$j] & " Looseleaf 사양 검증")
				$wkSht.Cells($q, 3).Value = "Looseleaf 사양"
				
				;~ 헤딩 문장 검증
				If $LangLists[$j] = "Rus" Then
					Local $rusLfHead = "ИНФОРМАЦИЯ О СЕРТИФИКАЦИИ ПРОДУКЦИИ"
				ElseIf $LangLists[$j] = "Kaz" Then
					Local $rusLfHead = "ӨНІМДІ СЕРТИФИКАТТАУ ТУРАЛЫ АҚПАРАТ"
				EndIf
				$wkSht.Cells($q, 6).Value = $rusLfHead 
				Local $LsleafLists = $oXMLObj.selectNodes("//p[@class='Looseleaf-Center']")
				Local $ls, $rusCnt = 0
				
				For $ls in $LsleafLists
					If $ls.text = $rusLfHead Then
						$wkSht.Cells($q, 5).Value = $ls.text
						$wkSht.Cells($q, 7).Value = _ReturnCompareText($ls.text, $rusLfHead)
						$rusCnt = $rusCnt + 1
						ExitLoop
					EndIf
				Next
				if $rusCnt = 0 Then
					$wkSht.Cells($q, 5).Value = "Not Found"
					$wkSht.Cells($q, 7).Value = "Fail"
					_CheckFail($wkSht, $q)
				EndIf
				$q = $q + 1
				$rusCnt = 0
				;~ 모델명 검증
				$wkSht.Cells($q, 6).Value = $vModelName
				Local $lsm, $findLf
				If $Product = "Hearable" Then
					If $LangLists[$j] = "Rus" Then
						Local $smName = "Модель:"
						$findLf = $smName & " " & $vModelName
					ElseIf $LangLists[$j] = "Kaz" Then
						Local $smName = "Үлгі:"
						$findLf = $smName & " " & $vModelName
					EndIf
				ElseIf $Product = "Watch" Then
					If $LangLists[$j] = "Rus" Then
						Local $smName = "модели"
						$findLf = $smName & " " & $vModelName
					ElseIf $LangLists[$j] = "Kaz" Then
						Local $smName = "модельдегі"
						$findLf = $vModelName & " " & $smName
					EndIf
				EndIf

				For $lsm in $LsleafLists
					
					If StringInstr($lsm.text, $findLf) Then
						$wkSht.Cells($q, 5).Value = $lsm.text
						;~ $wkSht.Cells($q, 7).Value = _ReturnCompareText(StringReplace($lsm.text, $smName & " ", ""), $vModelName)
						$wkSht.Cells($q, 7).Value = "Success"
						$rusCnt = $rusCnt + 1
						ExitLoop
					EndIf
				Next
				if $rusCnt = 0 Then
					$wkSht.Cells($q, 5).Value = "Not Found"
					$wkSht.Cells($q, 7).Value = "Fail"
					_CheckFail($wkSht, $q)
				EndIf
				$q = $q + 1
			EndIf
		EndIf
		
		$q = $q + 1 ;~ 한 언어가 끝나면 row + 1
	Next

	Local $outputPath = $Scrpath & "\output"
	If Not (FileExists($outputPath)) Then
		DirCreate($outputPath)
	EndIf
	Local $targetWkb = $Scrpath & "\output\" & StringReplace(StringReplace(StringReplace($manualN, "_INDD", ""), "[", ""), "]", "_") & "_사양점검결과.xlsx"
	$oExcel.ScreenUpdating = True
	$templateWkb.Sheets(1).Visible = True
	_Excel_BookSaveAs($templateWkb, $targetWkb, $xlWorkbookDefault, True)
	If FileExists($targetWkb) Then
		_FileWriteLog($hFile, $targetWkb & " 저장 완료")
	Else
		_FileWriteLog($hFile, $targetWkb & " 저장 실패")
	EndIf
	
	FileClose($hFile)
	Local $findFail = _Excel_RangeFind($templateWkb, "Fail", "G:G", $xlFormulas, $xlWhole) ;~ G열에서 fail 값 찾기
	Local $findNS = _Excel_RangeFind($templateWkb, "Not Support", "G:G", $xlFormulas, $xlWhole) ;~ G열에서 not support 값 찾기
	If UBound($findFail) > 0 Or UBound($findNS) > 0 Then
		$templateWkb.Sheets(1).Cells(6, 3).Value = UBound($findFail) + UBound($findNS)
		$templateWkb.Sheets(1).Cells(6, 3).Font.ColorIndex = 30
	EndIf
	$templateWkb.Sheets(1).Protect("97473212!ast")
	_Excel_BookClose($templateWkb, True)
	_Excel_Close($oExcel, True, True)

	Local $oExcel = _Excel_Open(True, False, True)
	_Excel_BookOpen($oExcel, $targetWkb, False, True)
	$oExcel.ScreenUpdating = True
	_Excel_BookSave($targetWkb)
	$oExcel = ""
	Return "complete"
EndFunc

Func _checkOpensource($hFile, $Scrpath, $Lang, $vXMLObj, $LangXMLObj, $wkSht, $q)
	_FileWriteLog($hFile, $Lang & " Open Source 문구 사양 검증")
	Local $MergeXML = $Scrpath & "\temp\04-resource_merged.xml"
	$wkSht.Cells($q, 3).Value = "Open Source 문구 사양"
	Local $opPara = $LangXMLObj.selectSingleNode("//opensources/items[@lang='" & $Lang & "']/item[@id='opensource']").text
	$wkSht.Cells($q, 6).Value = $opPara
	
	Local $oXMLObj = ObjCreate('Microsoft.XMLDOM')
	$oXMLObj.Load($MergeXML)

	Local $idmlLists = $oXMLObj.selectNodes("//p")
	Local $i
	Local $opCnt = 0

	For $i in $idmlLists
		If $i.text = $opPara Or StringInstr($i.text, $opPara) Then
			If $Lang = "Ita" Then
				$i.text = StringRegExpReplace($i.text, "([^>]+opensource.samsung.com.)([^>]+)", "$1")
			ElseIf $Lang = "Tur" Then
				$i.text = StringRegExpReplace($i.text, "([^>]+)(Cihazın kullanım)([^>]+)", "$1")
			EndIf
			$wkSht.Cells($q, 5).Value = $i.text
			$opCnt = $opCnt + 1
			ExitLoop
		EndIf
	Next
	
	If $opCnt = 0 Then
		$wkSht.Cells($q, 5).Value = "Not Found"
		$wkSht.Cells($q, 7).Value = "Fail"
	ElseIf $opCnt > 0 Then
		$wkSht.Cells($q, 7).Value = _ReturnCompareText($wkSht.Cells($q, 6).Value, $wkSht.Cells($q, 5).Value)
	EndIf
	_CheckFail($wkSht, $q)
	$q = $q + 1
	Return $q
EndFunc

Func _checkPackage($hFile, $Lang, $vXMLObj, $oXMLObj, $LangXMLObj, $ReadMerge, $wkSht, $q)
	Local $LangData = _StringBetween($ReadMerge, '<doc lang="' & $Lang & '">', '</doc>')
	Local $LangXML = $Scrpath & "\temp\" & $Lang & ".xml"
	_FileCreate($LangXML)
	FileWriteLine($LangXML, '<?xml version="1.0" encoding="UTF-8"?>')
	FileWriteLine($LangXML, '<root>')
	FileWriteLine($LangXML, $LangData[0])
	FileWriteLine($LangXML, '</root>')
	FileClose($LangXML)

	Local $packLists = $vXMLObj.selectNodes('//packages/spec')
	Local $k, $n, $l
	
	$wkSht.Cells($q, 3).Value = "패키지 사양"
	For $k in $packLists
		If $k.getAttribute("supportstatus") = "Y" Then
			$wkSht.Cells($q, 4).Value = $k.getAttribute("division")
			_FileWriteLog($hFile, $k.getAttribute("division"))
			Local $packItem = $k.getAttribute("item")
			;~ Validation에서 찾은 아이템 값을 Languages 데이터에서 언어에 맞춰 찾는다.
			Local $LangItems = $LangXMLObj.selectNodes("//packages/items[@lang='" & $Lang & "']/item")
			Local $ckCount = 0
			For $n in $LangItems
				;~ id 값이 item 값과 같은지 찾는다.
				Local $LangItem = $n.getAttribute("id")
				If $packItem = $LangItem Then
					$ckCount = $ckCount + 1
					$wkSht.Cells($q, 6).Value = $n.text
					If $n.text = "N/A" Then
						$wkSht.Cells($q, 6).Value = "Not Support"
						$wkSht.Cells($q, 7).Value = "Pass"
					Else
						Local $oTempXML = ObjCreate('Microsoft.XMLDOM')
						$oTempXML.load($LangXML)
						
						Local $idmlLists = $oTempXML.selectNodes("//p")
						
						For $l in $idmlLists
							If StringInStr($l.getAttribute("class"), "UnorderList_1") Or StringInStr($l.getAttribute("class"), "Description-Cell") Then
								If ($n.text = $l.text) Then
									ConsoleWrite($n.text & " : " & $l.text & @CRLF)
									$wkSht.Cells($q, 5).Value = $l.text
									$wkSht.Cells($q, 7).Value = _ReturnCompareText($l.text, $n.text)
									ExitLoop
								Else
									$wkSht.Cells($q, 5).Value = "Not Found"
									$wkSht.Cells($q, 7).Value = "Fail"
								EndIf
							EndIf
						Next
					EndIf
				EndIf
				If $ckCount = 0 Then
					$wkSht.Cells($q, 6).Value = "Not Found"
					$wkSht.Cells($q, 7).Value = "Fail"
				EndIf
			Next
			_CheckFail($wkSht, $q)
			$q = $q + 1 ;~ Row를 더한다.
		EndIf
	Next
	Return $q
EndFunc

Func _checkEdoc($Lang, $LangXMLObj, $ReadMerge, $wkSht, $q)
	$wkSht.Cells($q, 3).Value = "eDoc 사양"
	Local $leDoc = $LangXMLObj.selectSingleNode("//eDoc/items[@lang='" & $Lang & "']/item[@id='edoc']").text
	$wkSht.Cells($q, 6).Value = $leDoc
	Local $sResult = StringRegExp($ReadMerge, $leDoc, 3)
	If UBound($sResult) = 0 Then
		$wkSht.Cells($q, 5).Value = "Not Found"
		$wkSht.Cells($q, 7).Value = "Fail"
	ElseIf UBound($sResult) > 0 Then
		$wkSht.Cells($q, 5).Value = "True"
		$wkSht.Cells($q, 7).Value = "Success"
	Else
		$wkSht.Cells($q, 5).Value = "Error"
		$wkSht.Cells($q, 7).Value = "Fail"
	EndIf
	_CheckFail($wkSht, $q)
	$q = $q + 1
	Return $q
EndFunc

Func _checkTurSpec($hFile, $Scrpath, $Lang, $ReadMerge, $wkSht, $vXMLObj, $oXMLObj, $LangXMLObj, $Product, $q)
	_FileWriteLog($hFile, $Lang & " 터키 전용 사양 검증")
	_FileWriteLog($hFile, $Lang & " Product Spec 사양 검증")
	;~ Tur Product Spec 사양
	Local $tempTurXML = $Scrpath & "\temp\" & "temp.xml"
	_FileCreate($tempTurXML)
	Local $tempTur = _StringBetween($ReadMerge, 'Teknik Özellikler</p>', '</Table>')

	FileWriteLine($tempTurXML, '<?xml version="1.0" encoding="UTF-8"?>')
	FileWriteLine($tempTurXML, '<root>')
	FileWriteLine($tempTurXML, $tempTur[0])
	FileWriteLine($tempTurXML, '</Table>')
	FileWriteLine($tempTurXML, '</root>')
	FileClose($tempTurXML)

	Local $tObjXML = ObjCreate('Microsoft.XMLDOM')
	$tObjXML.load($tempTurXML)

	Local $prodLists = $tObjXML.selectNodes("//tr")
	Local $i, $iCPU, $iRam, $iMemory, $iOsSys, $iScreen, $iCamera, $iFcamera, $iRadio, $iMicro, $iCcamera, $udCamera

	For $i in $prodLists
		;~ ConsoleWrite($i.text & @CRLF)
		If StringInStr($i.text, "İşlemci") Then
			$iCPU = StringReplace($i.text, "İşlemci", "")
		ElseIf StringInStr($i.text, "Ram") Then
			$iRam = $iRam & StringRegExpReplace($i.text, "(SRam|Ram)", "") & " "
		ElseIf StringInStr($i.text, "Hafıza") Then
			$iMemory = $iMemory & StringReplace($i.text, "Hafıza", "") & " "
		ElseIf StringInStr($i.text, "İşletim Sistemi") Then
			$iOsSys = StringReplace($i.text, "İşletim Sistemi", "")
		ElseIf StringInStr($i.text, "Ekran Boyut") Then
			$iScreen = StringReplace($i.text, "Ekran Boyut", "")
		ElseIf StringInStr($i.text, "Ön Kamera") Then
			$iFcamera = StringReplace($i.text, "Ön Kamera", "")
		ElseIf StringInStr($i.text, "İç Kamera") Then
			$iCcamera = StringReplace($i.text, "İç Kamera", "")
		ElseIf StringInStr($i.text, "Kapak Kamerası") Then
			$iCcamera = StringReplace($i.text, "Kapak Kamerası", "")
		ElseIf StringInStr($i.text, "Ekran Altı Kamera") Then
			$udCamera = StringReplace($i.text, "Ekran Altı Kamera", "")
		ElseIf StringInStr($i.text, "Kamera") Then
			$iCamera = StringReplace($i.text, "Kamera", "")
		ElseIf StringInStr($i.text, "Radyo") Then
			$iRadio = StringReplace($i.text, "Radyo", "")
		ElseIf StringInStr($i.text, "MicroSD") Then
			$iMicro = StringReplace($i.text, "MicroSD", "")
			
		EndIf
	Next
	
	Local $vProdLists = $vXMLObj.selectNodes('//productSpec/spec')
	Local $c, $vProdVal, $iProdVal

	For $c in $vProdLists
		$vDiv = $c.getAttribute("division")
		$vSpecVal = $c.getAttribute("value")
		$vItem = $c.getAttribute("item")
		If $Product = "Watch" Then
			If StringInstr($vDiv, "Camera") Then
				;~ Nothing
				ContinueLoop
			Else
				$wkSht.Cells($q, 3).Value = $vDiv
				$wkSht.Cells($q, 4).Value = $vSpecVal
			EndIf
		Else
			$wkSht.Cells($q, 3).Value = $vDiv
			$wkSht.Cells($q, 4).Value = $vSpecVal
		EndIf
		

		If $vItem = "cpu" Then
			$wkSht.Cells($q, 5).Value = $iCPU
		ElseIf $vItem = "ram" Then
			$wkSht.Cells($q, 5).Value = $iRam
		ElseIf $vItem = "memory" Then
			$wkSht.Cells($q, 5).Value = $iMemory
		ElseIf $vItem = "ossystem" Then
			$wkSht.Cells($q, 5).Value = $iOsSys
		ElseIf $vItem = "screensize" Then
			$wkSht.Cells($q, 5).Value = $iScreen
		ElseIf ($Product = "Mobile phone" Or $Product = "Tablet" Or $Product = "Hearable") And $vItem = "camera" Then
			$wkSht.Cells($q, 5).Value = $iCamera
		ElseIf ($Product = "Mobile phone" Or $Product = "Tablet" Or $Product = "Hearable") And $vItem = "frontcamera" Then
			$wkSht.Cells($q, 5).Value = $iFcamera
		ElseIf ($Product = "Mobile phone" Or $Product = "Tablet") And $vItem = "covercamera" Then
			$wkSht.Cells($q, 5).Value = $iCcamera
		ElseIf ($Product = "Mobile phone" Or $Product = "Tablet") And $vItem = "underdisplaycamera" Then
			$wkSht.Cells($q, 5).Value = $udCamera
		ElseIf $vItem = "radio" Then
			$wkSht.Cells($q, 5).Value = $iRadio
		ElseIf $vItem = "microsd" Then
			$wkSht.Cells($q, 5).Value = $iMicro
		EndIf
		$vProdVal = StringRegExpReplace($vSpecVal, "(\s|\/|\,\s)", "")
		$iProdVal = StringRegExpReplace($wkSht.Cells($q, 5).Value, "(\s|\/|\,\s|\”|"")", "")
		_FileWriteLog($hFile, "Compare " & $vProdVal & ":" & $iProdVal)
		$wkSht.Cells($q, 7).Value = _ReturnCompareText($vProdVal, $iProdVal)
		_CheckFail($wkSht, $q)
		$q = $q + 1
	Next

	;~ Tur 제품 수명 밎 보증 사양
	_FileWriteLog($hFile, $Lang & " 제품 수명 밎 보증 사양 검증")
	Local $grtLang = $LangXMLObj.selectSingleNode("//turgaranty/items/item").text
	If $Product = "Hearable" Then
		$grtLang = StringReplace($grtLang, "5", "3")
	EndIf
	$wkSht.Cells($q, 3).Value = "Tur 제품 수명 및 보증 사양"
	$wkSht.Cells($q, 6).Value = $grtLang
	Local $idmlLists = $oXMLObj.selectNodes("//doc/p")
	Local $y
	For $y in $idmlLists
		If $y.text = $grtLang Then
			$wkSht.Cells($q, 5).Value = "True"
			$wkSht.Cells($q, 7).Value = "Success"
			ExitLoop
		Else
			$wkSht.Cells($q, 5).Value = "Not Found"
			$wkSht.Cells($q, 7).Value = "Fail"
		EndIf
	Next
	$q = $q + 1

	Return $q
EndFunc

Func _checkBandspec($hFile, $Product, $Scrpath, $region, $Lang, $vXMLObj, $oXMLObj, $LangXMLObj, $ReadMerge, $wkSht, $q)
	ConsoleWrite($Lang & @CRLF)
	Local $tempLangXML = $Scrpath & "\temp\" & $Lang & ".xml"
	Local $tempXML = $Scrpath & "\temp\" & "temp.xml"
	Local $i, $n, $bandArray = [], $specID, $specUnit, $specVal

	;~ 추출할 텍스트를 찾는다. Output power
	If FileExists($tempXML) Then
		FileDelete($tempXML)
	EndIf

	Local $lOutput = $LangXMLObj.selectSingleNode("//bandmode/items[@lang='" & $Lang & "']/item[@id='outputpower']").text
	Local $bandTable = _StringBetween(FileRead($tempLangXML), $lOutput & "</p></td></tr>", "</Table>")
	If $bandTable = 0 Then
		_FileWriteLog($hFile, $Lang & " : Band and mode 사양 찾을 수 없음")
		$wkSht.Cells($q, 3).Value = "Band and mode, Not Found"
		$wkSht.Cells($q, 7).Value = "Fail"
		_CheckFail($wkSht, $q)
		$q = $q + 1
	Else
		FileWriteLine($tempXML, "<root>")
		FileWriteLine($tempXML, "<table>")
		FileWriteLine($tempXML, $bandTable[0])
		FileWriteLine($tempXML, "</table>")
		FileWriteLine($tempXML, "</root>")

		Local $tXMLObj = ObjCreate('Microsoft.XMLDOM')
		$tXMLObj.load($tempXML)

		If $Lang = "Rus" Then
			Local $idmlLists = $tXMLObj.selectNodes("//td")
			Local $i
			For $i In $idmlLists
				If Not StringInStr($i.getAttribute("Name"), "0:") Then
					_ArrayAdd($bandArray, $i.text)
				EndIf
			Next
		Else
			Local $idmlLists = $tXMLObj.selectNodes("//td")
			;~ ConsoleWrite($idmlLists.length & @CRLF)
			;~ If $idmlLists.length = 0 Then
			;~ 	$idmlLists = $tXMLObj.selectNodes("//p[@class='Description-Band']")
			;~ EndIf

			For $i in $idmlLists
				_ArrayAdd($bandArray, $i.text)
			Next
		EndIf
		;~ _ArrayDisplay($bandArray)
		Local $ilteArr
		Local $turwfCnt = 0
		Local $bdCount = 0 ;~ 인디자인 Bandmode 개수
		Local $bMode = "bandmode"
		Local $vSupport = $vXMLObj.selectNodes("//" & $bMode & "/spec[@supportstatus='Y']")
		Local $vbdCount = $vSupport.length ;~ Validation Bandmode 개수
		ConsoleWrite("Validation Bandmode Support : " & $vSupport.length & @CRLF)

		For $i = 1 To UBound($bandArray) -1
			Local $check = _MathCheckDiv($i, 2)
			If $check = 1 Then
				;~ 엑셀 값을 영어로 변경하고 Spec 값을 불러올 것
				;~ $bandArray[$i] -> idml 언어 값
				_FileWriteLog($hFile, $Lang & ":" & $bandArray[$i])
				If $Lang = "Ukr" And StringInStr($bandArray[$i], "LTE") Then
					$wkSht.Cells($q, 3).Value = $bandArray[$i]
					$specID = "lte"
					$specUnit = "dBm"
				ElseIf StringInStr($bandArray[$i], "LTE") Then
					;~ LTE, 5G 옵션 구분 필요 LTE가 포함될 경우, 5g의 경우 n1/n2 정규식 패턴
					;~ 3 값은 $bandArray[$i] 값 입력
					;~ specID = lte or 5g / specUnit = dBm
					$wkSht.Cells($q, 3).Value = $bandArray[$i]
					$specID = "lte"
					$specUnit = "dBm"
					$ilteArr = StringSplit(StringReplace($bandArray[$i], "LTE ", ""), "/")
				ElseIf StringInStr($bandArray[$i], "FR1") Then
					;~ Rus의 경우 * 포함되어 있으니 삭제하고 진행할 것
					Local $i5gVal = StringReplace($bandArray[$i], " *", "")
					$wkSht.Cells($q, 3).Value = $i5gVal
					$specID = "5g"
					$specUnit = "dBm"
					Local $i5gArr = StringSplit(StringReplace($i5gVal, " (FR1)", ""), "/")
				ElseIf StringRegExp($bandArray[$i], "110(.|,)01\skHz(.+)148\skHz") Then
					;~ wireless charging
					$wkSht.Cells($q, 3).Value = StringRegExpReplace($bandArray[$i], "\s110(.|,)01\skHz(.+)148\skHz", "")
					$specID = "wirelesscharging"
					$specUnit = "dBμA/m"
				Else
					Local $relVal = _returnBasicLang($LangXMLObj, $bandArray[$i], $Lang)
					If $relVal = "" Then
						$wkSht.Cells($q, 3).Value = "Not Found"
						ContinueLoop
					Else
						$wkSht.Cells($q, 3).Value = StringSplit($relVal, ",")[1]
						$specID = StringSplit($relVal, ",")[2]
						$specUnit = StringSplit($relVal, ",")[3]
					EndIf
				EndIf
				
				If $specID = "wcdma900/wcdma2100" Then
					Local $wcdmLists = $vXMLObj.selectNodes("//" & $bMode & "/spec[@division='3G']")
					Local $wcdmArray = []
					For $n in $wcdmLists
						If $n.getAttribute("supportstatus") = "Y" Then
							_ArrayAdd($wcdmArray, $n.getAttribute("outputpower"))
							$bdCount = $bdCount + 1
						EndIf
					Next
					;~ $bdCount = $bdCount + UBound($wcdmArray)
					ConsoleWrite("wcdma900/2100 - " & $bdCount & @CRLF)
					If $bdCount = 0 Then
						$wkSht.Cells($q, 4).Value = "Not Support"
					Else
						$wkSht.Cells($q, 4).Value = _ArrayToString($wcdmArray, ",", 1)
					EndIf
				ElseIf $specID = "lte" Then
					Local $lteLists = $vXMLObj.selectNodes("//" & $bMode & "/spec[@division='4G']")
					Local $lteArray = [], $x
					$ilteArr = StringSplit(StringReplace($bandArray[$i], "LTE ", ""), "/")
					For $n in $lteLists
						If $n.getAttribute("supportstatus") = "Y" Then
							For $x = 1 To UBound($ilteArr) - 1
								If ($n.getAttribute("bandandmode") = "lte_" & $ilteArr[$x]) Then
									_ArrayAdd($lteArray, $n.getAttribute("bandandmode") & ":" & $n.getAttribute("outputpower"))
									$bdCount = $bdCount + 1
								EndIf
							Next
						EndIf
					Next
					;~ $bdCount = $bdCount + UBound($lteArray)
					ConsoleWrite("lte - " & $bdCount & @CRLF)
					;~ bandandmode 값과 outputpower를 합친 다음 비교한다???
					If $bdCount = 0 Then
						$wkSht.Cells($q, 4).Value = "Not Support"
					Else
						$wkSht.Cells($q, 4).Value = _ArrayToString($lteArray, ",", 1)
					EndIf
				ElseIf $specID = "5g" Then
					Local $gigaLists = $vXMLObj.selectNodes("//" & $bMode & "/spec[@division='5G']")
					Local $gigaArray = [], $y
					For $n in $gigaLists
						If $n.getAttribute("supportstatus") = "Y" Then
							For $y = 1 To UBound($i5gArr) -1
								If ($n.getAttribute("bandandmode") = $i5gArr[$y] & "_(FR1)") Then
									_ArrayAdd($gigaArray, StringReplace($n.getAttribute("bandandmode"), "_(FR1)", "") & ":" & $n.getAttribute("outputpower"))
									$bdCount = $bdCount + 1
								EndIf
							Next
						EndIf
					Next
					;~ $bdCount = $bdCount + UBound($gigaArray)
					ConsoleWrite("5g -" & $bdCount & @CRLF)
					;~ bandandmode 값과 outputpower를 합친다??
					$wkSht.Cells($q, 4).Value = _ArrayToString($gigaArray, ",", 1)
				Else
					If Not IsObj($vXMLObj.selectSingleNode("//" & $bMode & "/spec[@bandandmode='" & $specID & "']")) Then
						$wkSht.Cells($q, 4).Value = "Not Found"
					Else
						$specVal = $vXMLObj.selectSingleNode("//" & $bMode & "/spec[@bandandmode='" & $specID & "']").getAttribute("outputpower")
						If $lang = "Tur" And StringInStr($specID, "wifi5") Then
							If $vXMLObj.selectSingleNode("//" & $bMode & "/spec[@bandandmode='" & $specID & "']").getAttribute("supportstatus") = "Y" Then
								$turwfCnt = $turwfCnt + 1
							EndIf
						EndIf
						If $vXMLObj.selectSingleNode("//" & $bMode & "/spec[@bandandmode='" & $specID & "']").getAttribute("supportstatus") = "Y" Then
							$bdCount = $bdCount + 1
							$wkSht.Cells($q, 4).Value = $specVal
						ElseIf $Product = "Watch" And $vXMLObj.selectSingleNode("//" & $bMode & "/spec[@bandandmode='wirelesscharging']").getAttribute("supportstatus") = "N" Then
							;~ $bdCount = $bdCount + 1
							$wkSht.Cells($q, 4).Value = $specVal
						Else
							$wkSht.Cells($q, 4).Value = "Not Support"
						EndIf
						ConsoleWrite("etc -" & $bdCount & @CRLF)
					EndIf
				EndIf
			ElseIf $check = 2 Then
				ConsoleWrite($wkSht.Cells($q, 3).Value & @CRLF)
				;~ LTE, 5G 구분하여 인디자인 값 입력
				If $specID = "lte" Then
					Local $ilteVals = []
					For $x = 1 To UBound($ilteArr) - 1
						_ArrayAdd($ilteVals, "lte_" & $ilteArr[$x] & ":" & $bandArray[$i])
					Next
					$wkSht.Cells($q, 5).Value = _ArrayToString($ilteVals, ",", 1)
				ElseIf $specID = "5g" Then
					Local $i5gVals = []
					For $y = 1 To UBound($i5gArr) - 1
						_ArrayAdd($i5gVals, $i5gArr[$y] & ":" & $bandArray[$i])
					Next
					$wkSht.Cells($q, 5).Value = _ArrayToString($i5gVals, ",", 1)
				Else
					$wkSht.Cells($q, 5).Value = $bandArray[$i]
				EndIf
				;~ 비교 값 산출하기
				If ($specID = "wcdma900/wcdma2100") Then
					Local $valArray = StringSplit($wkSht.Cells($q, 4).Value, ",")
					$valArray = _ArrayUnique($valArray, 0, 1)

					If $valArray[0] = 1 Then
						$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($valArray[1], $bandArray[$i], $specUnit)
					ElseIf $wkSht.Cells($q, 4).Value = "Not Support" Then
						$wkSht.Cells($q, 7).Value = "Not Support"
					ElseIf $valArray[0] > 1 Then
						$wkSht.Cells($q, 7).Value = "Fail"
					EndIf
				ElseIf ($specID = "lte") Or ($specID = "5g") Then
					$wkSht.Cells($q, 7).Value = _ReturnCompareText($wkSht.Cells($q, 4).Value, $wkSht.Cells($q, 5).Value)
				ElseIf $specID = "nfc1" Or $specID = "wirelesscharging" Or $specID = "mst3_6khz" Then
					;~ $specVal, $bandArray[$i] 비교
					Local $oArray = StringRegExp(StringReplace($specVal, ",", "."), "(\d+[\.]\d+|\d+)([ ]?)+", 3)
					Local $sArray = StringRegExp(StringReplace($bandArray[$i], ",", "."), "(\d+[\.|\,]\d+|\d+)([ ]?)+", 3)
					
					If Not IsObj($vXMLObj.selectSingleNode("//" & $bMode & "/spec[@bandandmode='" & $specID & "']")) Then
						$wkSht.Cells($q, 7).Value = "Not Support"
					Else
						Local $specValid = $vXMLObj.selectSingleNode("//" & $bMode & "/spec[@bandandmode='" & $specID & "']").getAttribute("supportstatus")
						If $Product = "Watch" And $specID = "wirelesscharging" Then
							$wkSht.Cells($q, 7).Value = _ReturnNFCcompare($oArray, $sArray)
						Else
							If $specValid = "Y" Then
								$wkSht.Cells($q, 7).Value = _ReturnNFCcompare($oArray, $sArray)
							Else
								$wkSht.Cells($q, 7).Value = "Not Support"
							EndIf
						EndIf
					EndIf
				Else
					If Not IsObj($vXMLObj.selectSingleNode("//" & $bMode & "/spec[@bandandmode='" & $specID & "']")) Then
						$wkSht.Cells($q, 7).Value = "Not Support"
					Else
						Local $specValid = $vXMLObj.selectSingleNode("//" & $bMode & "/spec[@bandandmode='" & $specID & "']").getAttribute("supportstatus")
						If $specValid = "Y" Then
							$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($specVal, $bandArray[$i], $specUnit)
						Else
							$wkSht.Cells($q, 7).Value = "Not Support"
						EndIf
					EndIf
				EndIf
				_CheckFail($wkSht, $q)
				$q = $q + 1
			EndIf
		Next
		;~ 터키향 터키어인 경우, $turwfCnt 값이 1개 이상인 경우
		If $turwfCnt > 1 Then
			_FileWriteLog($hFile, $Lang & "향 WiFi 5 2개 이상으로 국가규제 WLAN 설명글 추가 검증")
			Local $wifi5 = $LangXMLObj.selectSingleNode("//turwifi5/items/item").text
			$wkSht.Cells($q, 3).Value = "Tur 국가규제 WLAN 설명 사양"
			$wkSht.Cells($q, 6).Value = $wifi5
			$wkSht.Cells($q, 5).Value = _returnStringMatch($ReadMerge, $wifi5)
			$wkSht.Cells($q, 7).Value = _ReturnCompareText($wkSht.Cells($q, 5).Value, $wifi5)
			_CheckFail($wkSht, $q)
			$q = $q + 1
		EndIf

		ConsoleWrite("Indesign Bandmode : " & $bdCount & @CRLF)
		If $bdCount <> $vbdCount Then
			With $wkSht
				.Cells($q, 3).Value = "Bandmode 사양 오류, 지원하는 Band 사양 개수 불일치"
				.Range(.Cells($q, 3), .Cells($q, 7)).Interior.ColorIndex = 22
				.Cells($q, 3).WrapText = False
			EndWith
			$q = $q + 1
		EndIf
	EndIf
	Return $q
EndFunc

Func _checkSARspec($hFile, $Product, $region, $Lang, $vXMLObj, $oXMLObj, $LangXMLObj, $ReadMerge, $wkSht, $q, $oExcel)
	If ($region = "EUB" And $Lang <> "Fre(EU)") Or ($region = "EUC" And $Lang <> "Fre(EU)") Or ($region = "EUA-EUH" And $Lang <> "Fre(EU)") Or ($region = "EUE" And $Lang <> "Rum") Or ($region = "CIS") Or ($region = "UKRAINE_ONLY") Or ($region = "MEA" And $Lang <> "Tur") Or ($region = "AFRICA" And $Lang <> "Eng") Or ($region = "LTN") Or ($region = "HongKong") Or ($Lang = "HongKong") Or ($region = "EU-alone" And $Lang <> "Fre(EU)" And $Lang <> "Rum") Or ($Lang = "Chi(Taiwan)") Then
		;~ SAR 전체 적용 안함
		_FileWriteLog($hFile, $region & ":" & $Lang & " SAR 검증 제외")
	ElseIf ($region = "SEA" And $Lang = "Tha") Then
		If $Lang = "Tha" Then
			;~ 태국어 액세서리 매뉴얼은 spec sheet의 headsar, body-wornsar 중 큰 값을 매뉴얼의 수치(only) 와 비교 - 김경란 팀장 확인
			Local $vBodyItem = $vXMLObj.selectSingleNode('//sars/spec[@item="body-wornsar"]').getAttribute("value")
			Local $vBodyValue = StringRegExpReplace($vBodyItem, "((\s)?W/kg)", "")
			Local $vHeadItem = $vXMLObj.selectSingleNode('//sars/spec[@item="headsar"]').getAttribute("value")
			Local $vHeadValue = StringRegExpReplace($vHeadItem, "((\s)?W/kg)", "")
			Local $vItem
			If $vBodyValue >= $vHeadValue Then
				$vItem = $vXMLObj.selectSingleNode('//sars/spec[@item="body-wornsar"]')
			ElseIf $vBodyValue < $vHeadValue Then
				$vItem = $vXMLObj.selectSingleNode('//sars/spec[@item="headsar"]')
			EndIf
			;~ 액세서리 매뉴얼은 Head, body 언급 없이 수치만 비교 (아래 body-wornwar는 위치 확인을 위한 문구임) - 김경란 팀장 확인
			Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='body-wornsar']").text
			Local $specUnit = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='body-wornsar']").getAttribute("unit")
			$wkSht.Cells($q, 3).Value = "SAR 사양"
		;~ ElseIf $Lang = "Chi(Taiwan)" Then
		;~ 	Local $vItem = $vXMLObj.selectSingleNode('//sars/spec[@division="Chi(Taiwan)"]')
		;~ 	Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='headsar']").text
		;~ 	Local $specUnit = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='headsar']").getAttribute("unit")
		;~ 	$wkSht.Cells($q, 3).Value = "Head SAR"
		EndIf
		
		Local $specValue = $vItem.getAttribute("value")
		
		If StringRegExpReplace($specValue, "((\s)?W/kg)", "") = "0" Then
			_FileWriteLog($hFile, "SAR 전용 사양 미지원")
			$wkSht.Cells($q, 4).Value = "Not Support"
			$wkSht.Cells($q, 7).Value = "Pass"
		Else
			$wkSht.Cells($q, 4).Value = $specValue
			
			;~ idmlMergedXML에서 사양 값을 찾는다.
			_FileWriteLog($hFile, $specLang & " " & $specValue)
			Local $idmlValue = _returnStringMatch($ReadMerge, $specLang & " " & $specValue)
			$wkSht.Cells($q, 5).Value = StringReplace($idmlValue, $specLang & " ", "")
			$wkSht.Cells($q, 6).Value = $specLang & " " & $specValue
			
			Local $oVal = StringReplace($specValue, "W/kg", "")
			Local $sVal = StringReplace($wkSht.Cells($q, 5).Value, $specUnit, "")
			$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($oVal, $sVal, $specUnit)
			_CheckFail($wkSht, $q)
		EndIf
		$q = $q + 1
	ElseIf ($region = "India" And $Lang = "Eng(India)") Then
		;~ 1g SAR, 이격거리 제외
		;~ _FileWriteLog($hFile, $region & ":" & $Lang & " 1g SAR 검증")
		;~ Local $vItem = $vXMLObj.selectSingleNode('//sars/spec[@division="Eng(India)"]')
		;~ Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='headsar']").text
		;~ Local $specValue = $vItem.getAttribute("value")
		;~ Local $specUnit = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='headsar']").getAttribute("unit")
		;~ $wkSht.Cells($q, 3).Value = "Head SAR 사양"
		;~ If StringRegExpReplace($specValue, "((\s)?W/kg)", "") = "0" Then
		;~ 	_FileWriteLog($hFile, "India Head SAR 전용 사양 미지원")
		;~ 	$wkSht.Cells($q, 4).Value = "Not Support"
		;~ 	$wkSht.Cells($q, 7).Value = "Pass"
		;~ Else
		;~ 	$wkSht.Cells($q, 4).Value = $specValue

		;~ 	;~ idmlMergedXML에서 사양 값을 찾는다.
		;~ 	Local $idmlValue = _StringBetween($ReadMerge, $specLang & '</p></td>', '</td>')
		;~ 	Local $relVal = _returnStringMatch($idmlValue[0], "(\d{1,}(\.|\,)\d{1,}\s.+(?=</p>))")
		;~ 	$wkSht.Cells($q, 5).Value = $relVal
		;~ 	Local $oVal = StringReplace($specValue, "W/kg", "")
		;~ 	Local $sVal = StringReplace($relVal, $specUnit, "")
		;~ 	$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($oVal, $sVal, $specUnit)
		;~ 	_CheckFail($wkSht, $q)
		;~ EndIf
		;~ $q = $q + 1
	ElseIf ($region = "Korea" And $Lang = "Kor") Then
		;~ 국판향 이격 거리 전용 사양
		Local $specLang = $LangXMLObj.selectSingleNode("//distance/items[@lang='" & $Lang & "']/item[@id='distance']").text
		If $Product = "Watch" Then
			$specLang = StringReplace(StringReplace($specLang, "1.5", "1.0"), "몸통", "머리") ;~ 1.0 cm, 몸통 -> 머리로 검색
		ElseIf $Product = "Hearable" Then
			$specLang = StringReplace(StringReplace($specLang, "1.5", "0"), "몸통", "머리") ;~ 1.0 cm, 몸통 -> 머리로 검색
		EndIf
		Local $idmlLists = $oXMLObj.selectNodes("//p[@class='Description']")
		Local $k
		$wkSht.Cells($q, 3).Value = "이격 거리 사양"
		$wkSht.Cells($q, 6).Value = $specLang
		For $k in $idmlLists
			If $k.text = $specLang Then
				$wkSht.Cells($q, 5).Value = $k.text
				$wkSht.Cells($q, 7).Value = _ReturnCompareText($specLang, $k.text)
			EndIf
		Next
		If $wkSht.Cells($q, 5).Value = "" Then
			$wkSht.Cells($q, 7).Value = "Fail"
			_CheckFail($wkSht, $q)
		EndIf
		$q = $q + 1
	ElseIf ($region = "China" And $Lang = "Chi") Or ($region = "SEA" And $Lang = "Chi") Then
		;~ 중국향 Body Worm SAR 전용 사양 검증
		;~ Const $chiSarVal = "2.0 W/kg"
		;~ Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='body-wornsar']").text
		;~ Local $vHeadVal = $vXMLObj.selectSingleNode("//sars/spec[@division='Common'][@item='headsar']").getAttribute("value")
		;~ Local $vBodyVal = $vXMLObj.selectSingleNode("//sars/spec[@division='Common'][@item='body-wornsar']").getAttribute("value")
		;~ ;~ ConsoleWrite("!!!!!!!!! " & $vHeadVal & ":" & $vBodyVal & @CRLF)
		;~ If StringRegExpReplace($vHeadVal, "((\s)?W/kg)", "") = "0" And StringRegExpReplace($vBodyVal, "((\s)?W/kg)", "") = "0" Then
		;~ 	_FileWriteLog($hFile, "중국향 SAR 사양 미지원")
		;~ 	$wkSht.Cells($q, 3).Value = "Body-worn SAR"
		;~ 	$wkSht.Cells($q, 4).Value = "Not Support"
		;~ 	$wkSht.Cells($q, 7).Value = "Pass"
		;~ Else
		;~ 	Local $idmlLists = $oXMLObj.selectNodes("//p[@class='UnorderList_3-CHN']")
		;~ 	Local $k
		;~ 	$wkSht.Cells($q, 3).Value = "Body-worn SAR"
		;~ 	$wkSht.Cells($q, 4).Value = $chiSarVal
		;~ 	$wkSht.Cells($q, 6).Value = $specLang
		;~ 	For $k in $idmlLists
		;~ 		If StringInStr($k.text, $specLang) Then
		;~ 			$wkSht.Cells($q, 5).Value = $k.text
		;~ 			Local $relVal = _returnStringMatch($k.text, "2.0")
		;~ 			$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($wkSht.Cells($q, 4).Value, $relVal, "W/kg")
		;~ 		EndIf
		;~ 	Next
		;~ 	If $wkSht.Cells($q, 5).Value = "" Then
		;~ 		$wkSht.Cells($q, 7).Value = "Fail"
		;~ 		_CheckFail($wkSht, $q)
		;~ 	EndIf
		;~ EndIf
		;~ $q = $q + 1
	ElseIf ($Lang <> "Fre(EU)") Then
		;~ validation에서 SAR 사양 확인
		_FileWriteLog($hFile, $region & ":" & $Lang & " SAR 검증")
		If $Product = "Hearable" Then
			Local $sarLists = $vXMLObj.selectSingleNode('//sars/spec[@item="body-wornsar"]')
			$vItem = "body-wornsar"
			Local $specEngValue = $LangXMLObj.selectSingleNode("//buds-sars/items[@lang='Eng']/item[@id='" & $vItem & "']").text
			Local $specLang = $LangXMLObj.selectSingleNode("//buds-sars/items[@lang='" & $Lang & "']/item[@id='" & $vItem & "']").text
			Local $specUnit = $LangXMLObj.selectSingleNode("//buds-sars/items[@lang='" & $Lang & "']/item[@id='" & $vItem & "']").getAttribute("unit")
			If Not IsObj($sarLists) Then
				SplashOff()
				MsgBox(0, "Error", "스펙 파일의 Bady-worn SAR 항목의 철자를 확인하세요.")
				_Excel_Close($oExcel)
				$oExcel = ""
				Return "Fail"
			EndIf
			Local $specValue = $sarLists.getAttribute("value")
			If StringRegExpReplace($specValue, "((\s)?W/kg)", "") = "0" Then
				_FileWriteLog($hFile, $specEngValue & "사양 미지원")
				$wkSht.Cells($q, 3).Value = $specEngValue
				$wkSht.Cells($q, 4).Value = "Not Support"
				$wkSht.Cells($q, 7).Value = "Pass"
			Else
				$wkSht.Cells($q, 3).Value = $specEngValue
				$wkSht.Cells($q, 4).Value = $specValue
				
				;~ idmlMergedXML에서 사양 값을 찾는다.
				Local $LangXML = $Scrpath & "\temp\" & $Lang & ".xml"
				Local $idmlValue = _StringBetween(FileRead($LangXML), $specLang & '</p></td>', '</td>')

				If $idmlValue = 0 Then
					$wkSht.Cells($q, 5).Value = "Not Found"
					$wkSht.Cells($q, 7).Value = "Fail"
					_CheckFail($wkSht, $q)
				Else
					Local $relVal = _returnStringMatch($idmlValue[0], "(\d{1,}(\.|\,)\d{1,}\s.+(?=</p>))")
					$wkSht.Cells($q, 5).Value = $relVal

					Local $oVal = StringReplace($specValue, "W/kg", "")
					Local $sVal = StringReplace($relVal, $specUnit, "")
					$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($oVal, $sVal, $specUnit)
					_CheckFail($wkSht, $q)
				EndIf
			EndIf
			$q = $q + 1
		Else
			Local $sarLists = $vXMLObj.selectNodes('//sars/spec')
			For $k in $sarLists
				If $k.getAttribute("division") = "Common" Then
					Local $vItem = $k.getAttribute("item")
					If Not ($vItem = "distance") Then ;~ headsar, body-wornsar 항목
						;~ validation의 반환 값을 Languages에서 찾는다.
						If $Product = "Watch" Then
							Switch $vItem
								Case "headsar"
									$vItem = "frontoffacesar"
								Case "body-wornsar"
									$vItem = "limbsar"
							EndSwitch
						EndIf
						Local $specEngValue = $LangXMLObj.selectSingleNode("//sars/items[@lang='Eng']/item[@id='" & $vItem & "']").text
						Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='" & $vItem & "']").text
						Local $specUnit = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='" & $vItem & "']").getAttribute("unit")
						Local $specValue = $k.getAttribute("value")
						If StringRegExpReplace($specValue, "((\s)?W/kg)", "") = "0" Then
							_FileWriteLog($hFile, $specEngValue & "사양 미지원")
							$wkSht.Cells($q, 3).Value = $specEngValue
							$wkSht.Cells($q, 4).Value = "Not Support"
							$wkSht.Cells($q, 7).Value = "Pass"
						Else
							$wkSht.Cells($q, 3).Value = $specEngValue
							$wkSht.Cells($q, 4).Value = $specValue
							
							;~ idmlMergedXML에서 사양 값을 찾는다.
							Local $idmlValue = _StringBetween($ReadMerge, $specLang & '</p></td>', '</td>')
							If $idmlValue = 0 Then
								$wkSht.Cells($q, 5).Value = "Not Found"
								$wkSht.Cells($q, 7).Value = "Fail"
								_CheckFail($wkSht, $q)
							Else
								Local $relVal = _returnStringMatch($idmlValue[0], "(\d{1,}(\.|\,)\d{1,}\s.+(?=</p>))")
								$wkSht.Cells($q, 5).Value = $relVal

								Local $oVal = StringReplace($specValue, "W/kg", "")
								Local $sVal = StringReplace($relVal, $specUnit, "")
								$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($oVal, $sVal, $specUnit)
								_CheckFail($wkSht, $q)
							EndIf
						EndIf
						$q = $q + 1

					ElseIf $vItem = "distance" Then ;~ 이격거리 사양
						If $Product = "Watch" Or $Product = "Hearable" Then
							Local $diSpec = "w-distance"
						Else
							Local $diSpec = "distance"
						EndIf
						$wkSht.Cells($q, 3).Value = "이격 거리 사양"
						Local $specEngValue = $LangXMLObj.selectSingleNode("//" & $diSpec & "/items[@lang='Eng']/item[@id='" & $vItem & "']").text
						;~ Wearable 일 경우 문구 변경하여 검색한다.
						Local $specLang = $LangXMLObj.selectSingleNode("//" & $diSpec & "/items[@lang='" & $Lang & "']/item[@id='" & $vItem & "']").text
						Local $specValue = $k.getAttribute("value")
						
						If $Product = "Watch" Then
							;~ 이격거리사양이 0.5가 아니면 specLang - 1.0cm 로 변경
							If $specValue = "1.0 cm" Or $specValue = "1.0cm" Then
								$specLang = StringReplace(StringRegExpReplace($specLang, "0(\.|,)5", "1$1%0"), "%", "")
								;~ Body Worm SAR -> Front of face SAR 로 변경
								Local $strBody = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='body-wornsar']").text
								Local $strFof = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='frontoffacesar']").text
								$specLang = StringReplace($specLang, $strBody, $strFof)
							EndIf
						EndIf

						If StringRegExpReplace($specValue, "((\s)?mm)", "") = "0" Or $specLang = "N/A" Then
							_FileWriteLog($hFile, "이격 거리 사양 미지원")
							$wkSht.Cells($q, 4).Value = "Not Support"
							$wkSht.Cells($q, 7).Value = "Pass"
						Else
							$wkSht.Cells($q, 4).Value = $specValue
							$wkSht.Cells($q, 6).Value = $specLang

							If StringInStr($specValue, "cm") then
								Local $findText = $specLang
							Else
								Local $findText = StringRegExpReplace($specLang, "((\d)(\.|,)(\d))", "$1$2" & StringReplace($specValue, " mm", ""))
							EndIf
							ConsoleWrite($findText & @CRLF)
							Local $idmlValue = _returnStringMatch($ReadMerge, $findText)
							$wkSht.Cells($q, 5).Value = $idmlValue

							$wkSht.Cells($q, 7).Value = _ReturnCompareText($idmlValue, $findText)
							_CheckFail($wkSht, $q)
						EndIf
						$q = $q + 1
					EndIf
				EndIf
			Next
		EndIf
	EndIf
	If $Lang = "Fre(EU)" And $region = "EUB" Then
		ConsoleWrite($Lang & " 전용 SAR 검증")
		Local $vItem = $vXMLObj.selectSingleNode("//sars/spec[@division='Fre(EU)']")
		If $Product = "Hearable" Then
			Local $specLang = $LangXMLObj.selectSingleNode("//buds-sars/items[@lang='Fre(EU)']/item[@id='body-wornsar']").text
			Local $specUnit = $LangXMLObj.selectSingleNode("//buds-sars/items[@lang='Fre(EU)']/item[@id='body-wornsar']").getAttribute("unit")
			Local $specValue = $vItem.getAttribute("value")
		Else
			Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='Fre(EU)']/item[@id='limbsar1']").text
			Local $specUnit = $LangXMLObj.selectSingleNode("//sars/items[@lang='Fre(EU)']/item[@id='limbsar1']").getAttribute("unit")
			Local $specValue = $vItem.getAttribute("value")
		EndIf
		$wkSht.Cells($q, 3).Value = $specLang
		If StringRegExpReplace($specValue, "((\s)?W/kg)", "") = "0" Then
			_FileWriteLog($hFile, "Fre(EU) Limb SAR 미지원")
			$wkSht.Cells($q, 4).Value = "Not Support"
			$wkSht.Cells($q, 7).Value = "Pass"
		Else
			$wkSht.Cells($q, 4).Value = $specValue
			;~ idmlMergedXML에서 사양 값을 찾는다.
			Local $idmlValue = _StringBetween($ReadMerge, $specLang & '</p></td>', '</td>')
			If $idmlValue = 0 Then
				_FileWriteLog($hFile, $Lang & " : 전용 SAR 사양 찾을 수 없음")
				$wkSht.Cells($q, 5).Value = "Not Found"
				$wkSht.Cells($q, 7).Value = "Fail"
			Else
				Local $relVal = _returnStringMatch($idmlValue[0], "(\d{1,}(\.|\,)\d{1,}\s.+(?=</p>))")
				$wkSht.Cells($q, 5).Value = $relVal
				
				If $relVal = "Not Found" Then
					$wkSht.Cells($q, 7).Value = "Fail"
				Else
					Local $oVal = StringReplace(StringReplace($specValue, ",", "."), "W/kg", "")
					Local $sVal = StringReplace($relVal, $specUnit, "")
					$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($oVal, $sVal, $specUnit)
				EndIf
			EndIf
			_CheckFail($wkSht, $q)
		EndIf
		$q = $q + 1
	EndIf

	If $Lang = "Fre(EU)" And $Product = "Watch" And $region = "EUB" Then ;~ Face of SAR 검증
		ConsoleWrite($Lang & " 전용 Face of SAR 검증")
		If Not IsObj($vXMLObj.selectSingleNode("//sars/spec[@item='frontoffacesar']")) Then
			Local $vItem = $vXMLObj.selectSingleNode("//sars/spec[@item='headsar']")
		Else
			Local $vItem = $vXMLObj.selectSingleNode("//sars/spec[@item='frontoffacesar']")
		EndIf
		Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='Fre(EU)']/item[@id='frontoffacesar']").text
		Local $specUnit = $LangXMLObj.selectSingleNode("//sars/items[@lang='Fre(EU)']/item[@id='frontoffacesar']").getAttribute("unit")
		Local $specValue = $vItem.getAttribute("value")

		$wkSht.Cells($q, 3).Value = $specLang
		If StringRegExpReplace($specValue, "((\s)?W/kg)", "") = "0" Then
			_FileWriteLog($hFile, "Fre(EU) Face of SAR 미지원")
			$wkSht.Cells($q, 4).Value = "Not Support"
			$wkSht.Cells($q, 7).Value = "Pass"
		Else
			$wkSht.Cells($q, 4).Value = $specValue
			;~ idmlMergedXML에서 사양 값을 찾는다.
			Local $idmlValue = _StringBetween($ReadMerge, $specLang & '</p></td>', '</td>')
			If $idmlValue = 0 Then
				_FileWriteLog($hFile, $Lang & " : 전용 SAR 사양 찾을 수 없음")
				$wkSht.Cells($q, 5).Value = "Not Found"
				$wkSht.Cells($q, 7).Value = "Fail"
			Else
				Local $relVal = _returnStringMatch($idmlValue[0], "(\d{1,}(\.|\,)\d{1,}\s.+(?=</p>))")
				$wkSht.Cells($q, 5).Value = $relVal
				
				If $relVal = "Not Found" Then
					$wkSht.Cells($q, 7).Value = "Fail"
				Else
					Local $oVal = StringReplace(StringReplace($specValue, ",", "."), "W/kg", "")
					Local $sVal = StringReplace($relVal, $specUnit, "")
					$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($oVal, $sVal, $specUnit)
				EndIf
			EndIf
			_CheckFail($wkSht, $q)
		EndIf
		$q = $q + 1
		;~ 이격거리사양
		Local $vItem = $vXMLObj.selectSingleNode("//sars/spec[@item='distance']")
		$wkSht.Cells($q, 3).Value = "이격 거리 사양"
		Local $specEngValue = $LangXMLObj.selectSingleNode("//w-distance/items[@lang='Eng']/item[@id='distance']").text
		Local $specLang = $LangXMLObj.selectSingleNode("//w-distance/items[@lang='" & $Lang & "']/item[@id='distance']").text
		Local $specValue = $vItem.getAttribute("value")
		If $specValue = "1.0 cm" Or $specValue = "1.0cm" Then
			$specLang = StringReplace(StringRegExpReplace($specLang, "0(\.|,)5", "1$1%0"), "%", "")
			;~ Body Worm SAR -> Front of face SAR 로 변경
			Local $strBody = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='body-wornsar']").text
			Local $strFof = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $Lang & "']/item[@id='frontoffacesar']").text
			$specLang = StringReplace($specLang, $strBody, $strFof)
		EndIf
		If StringRegExpReplace($specValue, "((\s)?mm)", "") = "0" Or $specLang = "N/A" Then
			_FileWriteLog($hFile, "이격 거리 사양 미지원")
			$wkSht.Cells($q, 4).Value = "Not Support"
			$wkSht.Cells($q, 7).Value = "Pass"
		Else
			$wkSht.Cells($q, 4).Value = $specValue
			$wkSht.Cells($q, 6).Value = $specLang

			If StringInStr($specValue, "cm") then
				Local $findText = $specLang
			Else
				Local $findText = StringRegExpReplace($specLang, "((\d)(\.|,)(\d))", "$1$2" & StringReplace($specValue, " mm", ""))
			EndIf
			ConsoleWrite($findText & @CRLF)
			Local $idmlValue = _returnStringMatch($ReadMerge, $findText)
			$wkSht.Cells($q, 5).Value = $idmlValue
			$wkSht.Cells($q, 7).Value = _ReturnCompareText($idmlValue, $findText)
			_CheckFail($wkSht, $q)
		EndIf
		$q = $q + 1
	EndIf
	Return $q
EndFunc

Func _checkModelName($hFile, $vXMLObj, $oXMLObj, $wkSht, $q)
	Local $vModelName = $vXMLObj.selectSingleNode('//model').getAttribute('name')
	Local $oModelNameLists = $oXMLObj.selectNodes("//p[@class='ModelName-Cover']")
	Local $x, $oModelArray = []
	For $x in $oModelNameLists
		_ArrayAdd($oModelArray, $x.text)
	Next
	_FileWriteLog($hFile, $vModelName & " 모델명 사양 검증")

	$wkSht.Cells($q, 3).Value = "모델명 사양"
	$wkSht.Cells($q, 4).Value = $vModelName
	$wkSht.Cells($q, 5).Value = _ArrayToString(_ArrayUnique($oModelArray), "", 1)
	$wkSht.Cells($q, 7).Value = _ReturnCompareText($vModelName, $wkSht.Cells($q, 5).Value)
	_CheckFail($wkSht, $q)
	$q = $q + 1 ;~ Row를 더한다.
	Return $q
EndFunc

Func _checkGeneral($hFile, $vXMLObj, $wkSht, $manualN)
	Local $vProdType = $vXMLObj.selectSingleNode('//product').getAttribute('type')
	Local $sOpticType = $vXMLObj.selectSingleNode('//optical').getAttribute('type')
	_FileWriteLog($hFile, $manualN & ":" & $vProdType)
	$wkSht.Cells(3, 3).Value = $manualN
	$wkSht.Cells(4, 3).Value = $vProdType
	$wkSht.Cells(5, 3).Value = $sOpticType
EndFunc

Func _checkLangs($commonPath, $Lang)
	Local $LangData = $commonPath & "\resource\langlists.txt"
	Local $LangArray = StringSplit(FileReadLine($LangData, 1), ",", 0)
	;~ _ArrayDisplay($LangArray)
	Local $myResult = _ArraySearch($LangArray, $Lang, 0, 0, 1, 0)
	Return $myResult
EndFunc