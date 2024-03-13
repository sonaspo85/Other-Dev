;~ 인디자인 압축 파일에서 압축을 풀고, idml 파일을 분해해 xml을 추출, 추출한 xml 파일을 Merge하는 프로세스 모둘

Func _idmlMergeGroup($idmlFile)
	Local $logfile = @ScriptDir & '\log.txt' ;~ 단계 별 상황에 대해 로그를 남기위한 파일
	;~ 인디자인 xml merge 과정에서 xslt가 오류날 경우 어느 시점에서 오류가 났는지 정확히 알 수 없기 때문에
	;~ 로그를 남기고 남겨진 로그를 command line 창에서 실행해 오류가 발생하는 경우를 찾기 위함
	;~ 인디자인 Merge 오류 메시지가 나타나면 로그에 남겨진 기록을 하나씩 command line에서 실행해 본 다음 문제를 찾아볼 것
	
	Local $hFile = FileOpen($logfile, 1) ;~ 1을 사용하면 기존 파일에 내용을 추가하는 옵션
	Local $region, $i, $idmlfName
	local $temp = @ScriptDir & "\temp"
	local $resource = @ScriptDir & "\resource"
	;~ 파일 경로에서 파일명을 추출하는 기능 ==================================================================
	local $idmlfN = StringMid($idmlFile,StringInStr($idmlFile,'\',0,-1)+1)
	local $manualN = StringRegExpReplace(StringMid($idmlFile,StringInStr($idmlFile,'\',0,-1)+1), ".zip", "")
	;~ ======================================================================================================
	local $funcZip = @ScriptDir & "\lib\7zip\7za.exe" ;~ 압축 파일 호출
	;~ 사용자마다 인디자인 파일을 저장하는 경로가 제각각이고, 경로에 특수 문자, 공백 등으로 인해 오류가 발생할 수 있기 때문에
	;~ temp 폴더로 복사해 프로세스를 진행한다.
	FileCopy($idmlFile, $temp & "\" & $idmlfN)
	;~ ======================================================================================================
	
	;~ 출향지 정보를 파일명에서 추출하여 검증 로직에서 검증 사양에 적용 여부를 선택하기 위함 ==================
	;~ 출향지 관련한 내용 현업에 전달, 다음 링크의 댓글 참조 https://wp2.astkorea.net/task/doc/#view/2022042611224302151
	If StringInStr($manualN, "CIS") Then
		$region = "CIS"
	ElseIf StringInStr($manualN, "UKRAINE_ONLY") Then
		$region = "UKRAINE_ONLY"
	ElseIf StringInStr($manualN, "ISRAEL") Or StringInStr($manualN, "MIDDLE") Or StringInStr($manualN, "MEA") Or StringInStr($manualN, "SAUDI_ARABIA") Then
		If StringInStr($manualN, "MEA_B_TYPE") Or StringInStr($manualN, "HHP_AFRICA_TYPE_B") Or StringInStr($manualN, "AFRICA_TYPE_A") Then
			$region = "AFRICA"
		ElseIf StringInStr($manualN, "SAUDI_ARABIA") Then
			$region = "SAUDI_ARABIA"
		Else
			$region = "MEA"
		EndIf
	;~ 유럽 출향지 정보는 액세서리 QSG 검증 추가로 확장하여 분기함
	ElseIf StringInStr($manualN, "EUB") Or StringInStr($manualN, "EUROPE_TYPE_B") Then
		$region = "EUB"
	ElseIf StringInStr($manualN, "EUE") Or StringInStr($manualN, "EUROPE_TYPE_E") Then
		$region = "EUE"
	ElseIf StringInStr($manualN, "EUC") Or StringInStr($manualN, "EU_Eng") Or StringInStr($manualN, "EUROPE") Or StringInStr($manualN, "SEAD_COMMON") Or StringInStr($manualN, "EUROPE_TYPE_C") Then
		$region = "EUC"
	ElseIf StringInStr($manualN, "EUA") Or StringInStr($manualN, "EUH") Then
		$region = "EUA-EUH"
	ElseIf StringInStr($manualN, "LTN") Or StringInStr($manualN, "LATIN") Then
		$region = "LTN"
	ElseIf StringInStr($manualN, "SEA") Or StringInStr($manualN, "ASIA") Or StringInStr($manualN, "MALAYSIA") Or StringInStr($manualN, "INDONESIA") Then
		$region = "SEA"
	ElseIf StringInStr($manualN, "SWA") Then
		$region = "SWA"
	ElseIf StringInStr($manualN, "India") Then
		$region = "India"
	ElseIf StringInStr($manualN, "Taiwan") Then
		$region = "Taiwan"
	ElseIf StringInStr($manualN, "China") Then
		$region = "China"
	ElseIf StringInStr($manualN, "HongKong") Then
		$region = "HongKong"
	ElseIf StringInStr($manualN, "Kor") Then
		$region = "Korea"
	ElseIf StringInStr($manualN, "Open") Then
		$region = "EU-alone"
	EndIf
	ConsoleWrite($region & @CRLF)
	_FileWriteLog($hFile, "출향지 : " & $region)
	;~ ======================================================================================================

	;~ 인디자인 압축 파일, 압축 해제 ========================================================================
	RunWait(@ComSpec & ' /c' & '""' & $funcZip & '" x "' & $temp & '\' & $idmlfN & '" -o"' & $temp & '\' & $manualN & '"', $temp, @SW_HIDE)
	ConsoleWrite($funcZip & '" x "' & $temp & '\' & $idmlfN & '" -o"' & $temp & '\' & $manualN & '"' & @CRLF)
	_FileWriteLog($hFile, $funcZip & '" x "' & $temp & '\' & $idmlfN & '" -o"' & $temp & '\' & $manualN & '"')
	;~ ======================================================================================================
	
	;~ IDML Merge 로직 ======================================================================================
	Local $Scrpath = FileGetShortName(@ScriptDir) ;~ 스펙체커 프로그램의 저장 경로에 특수 문자, 공백 등의 문제로 오류가 발생할 경우를 대비해 경로를 short 설정함
	local $idmlArray = _FileListToArray($temp & "\" & $manualN, "*.idml")
	local $dummy = $Scrpath & "\xsls\dummy.xml" ;~ xslt 변환 중 dummy 파일이 손상될 수 있음
	local $saxon = $Scrpath & "\lib\saxon9he.jar"
	Local $idmltoXML01 = $Scrpath & "\xsls\01-designmap_name.xsl" ;~ idml 파일별로 designmap 파일을 읽어 들여 story 순서 배열하는 xslt
	Local $idmltoXML02 = $Scrpath & "\xsls\02-story_merged.xsl" ;~ 배열한 story 기준으로 merge xml을 만드는 xslt
	Local $idmltoXML03 = $Scrpath & "\xsls\03-specExtract.xsl" ;~ merge xml 요소 단순화하는 xslt
	Local $idmltoXML04 = $Scrpath & "\xsls\04-resource_merged.xsl region=" & $region & " zipName=" & $manualN ;~ 각 idml 파일별 merged xml 파일을 하나로 합치는 xslt
	If (UBound($idmlArray) = 0) Then ;~ idml 파일이 없을 경우 프로세스 중단
		Return 3
	EndIf
	For $i = 1 To UBound($idmlArray) - 1
		;~ 파일명에 TOC, Eng(LTN), Warranty를 포함할 경우 xml 변환 로직을 실행하지 않는다.
		If StringInStr($idmlArray[$i], "TOC") Then
			;~ Nothing
		ElseIf StringInStr($idmlArray[$i], "Eng(LTN)") Then
			;~ Nothing
		ElseIf StringInStr($idmlArray[$i], "Warranty") Then
			;~ Nothing
		Else
			$idmlfName = StringRegExpReplace(StringMid($idmlArray[$i],StringInStr($idmlArray[$i],'\',0,-1)+1), ".idml", "")
			ConsoleWrite ($idmlfName & @CRLF)
			;~ 7zip을 이용해 idml 파일의 압축을 푼다. ========================================================================================
			If StringInStr($idmlfName, " ") Then
				RunWait(@ComSpec & ' /c' & '""' & $funcZip & '" x "' & $temp & '\' & $manualN & '\' & $idmlArray[$i] & '" -o"' & $temp & '\' & $idmlfName & '"', $temp, @SW_HIDE)
				ConsoleWrite('""' & $funcZip & '" x "' & $temp & '\' & $manualN & '\' & $idmlArray[$i] & '" -o"' & $temp & '\' & $idmlfName & '"' & @CRLF)
				_FileWriteLog($hFile, '""' & $funcZip & '" x "' & $temp & '\' & $manualN & '\' & $idmlArray[$i] & '" -o"' & $temp & '\' & $idmlfName & '"')
			Else
				RunWait(@ComSpec & ' /c' & '""' & $funcZip & '" x "' & $temp & '\' & $manualN & '\' & $idmlArray[$i] & '" -o"' & $temp & '\' & $idmlfName & '"', $temp, @SW_HIDE)
				ConsoleWrite('""' & $funcZip & '" x "' & $temp & '\' & $manualN & '\' & $idmlArray[$i] & '" -o"' & $temp & '\' & $idmlfName & '"' & @CRLF)
				_FileWriteLog($hFile, '""' & $funcZip & '" x "' & $temp & '\' & $manualN & '\' & $idmlArray[$i] & '" -o"' & $temp & '\' & $idmlfName & '"')
			EndIf
			;~ ==============================================================================================================================
		EndIf
	Next
	;~ Merged XML을 만든다. 아래 함수 참조
	_XSLTransform01($hFile, $saxon, $dummy, $idmltoXML01)
	_XSLTransform01($hFile, $saxon, $dummy, $idmltoXML02)
	_XSLTransform01($hFile, $saxon, $dummy, $idmltoXML03)
	_XSLTransform01($hFile, $saxon, $dummy, $idmltoXML04)

	Local $oXML05 = $Scrpath & '\temp\05-table-structure.xml'
	Local $sXML05 = $Scrpath & '\temp\04-resource_merged.xml'
	Local $xslt05 = $Scrpath & '\xsls\05-table-structure.xsl'
	_XSLTransform02($hFile, $saxon, $oXML05, $sXML05, $xslt05)

	If Not FileExists($oXML05) Then
		;~ 최종 출력물이 없을 경우 Error 처리
		Return 1
	EndIf

	Local $mergedXML = $Scrpath & "\temp\" & "idmlMergedXML.xml"
	Local $xslGroup = $Scrpath & "\xsls\" & "05-grouping-doc.xsl"

	_XSLTransform02($hFile, $saxon, $mergedXML, $oXML05, $xslGroup)

	Return $region ;~ 검증 로직에서 검증할 사양을 선택하도록 하기 위해 출향지를 반환한다.
EndFunc

;~ 추가 파라미터 없는 Transform 함수 =====================================================================================================
Func _XSLTransform01($hFile, $saxon, $sXML, $xslt)
	RunWait(@ComSpec & ' /c' & '@set CLASSPATH= && @java -classpath ' & $saxon & ' net.sf.saxon.Transform -s:' & $sXML & ' -xsl:' & $xslt, @ScriptDir, @SW_HIDE)
	ConsoleWrite('@set CLASSPATH= && @java -classpath ' & $saxon & ' net.sf.saxon.Transform -s:' & $sXML & ' -xsl:' & $xslt & @CRLF)
	_FileWriteLog($hFile, '@set CLASSPATH= && @java -classpath ' & $saxon & ' net.sf.saxon.Transform -s:' & $sXML & ' -xsl:' & $xslt)
EndFunc
;~ =======================================================================================================================================

;~ 추가 파라미터 필요 Transform 함수 =====================================================================================================
Func _XSLTransform02($hFile, $saxon, $oXML, $sXML, $xslt)
	RunWait(@ComSpec & ' /c' & '@set CLASSPATH= && @java -classpath ' & $saxon & ' net.sf.saxon.Transform -o:' & $oXML & ' -s:' & $sXML & ' -xsl:' & $xslt, @ScriptDir, @SW_HIDE)
	ConsoleWrite('@set CLASSPATH= && @java -classpath ' & $saxon & ' net.sf.saxon.Transform -o:' & $oXML & ' -s:' & $sXML & ' -xsl:' & $xslt & @CRLF)
	_FileWriteLog($hFile, '@set CLASSPATH= && @java -classpath ' & $saxon & ' net.sf.saxon.Transform -o:' & $oXML & ' -s:' & $sXML & ' -xsl:' & $xslt)
EndFunc
;~ =======================================================================================================================================