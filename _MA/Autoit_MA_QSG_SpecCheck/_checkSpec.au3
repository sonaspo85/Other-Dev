;~ 모바일 폰, 태블릿 - 단말기 스펙 검증, 매뉴얼 파일명과 출향지, 프로그램 버전 정보를 받아와 엑셀 리포트 파일에 정보를 입력한다.
;~ 버전 정보 또한 엑셀 리포트 파일에 정보를 기입하여 최신 프로그램 버전인지 확인하기 위함

Func checkSpec($manualN, $Area, $ver)
	Global $Scrpath = FileGetShortName(@ScriptDir)
	Local $logfile = $Scrpath & '\log.txt' ;~ 각 단계마다 로그 파일을 작성해 실패할 경우 어느 단계에서 프로세스가 중단되었는지 확인하기 위함
	Local $hFile = FileOpen($logfile, 1)
	_FileWriteLog($hFile, $manualN & ":" & $Area)
	Local $region = $Area
	;~ 필요한 정보를 변수에 저장하여 메모리로 불러온다. ==============================================
	Local $mergedXML = $Scrpath & "\temp\" & "idmlMergedXML.xml"
	Local $specXML = $Scrpath & "\xsls\" & "Validation.xml"
	Local $langXML = $Scrpath & "\xsls\" & "languages.xml" ;~ resource 폴더 안에 spec2xml-data.xlsm 파일을 xml 파일로 저장한 파일
	;~ spec2xml-data.xlsm 파일 업데이트 시 languages.xml 파일을 추출하여 배포하도록 한다.
	;~ 다음 링크 참조 - https://www.notion.so/asttcs/QSG-SpeckChecker-MA-36fa17c6d0f54b0dbe4af6443a77c3ab#abb71651cf6045679e86ff5a5fa60d45
	Local $tempXslx = $Scrpath & "\resource\" & "template.xlsx" ;~ 검증 리포트를 만들 엑셀 파일
	Local $ReadMerge = FileRead($mergedXML) ;~ 일부 사양 검증 시 인디자인의 검증 내용을 xml로 불러오기 어려운 경우 텍스트를 불러와 검증하기 위함
	;~ ==============================================================================================

	Local $oXMLObj = ObjCreate('Microsoft.XMLDOM')
	
	;~ idmlMergedXML.xml 파일이 없을 경우 에러 값 반환 ===============================================
	If FileExists($mergedXML) = 1 Then
		;~ Nothing
	Else
		Return "NoneMerge";
	EndIf
	;~ ===============================================================================================
	
	;~ 문서에 포함된 출향지, 언어 리스트를 확인한다.
	$oXMLObj.load($mergedXML) ;~ xml 파일을 오브젝트로 로드
	Local $XMLNodeList = $oXMLObj.selectNodes('//doc') ;~ xml doc 요소 기준으로 언어별 인디자인 콘텐츠를 불러오도록 설정
	Local $i, $langList = [], $Langs, $j, $CheckVal

	For $i in $XMLNodeList
		$Langs = $i.getAttribute("lang") ;~ doc 요소의 lang 속성 값으로 언어별 사양 전개
		If $Langs = "QSG" Or $Langs = "Cover" Then
			;~ QSG, Cover의 경우 Skip
		Else
			_ArrayAdd($langList, $Langs) ;~ 검증할 언어를 Arry에 저장
		EndIf
	Next

	Local $LangLists = _ArrayUnique($langList) ;~ 중복되는 언어 정리
	;~ _ArrayDisplay($LangLists)
	;~ 언어에 따라 스펙 사양 데이터를 검증한다.
	;~ 언어 값이 올바른지 확인한다.
	For $j = 2 To UBound($LangLists) - 1
		;~ resource\langlists.txt 파일을 통해 사용하는 언어의 파일명이 올바른지 확인한다.
		$CheckVal = _checkLang($LangLists[$j])
		If $CheckVal = -1 Then
			_FileWriteLog($hFile, $LangLists[$j] & " 언어 표기가 올바르지 않음, 프로세스 중단")
			Return "WrongLang"
		EndIf
	Next

	;~ 검증 리포트를 작성할 엑셀 파일을 오픈 ==================================================
	Local $oExcel = _Excel_Open(True, False, False) ;~ 엑셀 오픈 autoit 함수, 참조: https://www.autoitscript.com/autoit3/docs/libfunctions/_Excel_Open.htm
	Local $templateWkb = _Excel_BookOpen($oExcel, $tempXslx, True, True) ;~ 엑셀 파일 오픈 autoit 함수, 참조: https://www.autoitscript.com/autoit3/docs/libfunctions/_Excel_BookOpen.htm
	;~ =======================================================================================
	Local $wkSht = $templateWkb.Sheets(1)
	$wkSht.Cells(1, 7).Value = $ver ;~ 현재 프로그램 버전 입력
	
	;~ validation.xml 파일과 languages.xml 파일을 오브젝트로 로드 ==============================
	Local $vXMLObj = ObjCreate('Microsoft.XMLDOM')
	Local $LangXMLObj = ObjCreate('Microsoft.XMLDOM')
	$vXMLObj.load($specXML) ;~ Spec XML 파일
	$LangXMLObj.load($langXML) ;~ languages.xml 파일
	;~ ========================================================================================

	;~ 모바일인지 태블릿인지 확인, 이후 이 사양에 따라 검증 내용 달라짐
	Local $vProdType = $vXMLObj.selectSingleNode('//product').getAttribute('type')
	;~ 광학식, 초음파식, 필름 여부에 따라 검증 내용 달라짐, 조건 값
	Local $sOpticType = $vXMLObj.selectSingleNode('//optical').getAttribute('type')
	
	$wkSht.Cells(3, 3).Value = $manualN ;~ 모델명 입력
	$wkSht.Cells(4, 3).Value = $vProdType ;~ 제품 유형 입력
	$wkSht.Cells(5, 3).Value = $sOpticType ;~ 광학식, 초음파식 사양 입력
	_FileWriteLog($hFile, $manualN & ":" & $vProdType & ":" & $sOpticType)

	Local $q = 8 ;~ 사양을 입력하는 엑셀 리포트 파일의 첫 행
	Local $BenTA = "0" ;~ 벵갈어 TA 검증용
	
	For $j = 2 To UBound($LangLists) - 1 ;~ 언어 별로 검증 실행
		_FileWriteLog($hFile, $LangLists[$j] & " 검사 시작...")
		ConsoleWrite($LangLists[$j] & " test start ..." & @CRLF)
		;~ 언어명 Template에 입력
		$wkSht.Cells($q, 2).Value = $LangLists[$j]

		Local $vModelName = $vXMLObj.selectSingleNode('//model').getAttribute('name') ;~ validation.xml 에서 모델명 가져오기
		Local $oModelNameLists = $oXMLObj.selectNodes("//p[@class='ModelName-Cover']") ;~ 모델명으로 이용하는 문장 스타일
		Local $x, $oModelArray = []
		For $x in $oModelNameLists
			;~ 모델명이 여러개 있을 수 있기 때문에 array에 추가
			_ArrayAdd($oModelArray, $x.text)
		Next
		;~ 모델명 Template에 입력 ======================================================================================
		_FileWriteLog($hFile, $vModelName & " 모델명 사양 검증")
		$wkSht.Cells($q, 3).Value = "모델명 사양"
		$wkSht.Cells($q, 4).Value = $vModelName
		$wkSht.Cells($q, 5).Value = _ArrayToString(_ArrayUnique($oModelArray), "", 1) ;~ 모델명 array를 문자열로 변환
		$wkSht.Cells($q, 7).Value = _ReturnCompareText($vModelName, $wkSht.Cells($q, 5).Value) ;~ 텍스트를 비교하는 함수
		_CheckFail($wkSht, $q) ;~ 입력한 값들이 Fail 일 경우 행의 색상 변경
		$q = $q + 1 ;~ Row를 더한다. 검증 리포트에서 다음 행에 입력하기 위함
		;~ =============================================================================================================
		
		;~ 구성품 정보 확인 ============================================================================================
		;~ Languages.xml : resource폴더의 spec2xml-data.xlsm에서 추출한 데이터
		;~ validation.xml : Spec 컨트롤에 입력한 엑셀 파일에서 추출한 데이터
		;~ idmlMergedXML.xml : idml을 merged 한 파일
		;~ 언어명.xml : idmlMergedXML.xml에서 생성된 언어별 merged.xml 파일명
		_FileWriteLog($hFile, "구성품 정보 사양 검증")
		;~ validation.xml 에서 구성품 정보 읽기
		Local $packLists = $vXMLObj.selectNodes('//packages/spec') 
		Local $k, $n, $l
		
		$wkSht.Cells($q, 3).Value = "패키지 사양" ;~ 리포트에 검증 사양 항목 입력
		
		;~ validation.xml 파일의 $packLists 객체를 loop하여 검증 실행
		For $k in $packLists
			;~ son221014 st
			Local $division = $k.getAttribute("division")
			Local $Bool = $k.getAttribute("supportstatus")

			If ($LangLists[$j] = "Ben" And $division = "USB power adaptor") Then
				$Bool = "Y"
			EndIf

			;~ Languages 데이터를 인디자인에서 찾는다.
			;~ 구성품 항목은 xml 데이터로 검증하기 어려워 텍스트로 로드한 다음 언어 별로 xml 파일을 만들어 검증을 진행한다.
			;~ 언어는 다르지만 같은 텍스트 값을 사용하는 경우가 있음, 예 - 보스니아 계열 언어
			Local $LangData = _StringBetween($ReadMerge, '<doc lang="' & $LangLists[$j] & '">', '</doc>')
			;~ 언어명.xml 로드
			Local $LangXML = $Scrpath & "\temp\" & $LangLists[$j] & ".xml"
			_FileCreate($LangXML)
			FileWriteLine($LangXML, '<?xml version="1.0" encoding="UTF-8"?>')
			FileWriteLine($LangXML, '<root>')
			FileWriteLine($LangXML, $LangData[0])
			FileWriteLine($LangXML, '</root>')
			FileClose($LangXML)
			Local $oTempXML = ObjCreate('Microsoft.XMLDOM')
			$oTempXML.load($LangXML)
			
			Local $idmlLists = $oTempXML.selectNodes("//p")

			Local $packItem = $k.getAttribute("item")
			Local $LangItems = $LangXMLObj.selectNodes("//packages/items[@lang='" & $LangLists[$j] & "']/item")
			
			;~ If ($k.getAttribute("supportstatus") = "Y")  Then
			If ($Bool = "Y")  Then ;~ 지원하는 항목인지 확인 후 검증 실행
				$wkSht.Cells($q, 4).Value = $k.getAttribute("division")
				_FileWriteLog($hFile, $k.getAttribute("division"))
				;~ Local $packItem = $k.getAttribute("item")
				;~ Validation에서 찾은 아이템 값을 Languages 데이터에서 언어에 맞춰 찾는다.
				;~ Languages.xml 에서 해당하는 언어의 item요소 추출
				;~ Local $LangItems = $LangXMLObj.selectNodes("//packages/items[@lang='" & $LangLists[$j] & "']/item")
				;~ Languages.xml에서 추출한 item요소들을 for문 으로 돌림
				For $n in $LangItems
					;~ id 값이 item 값과 같은지 찾는다.
					Local $LangItem = $n.getAttribute("id")
					;~ Validation.xml 의 @item값과 Languages.xml의 @id값이 같은 경우
					If $packItem = $LangItem Then
						$wkSht.Cells($q, 6).Value = $n.text
						For $l in $idmlLists
							;~ UnorderList_1 또는 Description-Cell 문장 스타일을 사용하는 텍스트만 해당
							If StringInStr($l.getAttribute("class"), "UnorderList_1") Or StringInStr($l.getAttribute("class"), "Description-Cell") Then
								If ($n.text = $l.text) Then
									ConsoleWrite($n.text & " : " & $l.text & @CRLF)
									$wkSht.Cells($q, 5).Value = $l.text
									$wkSht.Cells($q, 7).Value = _ReturnCompareText($l.text, $n.text)
									ExitLoop ;~ validation과 인디자인 데이터가 일치하면 loop를 정지, 그렇지 않으면 Not Found를 계속 기록하게 됨
								Else
									$wkSht.Cells($q, 5).Value = "Not Found"
									$wkSht.Cells($q, 7).Value = "Fail"
								EndIf
							EndIf
						Next
						_CheckFail($wkSht, $q)
					EndIf
				Next
				$q = $q + 1 ;~ Row를 더한다.
			ElseIf ($Bool = "N") then
				If ($region = "SWA" And $LangLists[$j] = "Ben") Then
					For $n in $LangItems
						;~ id 값이 item 값과 같은지 찾는다.
						Local $LangItem = $n.getAttribute("id")
						;~ Validation.xml 의 @item값과 Languages.xml의 @id값이 같은 경우
						;~ 벵갈어 USB power adapter 무조건 포함
						If $LangItem = "usbpoweradapter" Then
							If $packItem = $LangItem Then
								$wkSht.Cells($q, 6).Value = $n.text
								For $l in $idmlLists
									;~ UnorderList_1 또는 Description-Cell 문장 스타일을 사용하는 텍스트만 해당
									If StringInStr($l.getAttribute("class"), "UnorderList_1") Or StringInStr($l.getAttribute("class"), "Description-Cell") Then
										If ($n.text = $l.text) Then
											ConsoleWrite($n.text & " : " & $l.text & @CRLF)
											$wkSht.Cells($q, 4).Value = "USB power adapter"
											$wkSht.Cells($q, 5).Value = $l.text
											$wkSht.Cells($q, 7).Value = _ReturnCompareText($l.text, $n.text)
											ExitLoop ;~ validation과 인디자인 데이터가 일치하면 loop를 정지, 그렇지 않으면 Not Found를 계속 기록하게 됨
										Else
											$wkSht.Cells($q, 4).Value = "USB power adapter"
											$wkSht.Cells($q, 5).Value = "Not Found"
											$wkSht.Cells($q, 7).Value = "Fail"
										EndIf
									EndIf
								Next
								_CheckFail($wkSht, $q)
							EndIf
							$BenTA = "1"
						EndIf
					Next
				EndIf
			EndIf
		Next
		If ($BenTA = "1") Then
			$q = $q + 1
			$BenTA = "0"
		EndIf
		;~ =============================================================================================================

		;~ Green issue 문구 확인 =========================================================================================
		If $region = "SWA" And $LangLists[$j] = "Ben" Then
			_FileWriteLog($hFile, $LangLists[$j] & " Green issue")
			Local $defaultText = "চার্জারটি বৈদ্যুতিক সকেট এর সন্নিকটে এবং চার্জ করার সময় সহজে নাগালে পাওয়া যায় এমনভাবে রাখা উচিত৷"

			;~ _StringBetween : 두 문자열 구분 기호 사이의 문자열 찾기  
			;~ https://www.autoitscript.com/autoit3/docs/libfunctions/_StringBetween.htm
			Local $LangData = _StringBetween($ReadMerge, '<doc lang="' & $LangLists[$j] & '">', '</doc>')
            
			Local $LangXML = $Scrpath & "\temp\" & $LangLists[$j] & ".xml"
			Local $oTempXML = ObjCreate('Microsoft.XMLDOM')
            $oTempXML.load($LangXML)
            
			Local $idmlLists = $oTempXML.selectNodes("//p")
           	$wkSht.Cells($q, 3).Value = "Green issue"
			For $l in $idmlLists
				If StringInStr($l.getAttribute("class"), "UnorderList_1") Or StringInStr($l.getAttribute("class"), "Description-Cell") Then
					If ($defaultText = $l.text) Then
						ConsoleWrite($defaultText & " : " & $l.text & @CRLF)
						$wkSht.Cells($q, 5).Value = $l.text
						$wkSht.Cells($q, 6).Value = $defaultText
						$wkSht.Cells($q, 7).Value = _ReturnCompareText($l.text, $defaultText)
						ExitLoop ;~ validation과 인디자인 데이터가 일치하면 loop를 정지, 그렇지 않으면 Not Found를 계속 기록하게 됨
					Else
						$wkSht.Cells($q, 5).Value = "Not Found"
						$wkSht.Cells($q, 6).Value = $defaultText
						$wkSht.Cells($q, 7).Value = "Fail"
					EndIf
				Else
					$wkSht.Cells($q, 5).Value = "Not Found"
					$wkSht.Cells($q, 6).Value = $defaultText
					$wkSht.Cells($q, 7).Value = "Fail"
				EndIf
			Next
			_CheckFail($wkSht, $q)
			$q = $q + 1
		EndIf
		;~ =============================================================================================================
		
		;~ 지문인식 확인 ===============================================================================================
		_FileWriteLog($hFile, "지문인식 사양 검증")
		;~ validation에서 지문인식 방식 확인
		Local $vOptical = $vXMLObj.selectSingleNode('//optical').getAttribute('type')
		If $vOptical = "미지원" Then
			;~ Nothing
		ElseIf $vOptical = "광학식" Then
			$wkSht.Cells($q, 3).Value = "지문인식 광학식"
			_FileWriteLog($hFile, "광학식 검증")
			;~ 검증데이터 입력, languages에서 광학식 언어 데이터를 가져온다.
			$type = "optical"
			SpecOptical($LangLists[$j], $LangXMLObj, $oXMLObj, $wkSht, $q, $type) ;~ 지문인식 사양 검증 함수, $type에 따라 검증 텍스트 값이 다름
		ElseIf $vOptical = "초음파식" Then
			$wkSht.Cells($q, 3).Value = "지문인식 초음파식"
			_FileWriteLog($hFile, "초음파식")
			$type = "ultrawave"
			SpecOptical($LangLists[$j], $LangXMLObj, $oXMLObj, $wkSht, $q, $type)
		ElseIf $vOptical = "초음파식-보호필름o" Or $vOptical = "초음파식-보호필름x" Then
			$wkSht.Cells($q, 3).Value = $vOptical
			$wkSht.Cells($q, 5).Value = "Not Found"
			$wkSht.Cells($q, 7).Value = "Fail"
		EndIf
		_CheckFail($wkSht, $q)
		$q = $q + 1 ;~ Row를 더한다.
		;~ =============================================================================================================

		;~ SAR 검증 ====================================================================================================
		;~ SAR 확인, 출향지, 언어에 따라 적용 유무 확인 필요 
		;~ SAR 적용 안하는 출향지 EU (Fre(EU)제외), CIS, MEA(Fre, Tur 제외), 
		;~ 이격거리 제외 출향지 LTN-Spa(LTN), SEA-Tha, Taiwan-Chi(Taiwan), China-Chi, HongKong-HongKong
		;~ MergeXML 파일 txt로 읽어들인다.
		_FileWriteLog($hFile, "SAR 사양 검증")
		If ($region = "EUB" And $LangLists[$j] <> "Fre(EU)") Or ($region = "EUC") Or ($region = "EUA-EUH" And $LangLists[$j] <> "Fre(EU)") Or ($region = "EUE" And $LangLists[$j] <> "Rum") Or ($region = "CIS") Or ($region = "MEA" And $LangLists[$j] <> "Tur") Or ($region = "AFRICA" And $LangLists[$j] <> "Eng") Or ($region = "LTN") Or ($region = "HongKong") Or ($region = "EU-alone" And $LangLists[$j] <> "Fre(EU)" And $LangLists[$j] <> "Rum") Then
			;~ SAR 전체 적용 안함
			_FileWriteLog($hFile, $region & ":" & $LangLists[$j] & " SAR 검증 제외")

		ElseIf ($region = "SEA" And $LangLists[$j] = "Tha") Or ($region = "Taiwan" And $LangLists[$j] = "Chi(Taiwan)") Then
			_FileWriteLog($hFile, $region & ":" & $LangLists[$j] & " 전용 SAR 검증")
			;~ Body-worn SAR 수치만 기재, 이격 거리 제외
			If $LangLists[$j] = "Tha" Then
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
				Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $LangLists[$j] & "']/item[@id='body-wornsar']").text
				Local $specUnit = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $LangLists[$j] & "']/item[@id='body-wornsar']").getAttribute("unit")
				$wkSht.Cells($q, 3).Value = "SAR 사양"
			ElseIf $LangLists[$j] = "Chi(Taiwan)" Then
				Local $vItem = $vXMLObj.selectSingleNode('//sars/spec[@division="Chi(Taiwan)"]')
				Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $LangLists[$j] & "']/item[@id='headsar']").text
				Local $specUnit = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $LangLists[$j] & "']/item[@id='headsar']").getAttribute("unit")
				$wkSht.Cells($q, 3).Value = "Head SAR"
			EndIf
			Local $specValue = $vItem.getAttribute("value")
			If StringRegExpReplace($specValue, "((\s)?W/kg)", "") = "0" Then
				_FileWriteLog($hFile, "SAR 전용 사양 미지원")
				$wkSht.Cells($q, 4).Value = "Not Support"
				$wkSht.Cells($q, 7).Value = "-"
			Else
				$wkSht.Cells($q, 4).Value = $specValue
				
				;~ idmlMergedXML에서 사양 값을 찾는다.
				_FileWriteLog($hFile, $specLang & " " & $specValue)
				Local $idmlValue = _returnStringMatch($ReadMerge, $specLang & " " & $specValue) ;~ 문자열과 일치하는 값을 돌려주는 함수
				$wkSht.Cells($q, 5).Value = StringReplace($idmlValue, $specLang & " ", "")
				$wkSht.Cells($q, 6).Value = $specLang & " " & $specValue
				
				Local $oVal = StringReplace($specValue, "W/kg", "")
				Local $sVal = StringReplace($wkSht.Cells($q, 5).Value, $specUnit, "")
				$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($oVal, $sVal, $specUnit)
				_CheckFail($wkSht, $q)
			EndIf
			$q = $q + 1
			
		ElseIf ($region = "India" And $LangLists[$j] = "Eng(India)") Then
			;~ 1g SAR, 이격거리 제외
			_FileWriteLog($hFile, $region & ":" & $LangLists[$j] & " 1g SAR 검증")
			Local $vItem = $vXMLObj.selectSingleNode('//sars/spec[@division="Eng(India)"]')
			Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $LangLists[$j] & "']/item[@id='headsar']").text
			Local $specValue = $vItem.getAttribute("value")
			Local $specUnit = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $LangLists[$j] & "']/item[@id='headsar']").getAttribute("unit")
			$wkSht.Cells($q, 3).Value = "Head SAR 사양"
			If StringRegExpReplace($specValue, "((\s)?W/kg)", "") = "0" Then
				_FileWriteLog($hFile, "India Head SAR 전용 사양 미지원")
				$wkSht.Cells($q, 4).Value = "Not Support"
				$wkSht.Cells($q, 7).Value = "-"
			Else
				$wkSht.Cells($q, 4).Value = $specValue

				;~ idmlMergedXML에서 사양 값을 찾는다.
				Local $idmlValue = _StringBetween($ReadMerge, $specLang & '</p></td>', '</td>')
				If $idmlValue = 0 Then
					$wkSht.Cells($q, 5).Value = "Not Found"
					$wkSht.Cells($q, 7).Value = "Fail"
				Else
					Local $relVal = _returnStringMatch($idmlValue[0], "(\d{1,}(\.|\,)\d{1,}\s.+(?=</p>))")
					$wkSht.Cells($q, 5).Value = $relVal
					Local $oVal = StringReplace($specValue, "W/kg", "")
					Local $sVal = StringReplace($relVal, $specUnit, "")
					$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($oVal, $sVal, $specUnit)
				EndIf
				_CheckFail($wkSht, $q)
			EndIf
			$q = $q + 1
		ElseIf ($region = "Korea" And $LangLists[$j] = "Kor") Then
			;~ 국판향 이격 거리 전용 사양
			Local $specLang = $LangXMLObj.selectSingleNode("//distance/items[@lang='" & $LangLists[$j] & "']/item[@id='distance']").text
			Local $idmlLists = $oXMLObj.selectNodes("//p[@class='Description']")
			Local $k, $korCnt = 0
			$wkSht.Cells($q, 3).Value = "이격 거리 사양"
			$wkSht.Cells($q, 6).Value = $specLang
			For $k in $idmlLists
				If $k.text = $specLang Then
					$wkSht.Cells($q, 5).Value = $k.text
					$wkSht.Cells($q, 7).Value = _ReturnCompareText($specLang, $k.text)
					$korCnt = $korCnt + 1
					ExitLoop
				EndIf
			Next
			If $korCnt = 0 Then
				$wkSht.Cells($q, 7).Value = "Fail"
				_CheckFail($wkSht, $q)
			EndIf
			$q = $q + 1
		ElseIf ($region = "China" And $LangLists[$j] = "Chi") Then
			;~ 중국향 Body Worm SAR 전용 사양 검증
			Const $chiSarVal = "2.0 W/kg"
			Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $LangLists[$j] & "']/item[@id='body-wornsar']").text
			Local $vHeadVal = $vXMLObj.selectSingleNode("//sars/spec[@division='Common'][@item='headsar']").getAttribute("value")
			Local $vBodyVal = $vXMLObj.selectSingleNode("//sars/spec[@division='Common'][@item='body-wornsar']").getAttribute("value")
			;~ ConsoleWrite("!!!!!!!!! " & $vHeadVal & ":" & $vBodyVal & @CRLF)
			If StringRegExpReplace($vHeadVal, "((\s)?W/kg)", "") = "0" And StringRegExpReplace($vBodyVal, "((\s)?W/kg)", "") = "0" Then
				_FileWriteLog($hFile, "중국향 SAR 사양 미지원")
				$wkSht.Cells($q, 3).Value = "Body-worn SAR"
				$wkSht.Cells($q, 4).Value = "Not Support"
				$wkSht.Cells($q, 7).Value = "-"
			Else
				Local $idmlLists = $oXMLObj.selectNodes("//p[@class='UnorderList_3-CHN']")
				Local $k, $chiCnt = 0
				$wkSht.Cells($q, 3).Value = "Body-worn SAR"
				$wkSht.Cells($q, 4).Value = $chiSarVal
				$wkSht.Cells($q, 6).Value = $specLang
				For $k in $idmlLists
					If StringInStr($k.text, $specLang) Then
						$wkSht.Cells($q, 5).Value = $k.text
						Local $relVal = _returnStringMatch($k.text, "2.0")
						$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers(StringReplace($chiSarVal, " W/kg", ""), $relVal, "W/kg")
						_CheckFail($wkSht, $q)
						$chiCnt = $chiCnt + 1
						ExitLoop
					EndIf
				Next
				
				If $chiCnt = 0 Then
					$wkSht.Cells($q, 7).Value = "Fail"
					_CheckFail($wkSht, $q)
				EndIf
			EndIf
			$q = $q + 1
		Else
			If ($LangLists[$j] = "Fre(EU)" And StringInStr($manualN, "3rd")) Then
				;~ 언어가 Fre(EU)이면서 파일명에 3rd가 포함된 경우 검사 진행 X
			Else
				;~ validation에서 SAR 사양 확인
				_FileWriteLog($hFile, $region & ":" & $LangLists[$j] & " SAR 검증")
				Local $sarLists = $vXMLObj.selectNodes('//sars/spec')
				For $k in $sarLists
					If $k.getAttribute("division") = "Common" Then
						Local $vItem = $k.getAttribute("item")
						If Not ($vItem = "distance") Then ;~ headsar, body-wornsar 항목
							;~ validation의 반환 값을 Languages에서 찾는다.
							Local $specEngValue = $LangXMLObj.selectSingleNode("//sars/items[@lang='Eng']/item[@id='" & $vItem & "']").text
							
							Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $LangLists[$j] & "']/item[@id='" & $vItem & "']").text
							Local $specUnit = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $LangLists[$j] & "']/item[@id='" & $vItem & "']").getAttribute("unit")
							Local $specValue = $k.getAttribute("value")
							If StringRegExpReplace($specValue, "((\s)?W/kg)", "") = "0" Then
								_FileWriteLog($hFile, $specEngValue & "사양 미지원")
								$wkSht.Cells($q, 3).Value = $specEngValue
								$wkSht.Cells($q, 4).Value = "Not Support"
								$wkSht.Cells($q, 7).Value = "-"
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
							$wkSht.Cells($q, 3).Value = "이격 거리 사양"
							Local $specEngValue = $LangXMLObj.selectSingleNode("//distance/items[@lang='Eng']/item[@id='" & $vItem & "']").text
							Local $specLang = $LangXMLObj.selectSingleNode("//distance/items[@lang='" & $LangLists[$j] & "']/item[@id='" & $vItem & "']").text
							Local $specValue = $k.getAttribute("value")
							If StringRegExpReplace($specValue, "((\s)?mm)", "") = "0" Then
								_FileWriteLog($hFile, "이격 거리 사양 미지원")
								$wkSht.Cells($q, 4).Value = "Not Support"
								$wkSht.Cells($q, 7).Value = "-"
							Else
								$wkSht.Cells($q, 4).Value = $specValue
								$wkSht.Cells($q, 6).Value = $specLang

								Local $findText = StringRegExpReplace($specLang, "((\d)(\.|,)(\d))", "$1$2" & StringReplace($specValue, " mm", ""))
								
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
			If $LangLists[$j] = "Fre(EU)" And StringInStr($manualN, "3rd") = 0 Then
				Local $vItem = $vXMLObj.selectSingleNode("//sars/spec[@division='Fre(EU)']")
				Local $specLang = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $LangLists[$j] & "']/item[@id='limbsar1']").text
				Local $specUnit = $LangXMLObj.selectSingleNode("//sars/items[@lang='" & $LangLists[$j] & "']/item[@id='limbsar1']").getAttribute("unit")
				Local $specValue = $vItem.getAttribute("value")
				$wkSht.Cells($q, 3).Value = $specLang
				If StringRegExpReplace($specValue, "((\s)?W/kg)", "") = "0" Then
					_FileWriteLog($hFile, "Fre(EU) Limb SAR 미지원")
					$wkSht.Cells($q, 4).Value = "Not Support"
					$wkSht.Cells($q, 7).Value = "-"
				Else
					$wkSht.Cells($q, 4).Value = $specValue
					;~ idmlMergedXML에서 사양 값을 찾는다.
					Local $idmlValue = _StringBetween($ReadMerge, $specLang & '</p></td>', '</td>')
					If $idmlValue = 0 Then
						Local $relVal = "Not Found"
					Else
						Local $relVal = _returnStringMatch($idmlValue[0], "(\d{1,}(\.|\,)\d{1,}\s.+(?=</p>))")
					EndIf
						$wkSht.Cells($q, 5).Value = $relVal

					If $relVal = "Not Found" Then
						$wkSht.Cells($q, 7).Value = "Fail"
					Else
						Local $oVal = StringReplace(StringReplace($specValue, ",", "."), "W/kg", "")
						Local $sVal = StringReplace($relVal, $specUnit, "")
						$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($oVal, $sVal, $specUnit)
					EndIf
					_CheckFail($wkSht, $q)
				EndIf
				$q = $q + 1
			EndIf
		EndIf
		;~ =============================================================================================================
		
		;~ Band and mode 사양 확인 =====================================================================================
		;~ 미지원 출향지 및 언어 : CIS, MEA, LTN, SEA, India, Taiwan, China, HongKong, Kor
		;~ CIS 중 Ukr, Rus(5G 모델) 지원, MEA-Tur 지원
		If ($region = "EUA-EUH" And $LangLists[$j] <> "") Or ($region = "EUB" And $LangLists[$j] <> "") Or ($region = "EUC" And $LangLists[$j] <> "") Or ($region = "EUE" And $LangLists[$j] <> "") Or ($region = "EU-alone" And $LangLists[$j] <> "") Or ($region = "MEA" And $LangLists[$j] = "Tur") Or ($region = "CIS" And $LangLists[$j] = "Ukr") Or ($region = "CIS" And $LangLists[$j] = "Rus") Then
			_FileWriteLog($hFile, $LangLists[$j] & " Bandmode 사양 검증")
			;~ Rus 일 경우 Band and mode 텍스트를 찾아 문서에 내용이 있는지 확인한다. 없다면 패스
			If $LangLists[$j] = "Rus" Then
				Local $RusBandData = $LangXMLObj.selectSingleNode("//bandmode/items[@lang='" & $LangLists[$j] & "']/item[@id='bandandmode']").text
				Local $idmlLists = $oXMLObj.selectNodes("//p")
				For $i in $idmlLists
					If ($i.getAttribute("class") = "Description-Band") Or ($i.getAttribute("class") = "Description-Cell") Then
						If $i.text = $RusBandData Then
							;~ 사양 검증 코드가 매우 길어 함수 처리함, 마지막 행 값을 반환 받는다.
							$q = SpecBandandModeRe($hFile, $LangLists[$j], $vXMLObj, $LangXMLObj, $wkSht, $q)
						EndIf
					EndIf
				Next
			Else
				$q = SpecBandandModeRe($hFile, $LangLists[$j], $vXMLObj, $LangXMLObj, $wkSht, $q)
			EndIf
		EndIf
		;~ =============================================================================================================

		;~ e-Doc 사양 ==================================================================================================
		If ($region = "EUA-EUH" And $LangLists[$j] <> "") Or ($region = "EUB" And $LangLists[$j] <> "") Or ($region = "EUC" And $LangLists[$j] <> "") Or ($region = "EUE" And $LangLists[$j] <> "") Or ($region = "EU-alone" And $LangLists[$j] <> "") Or ($region = "CIS" And $LangLists[$j] = "Rum") Or ($region = "CIS" And $LangLists[$j] = "Ukr") Then
			_FileWriteLog($hFile, $LangLists[$j] & " eDoc 사양 검증")
			$wkSht.Cells($q, 3).Value = "eDoc 사양"
			Local $leDoc = $LangXMLObj.selectSingleNode("//eDoc/items[@lang='" & $LangLists[$j] & "']/item[@id='edoc']").text
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
		Else
			;~ Nothing
		EndIf
		;~ =============================================================================================================

		;~ 러시아 루즈리프 사양 $vModelName ============================================================================
		If ($region = "CIS" And $LangLists[$j] = "Rus") Then
			If StringInStr($manualN, "CIS_TYPE_A") Or StringInStr($manualN, "HHP_KAZAKHSTAN_ONLY") Or StringInStr($manualN, "Rus(CAU)") Then
				;~ CIS_TYPE_A의 경우 검증하지 않음
				;~ Rus(CAU) 검증 제외 (221026 jbj)
			Else
				_FileWriteLog($hFile, $LangLists[$j] & " Looseleaf 사양 검증")
				$wkSht.Cells($q, 3).Value = "Looseleaf 사양"
				
				;~ 헤딩 문장 검증
				$rusLfHead = "ИНФОРМАЦИЯ О СЕРТИФИКАЦИИ ПРОДУКЦИИ"
				$wkSht.Cells($q, 6).Value = $rusLfHead 
				Local $LsleafLists = $oXMLObj.selectNodes("//p[@class='Looseleaf-Center']") ;~ 찾아야할 문장 스타일의 콘텐츠
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
				Local $lsm
				For $lsm in $LsleafLists
					If StringInstr($lsm.text, $vModelName) Then
						$wkSht.Cells($q, 5).Value = $lsm.text
						$wkSht.Cells($q, 7).Value = _ReturnCompareText(StringReplace($lsm.text, "Модель: ", ""), $vModelName)
						$rusCnt = $rusCnt + 1 ;~ $rusCnt가 0일 경우 fail 처리 하기 위함
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
		;~ =============================================================================================================

		;~ Tur 전용 사양 ===============================================================================================
		If ($region = "MEA" And $LangLists[$j] = "Tur") Then
			_FileWriteLog($hFile, $LangLists[$j] & " 터키 전용 사양 검증")
			_FileWriteLog($hFile, $LangLists[$j] & " Product Spec 사양 검증")
			;~ Tur Product Spec 사양
			;~ temp.xml 파일을 만들어 텍스트 데이터에서 table 값을 가져온다. band 사양 로직과 비슷하지만
			;~ 한 언어만 해당하는 사양이기에 하드 코딩으로 진행한 부분이 있음
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
				;~ 테이블 row 기준 첫번째 td 안의 텍스트는 날려버리고 두번째 td 값을 변수로 저장
				If StringInStr($i.text, "İşlemci") Then
					$iCPU = StringReplace($i.text, "İşlemci", "")
				ElseIf StringInStr($i.text, "Ram") Then
					$iRam = $iRam & StringReplace($i.text, "Ram", "") & " "
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
				$wkSht.Cells($q, 3).Value = $vDiv
				$wkSht.Cells($q, 4).Value = $vSpecVal

				;~ 항목을 추가할 경우 elseif로 vItem을 추가하여 진행할 것
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
				ElseIf $vItem = "camera" Then
					$wkSht.Cells($q, 5).Value = $iCamera
				ElseIf $vItem = "frontcamera" Then
					$wkSht.Cells($q, 5).Value = $iFcamera
				ElseIf $vItem = "covercamera" Then
					$wkSht.Cells($q, 5).Value = $iCcamera
				ElseIf $vItem = "underdisplaycamera" Then
					$wkSht.Cells($q, 5).Value = $udCamera
				ElseIf $vItem = "radio" Then
					$wkSht.Cells($q, 5).Value = $iRadio
				ElseIf $vItem = "microsd" Then
					$wkSht.Cells($q, 5).Value = $iMicro
				EndIf
				$vProdVal = StringRegExpReplace($vSpecVal, "(\s|\/|\,\s)", "")
				$iProdVal = StringRegExpReplace($wkSht.Cells($q, 5).Value, "(\s|\/|\,\s|\”)", "")
				_FileWriteLog($hFile, "Compare " & $vProdVal & ":" & $iProdVal)
				$wkSht.Cells($q, 7).Value = _ReturnCompareText($vProdVal, $iProdVal)
				_CheckFail($wkSht, $q)
				$q = $q + 1
			Next
			;~ =============================================================================================================
			
			;~ Tur 제품 수명 밎 보증 사양 ===================================================================================
			_FileWriteLog($hFile, $LangLists[$j] & " 제품 수명 밎 보증 사양 검증")
			Local $grtLang = $LangXMLObj.selectSingleNode("//turgaranty/items/item").text
			$wkSht.Cells($q, 3).Value = "Tur 제품 수명 및 보증 사양"
			$wkSht.Cells($q, 6).Value = $grtLang
			Local $idmlLists = $oXMLObj.selectNodes("//doc/p")
			Local $y
			For $y in $idmlLists
				If $y.text = $grtLang Then
					$wkSht.Cells($q, 5).Value = $y.text
					$wkSht.Cells($q, 7).Value = "Success"
					ExitLoop
				Else
					$wkSht.Cells($q, 5).Value = "Not Found"
					$wkSht.Cells($q, 7).Value = "Fail"
				EndIf
			Next
			_CheckFail($wkSht, $q)
			;~ =============================================================================================================
			$q = $q + 1
		EndIf
		;~ =============================================================================================================

		;~ SEA, Ind 국가등록번호 사양, 보증서 모델 사양 확인 ============================================================
		If ($region = "SEA" And $LangLists[$j] = "Ind") Then
			_FileWriteLog($hFile, $LangLists[$j] & " 국가등록번호 사양 검증")
			$wkSht.Cells($q, 3).Value = "Ind 국가 등록 번호"
			Local $vRegNum = $vXMLObj.selectSingleNode("//registration/spec").getAttribute("value")
			If $vRegNum = "" Then
				$wkSht.Cells($q, 4).Value = "Empty"
				$wkSht.Cells($q, 7).Value = "Fail"
			Else
				$wkSht.Cells($q, 4).Value = $vRegNum
				If StringRegExp($ReadMerge, $vRegNum, 3) = 1 Then
					;~ 인디자인에서 값을 못 찾을 경우
					$wkSht.Cells($q, 5).Value = "Not Found"
					$wkSht.Cells($q, 7).Value = "Fail"
				Else
					Local $iRegNum = StringRegExp($ReadMerge, $vRegNum, 3)
					$wkSht.Cells($q, 5).Value = _ArrayToString($iRegNum, " / ")
					If $vRegNum = $iRegNum[0] Then
						$wkSht.Cells($q, 7).Value = "Success"
					Else
						$wkSht.Cells($q, 7).Value = "Fail"
					EndIf
				EndIf
			EndIf
			_CheckFail($wkSht, $q)
			$q = $q + 1

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
		;~ =============================================================================================================

		;~ India Bis 문구 확인 =========================================================================================
		If $region = "India" And $LangLists[$j] = "Eng(India)" And $vProdType = "Mobile phone" Then
			_FileWriteLog($hFile, $LangLists[$j] & " Bis 문구 사양 검증")
			Local $langBis = $LangXMLObj.selectSingleNode("//indiabis/items[@lang='" & $LangLists[$j] &"']/item").text
			Local $idmlLists = $oXMLObj.selectNodes("//p[@class='Description_UpSp1']")
			Local $i
			$wkSht.Cells($q, 3).Value = "India BIS 사양"
			$wkSht.Cells($q, 6).Value = $langBis
			For $i in $idmlLists
				If $i.text = $langBis Then
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
		;~ =============================================================================================================
		$q = $q + 2 ;~ 한 언어의 마지막 Row는 구분을 위해 2를 더한다.
	Next
	;~ 검증 로직 마지막
	
	Local $outputPath = $Scrpath & "\output" ;~ 검증 리포트를 저장할 경로
	If Not (FileExists($outputPath)) Then ;~ output 경로가 없을 경우 새로 생성
		DirCreate($outputPath)
	EndIf
	Local $targetWkb = $Scrpath & "\output\" & StringReplace(StringReplace(StringReplace($manualN, "_INDD", ""), "[", ""), "]", "_") & "_사양점검결과.xlsx" ;~ 인디자인 파일명 + 사양점검결과로 검증 리포트 파일명 설정
	$oExcel.ScreenUpdating = True ;~ 엑셀 화면 진행 과정 안보이도록 설정, 속도 증가
	$templateWkb.Sheets(1).Visible = True ;~ 엑셀 첫번째 시트를 보이도록 설정
	_Excel_BookSaveAs($templateWkb, $targetWkb, $xlWorkbookDefault, True) ;~ 엑셀 파일을 다른 파일명으로 저장하는 autoit 함수
	If FileExists($targetWkb) Then
		_FileWriteLog($hFile, $targetWkb & " 저장 완료")
	Else
		_FileWriteLog($hFile, $targetWkb & " 저장 실패")
	EndIf
	
	FileClose($hFile) ;~ 로그 파일을 닫음
	;~ fail 갯수를 찾아 기록한다. =======================================================================================
	Local $findFail = _Excel_RangeFind($templateWkb, "Fail", "G:G", $xlFormulas, $xlWhole) ;~ G열에서 fail 값 찾기
	Local $findNS = _Excel_RangeFind($templateWkb, "Not Support", "G:G", $xlFormulas, $xlWhole) ;~ G열에서 not support 값 찾기
	If UBound($findFail) > 0 Or UBound($findNS) > 0 Then
		$templateWkb.Sheets(1).Cells(6, 3).Value = UBound($findFail) + UBound($findNS)
		$templateWkb.Sheets(1).Cells(6, 3).Font.ColorIndex = 30
	EndIf
	;~ =============================================================================================================
	$templateWkb.Sheets(1).Protect("97473212!ast") ;~ 시트를 잠그는 설정
	_Excel_BookClose($templateWkb, True) ;~ 엑셀 파일 닫기
	_Excel_Close($oExcel, True, True) ;~ 엑셀 오브젝트 닫기

	Local $oExcel = _Excel_Open(True, False, True) ;~ 저장한 엑셀 리포트를 열어 화면에 보여줌
	_Excel_BookOpen($oExcel, $targetWkb, False, True)
	$oExcel.ScreenUpdating = True
	_Excel_BookSave($targetWkb)
	$oExcel = ""
	Return "complete"
EndFunc

;~ 사용하지 않는 함수 ============================================================================================
Func _returnIDfromTurSpec($LangXMLObj, $Lang, $iVal)
	Local $itemLists = $LangXMLObj.selectNodes("//productSpec/items[@lang='" & $Lang & "']/item")
	Local $i
	For $i in $itemLists
		If $i.text = $iVal Then
			Return $i.getAttribute("id")
		EndIf
	Next
EndFunc
;~ ================================================================================================================

;~ 다국어 band 항목 이름을 영어 명칭과 id, 단위를 가져오는 함수 ===========================================================================
Func _returnBasicLang($LangXMLObj, $bandVal, $Lang)
	Local $itemLists = $LangXMLObj.selectNodes("//bandmode/items[@lang='" & $Lang & "']/item")
	Local $j, $specEng
	If StringInStr($bandVal, " *") Then
		$bandVal = StringReplace($bandVal, " *", "")
	EndIf
	For $j in $itemLists
		If $j.text = $bandVal Then
			;~ $j.getAttribute("id") 
			;~ $j.getAttribute("unit")
			If $j.text = "WCDMA Band VIII" Or $j.text = "WCDMA Band I" Then
				Return $j.text & "," & $j.getAttribute("id") & "," & $j.getAttribute("unit")
			Else
				If $j.getAttribute("id") = "5g" Or $j.getAttribute("id") = "lte" Then
					Return StringUpper($j.getAttribute("id")) & "," & $j.getAttribute("id") & "," & $j.getAttribute("unit")
				Else
					$specEng = $LangXMLObj.selectSingleNode("//bandmode/items[@lang='Eng']/item[@id='" & $j.getAttribute("id") & "']")
					Return $specEng.text & "," & $j.getAttribute("id") & "," & $j.getAttribute("unit")
				EndIf
			EndIf
		EndIf
	Next
EndFunc
;~ ================================================================================================================================

;~ 문자열과 일치하는 값을 돌려주는 함수 ===========================================================================================
Func _returnStringMatch($oText, $pattern)
	Local $result = StringRegExp($oText, $pattern, 1)
	If $result = 0 Then
		return "Not Found"
	Else
		return $result[0]
	EndIf
EndFunc
;~ ================================================================================================================================

;~ 지문인식 사양 검증 함수 ================================================================================================
Func SpecOptical($Lang, $LangXMLObj, $oXMLObj, $wkSht, $q, $type)
	Local $LangFp = $LangXMLObj.selectSingleNode("//fingerprint/items[@lang='" & $Lang & "']/item[@id='" & $type & "']")
	Local $LangFpOri = $LangFp.text
	Local $EngFp = $LangXMLObj.selectSingleNode("//fingerprint/items[@lang='Eng']/item[@id='" & $type & "']").text

	$wkSht.Cells($q, 4).Value = $EngFp
	$wkSht.Cells($q, 6).Value = $LangFpOri
	
	;~ 인디자인 데이터 입력, idmlMergedXML에서 $LangFp.text를 찾는다.
	Local $idmlLang = $oXMLObj.selectSingleNode("//doc[@lang='" & $Lang & "']")
	Local $idmlLists = $idmlLang.selectNodes("//p")
	
	For $l in $idmlLists
		Local $myResult = StringRegExp($LangFpOri, "^" & $l.text & "$") ;~ idml 파일에서 정규식으로 일치하는 텍스트가 있는지 확인
		;~ $myResult 값이 비어있을 경우 fail 처리
		If $myResult = "" Then
			;~ ConsoleWrite($n.text & " : " & $l.text & @CRLF)
			$wkSht.Cells($q, 5).Value = "Not Found"
			$wkSht.Cells($q, 7).Value = "Fail"
		Else
			$wkSht.Cells($q, 5).Value = $l.text
			$wkSht.Cells($q, 7).Value = _ReturnCompareText($l.text, $LangFpOri)
			ExitLoop
		EndIf
	Next
	_CheckFail($wkSht, $q)
EndFunc
;~ =========================================================================================================================

;~ 텍스트를 비교하는 함수 =============================================================
Func _ReturnCompareText($oVal, $sVal)
	;~ 텍스트를 비교하는 autoit 함수 : https://www.autoitscript.com/autoit3/docs/functions/StringCompare.htm
	Local $myResult = StringCompare($oVal, $sVal, 1)
	ConsoleWrite("Text Compare : " & $oVal & ";" & $sVal & ";" & $myResult & @CRLF)
	If $myResult = 0 Then
		Return "Success"
	Else
		Return "Fail"
	EndIf
EndFunc
;~ ===================================================================================

;~ 숫자 값을 비교하는 함수 ===========================================================
Func _ReturnCompareNumbers($oVal, $sVal, $specUnit)
	ConsoleWrite($oVal & ":::" & $sVal & @CRLF)
	;~ oVal - 인디자인 사양, sVal - validation 사양
	$oVal = StringRegExpReplace($oVal, "(W/kg|dBm|mW)", "") ;~ 단위 사양을 제거한다.
	$sVal = StringReplace($sVal, $specUnit, "")

	If StringInStr($sVal, ",") Then
		;~ 다국어의 경우 쉼표를 콤마로 변경한 다음 비교한다.
		$sVal = StringReplace($sVal, ",", ".")
	EndIf
	ConsoleWrite(Number($oVal) & " : " & Number($sVal) & @CRLF)
	If (Number($oVal) = Number($sVal)) And (String($oVal) = String($sVal)) Then
		Return "Success"
	Else
		Return "Fail"
	EndIf
EndFunc
;~ ===================================================================================

;~ nfc, wirelesscharging, mst 값 비교 함수 ===========================================
Func _ReturnNFCcompare($oVal, $sVal)
	Local $i
	For $i = UBound($oVal) - 1 To 0 Step - 1
		If StringLen($oVal[$i]) = 0 Then
			_ArrayDelete($oVal, $i)
		Else
			$oVal[$i] = Number($oVal[$i])
		EndIf
	Next
	_ArraySort($oVal)

	For $i = UBound($sVal) - 1 To 0 Step - 1
		If StringLen($sVal[$i]) = 0 Then
			_ArrayDelete($sVal, $i)
		Else
			$sVal[$i] = Number($sVal[$i])
		EndIf
	Next
	_ArraySort($sVal)
	ConsoleWrite($oVal[0] & "::" & $sVal[0] & " | " & $oVal[1] & "::" & $sVal[1] & @CRLF)
	If ($oVal[0] = $sVal[0]) And ($oVal[1] = $sVal[1]) Then
		Return "Success"
	Else
		Return "Fail"
	EndIf
EndFunc
;~ ===================================================================================

;~ 검증 로직 진행 중 해당 행의 Fail 또는 Not support일 경우 행의 색상과 글씨 색을 변경하는 함수 ========
Func _CheckFail($wkSht, $q)
	If $wkSht.Cells($q, 7).Value = "Fail" Or $wkSht.Cells($q, 7).Value = "Not Support" Then
		With $wkSht
			.Range(.Cells($q, 3), .Cells($q, 7)).Interior.ColorIndex = 22
			.Range(.Cells($q, 3), .Cells($q, 7)).Font.ColorIndex = 30
		EndWith
	EndIf
EndFunc
;~ ====================================================================================================

;~ 밴드 사양 검증 함수 ================================================================================
Func SpecBandandModeRe($hFile, $Lang, $vXMLObj, $LangXMLObj, $wkSht, $q)
	Local $Scrpath = FileGetShortName(@ScriptDir)
	Local $tempLangXML = $Scrpath & "\temp\" & $Lang & ".xml"
	Local $ReadMerge = FileRead($tempLangXML)
	Local $tempXML = $Scrpath & "\temp\" & "temp.xml"
	Local $i, $n, $bandArray = [], $specID, $specUnit, $specVal
	If FileExists($tempXML) Then
		FileDelete($tempXML)
	EndIf

	;~ Output power 텍스트를 찾아 band 사양 테이블을 별로도 추출한다.
	Local $lOutput = $LangXMLObj.selectSingleNode("//bandmode/items[@lang='" & $Lang & "']/item[@id='outputpower']").text
	Local $bandTable = _StringBetween(FileRead($tempLangXML), $lOutput & "</p></td></tr>", "</Table>")
	If $bandTable = 0 Then
		_FileWriteLog($hFile, $Lang & " : Band and mode 사양 찾을 수 없음")
		$wkSht.Cells($q, 3).Value = "Band and mode, Not Found"
		$q = $q + 1
	Else
		;~ table 형식으로 별도의 xml 파일을 생성
		FileWriteLine($tempXML, "<root>")
		FileWriteLine($tempXML, "<table>")
		FileWriteLine($tempXML, $bandTable[0])
		FileWriteLine($tempXML, "</table>")
		FileWriteLine($tempXML, "</root>")

		Local $tXMLObj = ObjCreate('Microsoft.XMLDOM')
		$tXMLObj.load($tempXML)

		If $Lang = "Rus" Then
			;~ 러시아어의 경우 테이블이 3개의 열로 구성되어 셀 속성 Name이 0으로 
			;~ 시작하는 경우(첫번째 열)을 제외하기 위해 별도 처리함
			Local $idmlLists = $tXMLObj.selectNodes("//td")
			Local $i
			For $i In $idmlLists
				If Not StringInStr($i.getAttribute("Name"), "0:") Then
					_ArrayAdd($bandArray, $i.text)
				EndIf
			Next
		Else
			Local $idmlLists = $tXMLObj.selectNodes("//td")
			For $i in $idmlLists
				_ArrayAdd($bandArray, $i.text)
			Next
		EndIf
		;~ _ArrayDisplay($bandArray)
		Local $ilteArr
		Local $turwfCnt = 0
		Local $bdCount = 0 ;~ 인디자인 Bandmode 개수,
		Local $vSupport = $vXMLObj.selectNodes("//bandmode/spec[@supportstatus='Y']")
		Local $vbdCount = $vSupport.length ;~ Validation Bandmode 개수
		;~ 인디자인의 band 사양 개수와 validation의 적용할 사양 개수를 비교하기 위해 bdCount, vbdCount 비교
		ConsoleWrite("Validation Bandmode Support : " & $vSupport.length & @CRLF)

		For $i = 1 To UBound($bandArray) -1
			Local $check = _MathCheckDiv($i, 2)
			;~ bandArray 값, 홀수인 경우는 band 항목 이름
			;~ bandArray 값, 짝수인 경우는 band outputpower 값
			If $check = 1 Then
				;~ 엑셀 값을 영어로 변경하고 Spec 값을 불러와 검증 리포트 엑셀 파일에 입력(3열)
				;~ $bandArray[$i] -> idml 언어 값
				_FileWriteLog($hFile, $Lang & ":" & $bandArray[$i])
				;~ 검증할 밴드 항목 이름, id(검증할 대상의 텍스트를 가져온다), unit(단위) 값을 가져와 진행한다.
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
					;~ Rus의 경우 문자열에 '*' 포함되어 있으니 삭제하고 진행할 것
					Local $i5gVal = StringReplace($bandArray[$i], " *", "")
					$wkSht.Cells($q, 3).Value = $i5gVal
					$specID = "5g"
					$specUnit = "dBm"
					Local $i5gArr = StringSplit(StringReplace($i5gVal, " (FR1)", ""), "/")
				Else
					Local $relVal = _returnBasicLang($LangXMLObj, $bandArray[$i], $Lang) ;~ 다국어 band 항목 이름을 영어 명칭, id, 단위를 가져오는 함수
					If $relVal = "" Then
						$wkSht.Cells($q, 3).Value = "Not Found"
						ContinueLoop
					Else
						$wkSht.Cells($q, 3).Value = StringSplit($relVal, ",")[1]
						$specID = StringSplit($relVal, ",")[2]
						$specUnit = StringSplit($relVal, ",")[3]
					EndIf
				EndIf
				
				;~ 검증 대상의 ID에 따라 output 값을 가져오고 검증 리포트 엑셀 파일에 입력한다.(4열)
				;~ 단위 값은 단위를 replace 처리하고 숫자 값만을 가지고 인디자인과 validation 을 비교한다.
				;~ supportstatus가 'Y'인 경우만 검증 진행한다.
				;~ wcdma, lte, 5g는 division 항목가 일치하지 않기 때문에 별도 처리한다. 
				;~ 위 세 항목은 값이 여러 개이기 때문에 array에 배열로 추가한 후 셀에 입력한다.
				If $specID = "wcdma900/wcdma2100" Then
					Local $wcdmLists = $vXMLObj.selectNodes("//bandmode/spec[@division='3G']")
					Local $wcdmArray = []
					For $n in $wcdmLists
						If $n.getAttribute("supportstatus") = "Y" Then
							_ArrayAdd($wcdmArray, $n.getAttribute("outputpower"))
							$bdCount = $bdCount + 1 ;~ 검증 진행한 경우 bdCount ++ 처리
						EndIf
					Next
					ConsoleWrite("wcdma900/2100 -" & $bdCount & @CRLF)
					;~ wcdma는 값이 두개이기 때문에 array를 string 처리한다.
					$wkSht.Cells($q, 4).Value = _ArrayToString($wcdmArray, ",", 1)
				ElseIf $specID = "lte" Then
					Local $lteLists = $vXMLObj.selectNodes("//bandmode/spec[@division='4G']")
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
					ConsoleWrite("lte -" & $bdCount & @CRLF)
					;~ lte 사양 역시 값이 2개 이상이기 때문에 array를 string 처리한다.
					$wkSht.Cells($q, 4).Value = _ArrayToString($lteArray, ",", 1)
				ElseIf $specID = "5g" Then
					Local $gigaLists = $vXMLObj.selectNodes("//bandmode/spec[@division='5G']")
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
					ConsoleWrite("5g -" & $bdCount & @CRLF)
					;~ 5g 사양 역시 값이 2개 이상이기 때문에 array를 string 처리한다.
					$wkSht.Cells($q, 4).Value = _ArrayToString($gigaArray, ",", 1)
				Else ;~ 그 외 사양
					If Not IsObj($vXMLObj.selectSingleNode("//bandmode/spec[@bandandmode='" & $specID & "']")) Then
						;~ validation에서 관련한 id 값에 해당하는 스펙을 찾을 수 없을 경우
						$wkSht.Cells($q, 4).Value = "Not Found"
					Else
						$specVal = $vXMLObj.selectSingleNode("//bandmode/spec[@bandandmode='" & $specID & "']").getAttribute("outputpower")
						If $lang = "Tur" And StringInStr($specID, "wifi5") Then
							;~ 터기의 경우 wifi5 사양을 별도 검증한다.
							If $vXMLObj.selectSingleNode("//bandmode/spec[@bandandmode='" & $specID & "']").getAttribute("supportstatus") = "Y" Then
								$turwfCnt = $turwfCnt + 1
							EndIf
						EndIf
						$bdCount = $bdCount + 1
						$wkSht.Cells($q, 4).Value = $specVal
						ConsoleWrite("etc -" & $bdCount & @CRLF)
					EndIf
				EndIf
			ElseIf $check = 2 Then ;~ 인디자인의 output power 값을 리포트 엑셀 파일에 입력(5열)
				ConsoleWrite($wkSht.Cells($q, 3).Value & @CRLF)
				;~ 값이 2개 이상인 LTE, 5G 구분하여 인디자인 값 입력 ===============================================
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
				;~ ================================================================================================
				
				;~ 비교 값 산출하기 ===============================================================================
				If ($specID = "wcdma900/wcdma2100") Then
					Local $valArray = StringSplit($wkSht.Cells($q, 4).Value, ",")
					$valArray = _ArrayUnique($valArray, 0, 1)
					;~ 3G 사양은 항상 값이 같으나 그렇지 않은 경우를 대비해 unique 값을 구하고 값이 서로 다를 경우 fail 처리
					If $valArray[0] = 1 Then
						$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($valArray[1], $bandArray[$i], $specUnit) ;~ 숫자 값을 비교하는 함수
					ElseIf $valArray[0] > 1 Then
						$wkSht.Cells($q, 7).Value = "Fail"
					EndIf
				ElseIf ($specID = "lte") Or ($specID = "5g") Then
					$wkSht.Cells($q, 7).Value = _ReturnCompareText($wkSht.Cells($q, 4).Value, $wkSht.Cells($q, 5).Value)
				ElseIf $specID = "nfc1" Or $specID = "wirelesscharging" Or $specID = "mst3_6khz" Then
					;~ $specVal, $bandArray[$i] 비교
					Local $oArray = StringRegExp(StringReplace($specVal, ",", "."), "(\d+[\.]\d+|\d+)([ ]?)+", 3)
					Local $sArray = StringRegExp(StringReplace($bandArray[$i], ",", "."), "(\d+[\.|\,]\d+|\d+)([ ]?)+", 3)
					
					If Not IsObj($vXMLObj.selectSingleNode("//bandmode/spec[@bandandmode='" & $specID & "']")) Then
						$wkSht.Cells($q, 7).Value = "Not Support"
					Else
						Local $specValid = $vXMLObj.selectSingleNode("//bandmode/spec[@bandandmode='" & $specID & "']").getAttribute("supportstatus")
						If $specValid = "Y" Then
							$wkSht.Cells($q, 7).Value = _ReturnNFCcompare($oArray, $sArray) ;~ nfc, wirelesscharging, mst 값 비교 함수
						Else
							$wkSht.Cells($q, 7).Value = "Not Support"
						EndIf
					EndIf
				Else
					If Not IsObj($vXMLObj.selectSingleNode("//bandmode/spec[@bandandmode='" & $specID & "']")) Then
						$wkSht.Cells($q, 7).Value = "Not Support"
					Else
						Local $specValid = $vXMLObj.selectSingleNode("//bandmode/spec[@bandandmode='" & $specID & "']").getAttribute("supportstatus")
						If $specValid = "Y" Then
							If $specID = "wifi5_9_6_4ghz" Then
								$specVal = StringRegExpReplace($specVal, "(\s|\/)", "")
								Local $wifi5964 = StringRegExpReplace($bandArray[$i], "(\s|\/)", "")
								$wkSht.Cells($q, 7).Value = _ReturnCompareText($specVal, $wifi5964)
							Else
								$wkSht.Cells($q, 7).Value = _ReturnCompareNumbers($specVal, $bandArray[$i], $specUnit)
							EndIf
						Else
							$wkSht.Cells($q, 7).Value = "Not Support"
						EndIf
					EndIf
				EndIf
				_CheckFail($wkSht, $q)
				;~ ================================================================================================
				$q = $q + 1 ;~ row를 더한다.
			EndIf
		Next

		;~ 터키향 터키어인 경우, $turwfCnt 값이 1개 이상인 경우 ====================================================
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
		;~ ========================================================================================================

		;~ validation band 사양과 indesing band 사양 개수가 같은지 비교 ============================================
		ConsoleWrite("Indesign Bandmode : " & $bdCount & @CRLF)
		If $bdCount <> $vbdCount Then
			With $wkSht
				.Cells($q, 3).Value = "Bandmode 사양 오류, 지원하는 Band 사양 개수 불일치"
				.Range(.Cells($q, 3), .Cells($q, 7)).Interior.ColorIndex = 22
				.Cells($q, 3).WrapText = False
			EndWith
			$q = $q + 1
		EndIf
		;~ ========================================================================================================
	EndIf
	return $q
EndFunc
;~ ====================================================================================================

;~ resource\langlists.txt 파일을 통해 사용하는 언어의 파일명이 올바른지 확인하는 함수 =========================================
Func _checkLang($Lang)
	Local $Scrpath = FileGetShortName(@ScriptDir)
	Local $LangData = $Scrpath & "\resource\langlists.txt"
	Local $LangArray = StringSplit(FileReadLine($LangData, 1), ",", 0)
	;~ _ArrayDisplay($LangArray)
	$myResult = _ArraySearch($LangArray, $Lang, 0, 0, 1, 0)
	Return $myResult
EndFunc
;~ =======================================================================================================================