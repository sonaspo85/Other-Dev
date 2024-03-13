#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
; #AutoIt3Wrapper_Icon=..\ProteanUI\protean.ico
#AutoIt3Wrapper_Icon=..\Protean-CE\protean.ico
#AutoIt3Wrapper_Outfile=Protean-CE-UI.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
#include <Excel.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <FontConstants.au3>
#include <StringConstants.au3>
#include <GuIConstants.au3>
#include <GUIConstantsEx.au3>
#include <AutoItConstants.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>
#include <WinAPIShellEx.au3>
#include <EditConstants.au3>
#include <Date.au3>
#include <Inet.au3>
#include <Constants.au3>
#include <WindowsConstants.au3>
#include <Excel.au3>
;~ #include <ProteanEngine.au3>

;~ PC IP 주소 확인
;~ SplashTextOn("Protean-CE-UI", "접속한 PC의 IP를 확인 중입니다.", 250, 50, -1, -1, $DLG_CENTERONTOP, "", 10)
;~ Local $sPublicIP = _GetIP()
;~ IF $sPublicIP <> "106.246.234.178" Then
;~ 	SplashOff()
;~ 	MsgBox($MB_SYSTEMMODAL, "", "AST 사내가 아닙니다. 종료합니다.")
;~ 	Exit
;~ EndIf
;~ SplashOff()

Global $ditaot = @ScriptDir & '\dita-ot'
Global $saxon = @ScriptDir & '\lib'
Global $langCode = @ScriptDir & '\_reference\language_codes\lang_code_tables.xml'
Global $LV = @ScriptDir & '\_reference\LV\Language_Variable.xml'
Global $imgAlt = @ScriptDir & '\_reference\meta_data\image_alt_contents.xml'
Global $chIcon = @ScriptDir & '\resource\chapter_icon.xml'
Global $symbolmrk = @ScriptDir & '\_reference\symbol_mark\symbol_mark.xml'
Global $sConfig = @ScriptDir & '\config.ini'
Global $logFile = @ScriptDir & '\log.txt'
Global $sDummy = @ScriptDir & '\_reference\dummy.xml'
Global $ditamap, $publist, $manualPath, $mapName, $NmapName, $containerPath, $pvdb, $filter, $translate, $output, $hFile, $langArray, $totalLang, $CMD_WINDOW

Local $tijd = StringRegExpReplace(FileGetTime($logFile, 1, 1), "(.{4})(.{2})(.{2})(.{2})(.{2})(.{2})", "${1}/${2}/${3} ${4}:${5}:${6}")
If _DateDiff('D', $tijd, _NowCalc()) > 7 Then
	FileDelete($logFile)
EndIf


Global $msgfile = '파일을 선택하세요'

Global $hGUI = GUICreate("[CE] Protean UI for TV ver.0.0.4", 776, 440, -1, -1, -1, $WS_EX_ACCEPTFILES)

GUICtrlCreateLabel ("Protean UI for TV", 20, 25, 455)
GUICtrlSetFont(-1, 15, $FW_SEMIBOLD, $GUI_FONTNORMAL)
GUICtrlCreateLabel ("Dita Map", 20, 85)
Global $Input1 = GUICtrlCreateInput(IniRead($sConfig, "Config", "ditamap", ""), 90, 80, 570, 20, -1)
GUICtrlCreateLabel ("Tip. '000_'으로 시작하는 ditamap 파일을 선택하세요.", 90, 105)
GUICtrlSetState($Input1, $GUI_DROPACCEPTED)
GUICtrlSetTip($Input1, 'ditamap 파일을 드래그하세요.')
Global $Button1 = GUICtrlCreateButton("파일 선택", 675, 76, 81, 25)

GUICtrlCreateLabel ("Publist", 20, 135)
Global $Input2 = GUICtrlCreateInput(IniRead($sConfig, "Config", "Publist", ""), 90, 130, 570, 20, -1)
GUICtrlSetState($Input2, $GUI_DROPACCEPTED)
GUICtrlSetTip($Input2, 'Publist 파일을 드래그하세요.')
Global $Button2 = GUICtrlCreateButton("파일 선택", 675, 126, 81, 25)
Global $langNum = GUICtrlCreateLabel ("", 90, 155, 572, 15)

If GUICtrlRead($Input2) = "" Then
	GUICtrlSetData($langNum, $totalLang & "publist 파일을 선택하세요.")
Else
	_FileReadToArray(GUICtrlRead($Input2), $langArray) ;~ publist 파일을 읽어들인다.
	$totalLang = UBound($langArray, $UBOUND_ROWS) - 1
	GUICtrlSetData($langNum, $totalLang & " 개의 언어가 선택되었습니다.")
EndIf

;~ validator 불러오기
Global $arr = _FileListToArray(@ScriptDir & "\_reference\Validator", "*.xlsm")
;~ _ArraySort($arr)
;~ _ArrayDisplay($arr)
Global $sList = ""
Global $last = UBound($arr) - 1

For $j = 1 To UBound($arr) - 1
	$sList &= "|" & $arr[$j]
Next

GUICtrlCreateLabel ("Validator", 20, 180)
Global $hCombo = GUICtrlCreateCombo("", 90, 176, 226.5, 20)
GUICtrlSetData($hCombo, $sList, $arr[$last])

Global $Button5 = GUICtrlCreateButton("실행", 326.5, 173, 81, 25)

Global $Button6 = GUICtrlCreateButton("PNG", 427.5, 173, 81, 25)

Global $Button3 = GUICtrlCreateButton("Publish", 675, 173, 81, 25)
GUICtrlSetFont(-1, 10, $FW_BOLD, $GUI_FONTNORMAL)

Global $filterCheck = GUICtrlCreateCheckbox("", 655, 175, 20, 20, -1, $WS_EX_TRANSPARENT)
Global $caseStop

GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel ("ditaval 사용", 585, 180)

$CMD_WINDOW = GUICtrlCreateEdit("", 20, 215, 734, 210, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY,$WS_VSCROLL))
	GUICtrlSetFont($CMD_WINDOW, 9, 400, 0, "Arial")
	GUICtrlSetColor($CMD_WINDOW, 0xFFFFFF)
	GUICtrlSetBkColor($CMD_WINDOW, 0x000000)

GUISetState()

While 1
	Global $msg = GuiGetMsg()

	Switch $msg
		Case $GUI_EVENT_CLOSE
			IniWrite($sConfig, "Config", "ditamap", GUICtrlRead($Input1))
			IniWrite($sConfig, "Config", "ditamapPath", StringRegExpReplace(GUICtrlRead($Input1), "([^\\]+)\.(ditamap)", ""))
			IniWrite($sConfig, "Config", "Publist", GUICtrlRead($Input2))
			IniWrite($sConfig, "Config", "PublistPath", StringRegExpReplace(GUICtrlRead($Input2), "([^\\]+)\.(txt)", ""))
			GUIDelete()
			ExitLoop
		
		;~ Case $Button4
		;~ 	Local $foo = Run(@ComSpec & " /c " & "IPCONFIG /ALL",@SystemDir,@SW_HIDE,$STDOUT_CHILD)
		;~ 	Local $line
		;~ 	While 1
		;~ 		$line = StdoutRead($foo)
		;~ 		If @error Then ExitLoop
		;~ 		If Not $line = "" Then GUICtrlSetData($CMD_WINDOW,$line)
		;~ 	WEnd

		Case $GUI_EVENT_DROPPED
			If @GUI_DropId = $Input1 Then
				GUICtrlSetData($Input1, @GUI_DragFile)
				IniWrite($sConfig, "Config", "ditamapPath", StringRegExpReplace(GUICtrlRead($Input1), "([^\\]+)\.(ditamap)", ""))
			ElseIf @GUI_DropId = $Input2 Then
				GUICtrlSetData($Input2, @GUI_DragFile)
				IniWrite($sConfig, "Config", "PublistPath", StringRegExpReplace(GUICtrlRead($Input2), "([^\\]+)\.(txt)", ""))
				_FileReadToArray(GUICtrlRead($Input2), $langArray) ;~ publist 파일을 읽어들인다.
				$totalLang = UBound($langArray, $UBOUND_ROWS) - 1
				GUICtrlSetData($langNum, $totalLang & " 개의 언어가 선택되었습니다.")
			EndIf

		Case $Button1
			$ditamap = FileOpenDialog($msgfile, IniRead($sConfig, "Config", "ditamapPath", @ScriptDir), "ditamap Files (*.ditamap)", 1 )
			If @error Then
				;~ MsgBox($MB_SYSTEMMODAL, "", "파일을 선택하지 않았습니다.")
			Else
				GUICtrlSetData($Input1, $ditamap)
				IniWrite($sConfig, "Config", "ditamapPath", StringRegExpReplace(GUICtrlRead($Input1), "([^\\]+)\.(ditamap)", ""))
			EndIf
		
		Case $Button2
			$publist = FileOpenDialog($msgfile, IniRead($sConfig, "Config", "PublistPath", @ScriptDir), "publist Files (*.txt)", 1 )
			If @error Then
				;~ MsgBox($MB_SYSTEMMODAL, "", "파일을 선택하지 않았습니다.")
			Else
				GUICtrlSetData($Input2, $publist)
				IniWrite($sConfig, "Config", "PublistPath", StringRegExpReplace(GUICtrlRead($Input2), "([^\\]+)\.(txt)", ""))
				_FileReadToArray(GUICtrlRead($Input2), $langArray) ;~ publist 파일을 읽어들인다.
				$totalLang = UBound($langArray, $UBOUND_ROWS) - 1
				GUICtrlSetData($langNum, $totalLang & " 개의 언어가 선택되었습니다.")
			EndIf
		
		Case $Button3
			If @error Then
				MsgBox($MB_SYSTEMMODAL, "", "ditamap 또는 publist 파일을 선택하지 않았습니다.")
			Else
				GUISetState(@SW_DISABLE) ;~ 메인 윈도우 비활성화
				Local $iHours, $iMins, $iSecs
				Local $vDitamap = GUICtrlRead($Input1) ;~ Input1을 $vDitamap 정의
				Local $vPublist = GUICtrlRead($Input2) ;~ Input2을 $vPublist 정의
				Local $publistArray, $vOption, $i, $j, $dummy
				$hFile = FileOpen($logFile, 1) ;~ 로그 파일 열기
				$manualPath = StringRegExpReplace($vDitamap, "\\BASIC\\([^\\]+)\.(ditamap)", "") ;~ 매뉴얼 경로 값을 얻는다.
				$mapName = StringMid($vDitamap, StringInStr($vDitamap,'\',0,-1)+1)
				$NmapName = StringReplace($mapName, "000_", "")
				$containerPath = $manualPath & '\out\2_HTML\container' ;html container 경로 값
				$filter = $manualPath & '\_filter\' ;필터 경로
				$dummy = $manualPath & '\dummy.xml' ;더미 파일

				If Not FileExists($vDitamap) Then ;ditamap 파일이 있는지 확인
					MsgBox($MB_SYSTEMMODAL, "", "ditamap 파일이 없습니다.")
					ProgressOff() ;~ 프로그레스바 닫기
					GUISetState(@SW_ENABLE) ;~ 메인 윈도우 비활성화
					ContinueCase
				ElseIf Not FileExists($vPublist) Then ;publist 파일이 있는지 확인
					MsgBox($MB_SYSTEMMODAL, "", "publist 파일이 없습니다.")
					ProgressOff() ;~ 프로그레스바 닫기
					GUISetState(@SW_ENABLE) ;~ 메인 윈도우 비활성화
					ContinueCase
				Else
					;~ GUISetState(@SW_DISABLE) ;메인 윈도우 비활성화
					Local $RunningTime = TimerInit() ;시작 시간 체크
					Local $Result
					ProgressOn("Protean UI", "PDF, HTML, ICML 출력 진행 중입니다", "시작...", -1, -1, $DLG_MOVEABLE)

					;~ ConsoleWrite($vPublist & @CRLF & $manualPath & @CRLF & $mapName & @CRLF & $NmapName & @CRLF & $containerPath & @CRLF)
					
					ProgressSet(0, "HTML 폴더 확인 중...")
					;~ HTML\container 폴더가 있으면 삭제한다.
					_FileWriteLog($hFile, "Checking 2_HTML - Container Folder ...")
					If FileExists($containerPath) Then
						DirRemove($containerPath,  $DIR_REMOVE)
						_FileWriteLog($hFile, "Delete 2_HTML - Container Folder ...")
					Else
						_FileWriteLog($hFile, "Can't found the 2_HTML - Container Folder ...")
					EndIf

					ProgressSet(0, "AH Formatter 연결 중...")

					ProgressSet(0, "publist 파일 읽는 중...")
					_FileReadToArray($vPublist, $publistArray) ;~ publist 파일을 읽어들인다.

					For $i=1 To UBound($publistArray) - 1
						local $percent = Round($i / (UBound($publistArray) - 1) * 100, -1)
						;~ ConsoleWrite("Languages " & $i & " " & $publistArray[$i] & @CRLF)
						$vOption = StringSplit($publistArray[$i], ",", 3)
						_FileWriteLog($hFile, "Language Code = " & $vOption[1])
						$Result = connectAHF($hFile, $vOption[1]) ;~ AH Formatter 연결
						If $Result = "err01" Then
							_FileWriteLog($hFile, "AH Formatter Not connected ...")
							ProgressOff() ;~ 프로그레스바 닫기
							GUISetState(@SW_ENABLE) ;~ 메인 윈도우 비활성화
							ContinueCase
						ElseIf $Result = "ok" Then
						
						EndIf
						If GUICtrlRead($filterCheck) = $GUI_CHECKED Then ;ditaval 사용을 체크했을 경우
							;~ ConsoleWrite($vOption[0] & ' ' & $vOption[1] & @CRLF)
							ProgressSet($percent, $percent & "%," & $vOption[1] & " 출력 중...")
								makeDitamap($hFile, $dummy, $vDitamap, $vOption) ;lang, LV_name 적용된 ditamap 파일 만들기
								makePdfandHTMLwithFilter($hFile, $ditaot, $manualPath, $NmapName, $vOption, $filter) ;필터 적용하여 출력하기
								Sleep(1000) ;잠시 대기
						Else ;ditaval 사용을 체크하지 않았을 경우
							;~ ConsoleWrite($vOption[0] & ' ' & $vOption[1] & @CRLF)
							ProgressSet($percent, $percent & "%," & $vOption[1] & " 출력 중...")
								makeDitamap($hFile, $dummy, $vDitamap, $vOption) ;lang, LV_name 적용된 ditamap 파일 만들기
								makePdfandHTMLNoneFilter($hFile, $ditaot, $manualPath, $NmapName, $vOption) ;필터 적용하지 않고 출력하기
								Sleep(1000) ;잠시 대기
						EndIf
						disconnectAHF($hFile) ;~ AH Formatter 해제
					Next

					;~ ;~ 마무리 작업
					makeDebug($hFile, $manualPath, $dummy, $sDummy)
					;~ FileDelete($manualPath & '\BASIC\' & $NmapName) ;생성된 ditamap 파일 삭제
					calTiming($RunningTime)
					ProgressSet(100, "100%, 마무리 작업 중...")
					FileClose($hFile) ;~ 로그 파일 닫기
					ProgressOff() ;~ 프로그레스바 닫기
					GUISetState(@SW_ENABLE) ;~ 메인 윈도우 비활성화
					Run("explorer.exe " & $manualPath & '\out')
					MsgBox($MB_SYSTEMMODAL, "", "완료, 소요시간 : " & StringFormat("%02d:%02d:%02d", $iHours, $iMins, $iSecs))
					;~ GUISetState(@SW_ENABLE) ;메인 윈도우 비활성화
				EndIf
			EndIf
		Case $caseStop
		
		Case $Button5 ;Validator 실행
			Local $valiExcel = GUICtrlRead($hCombo)
			If $valiExcel Then
				Local $var = @scriptdir & '\_reference\Validator\' & $valiExcel
				Local $oExcel = _Excel_Open(True, Default, Default, Default, True)
				Local $oWorkbook = _Excel_BookOpen($oExcel, $var, True)
			Else
				MsgBox($MB_SYSTEMMODAL, "", "버전에 맞는 Validator 파일을 선택하세요.")
			EndIf

		Case $Button6 ;PNG 만들기
			GUISetState(@SW_DISABLE) ;~ 메인 윈도우 비활성화
			Local $magick = @ScriptDir & "\lib\magick\magick.exe"
			Local $vDitamap = GUICtrlRead($Input1) ;~ Input1을 $vDitamap 정의
			Local $manualPath = StringRegExpReplace($vDitamap, "\\BASIC\\([^\\]+)\.(ditamap)", "") ;~ 매뉴얼 경로 값을 얻는다.
			Local $imagePath = $manualPath & "\images"
			Local $svgs = _FileListToArray($imagePath, "*.svg")
			Local $s, $pngName
			Local $hFile = FileOpen($logFile, 1) ;~ 로그 파일 열기

			ProgressOn("Protean UI", "SVG → PNG 이미지 변환", "시작...", -1, -1, $DLG_MOVEABLE)

			If FileExists($manualPath & "\out\PNG") Then
				DirRemove($manualPath & "\out\PNG", 1)
				DirCreate($manualPath & "\out\PNG")
			Else
				DirCreate($manualPath & "\out\PNG")
			EndIf
			
			For $s = 1 To UBound($svgs) - 1
				$pngName = StringReplace($svgs[$s], ".svg", ".png")
				local $percent = Round($s / (UBound($svgs) - 1) * 100, -1)

				ProgressSet($percent, $percent & "%," & " 변환 중...")
				If StringInStr($svgs[$s], "btn") Or StringInStr($svgs[$s], "ico") Then
					RunWait(@ComSpec & ' /c' & $magick & ' convert -density 5000 -resize 100 -background none ' & $svgs[$s] & " " & $manualPath & "\out\PNG\" & $pngName, $imagePath, @SW_HIDE)
					ConsoleWrite($magick & ' convert -density 5000 -resize 100 -background none ' & $svgs[$s] & " " & $manualPath & "out\PNG\" & $pngName)
					_FileWriteLog($hFile, $magick & ' convert -density 5000 -resize 100 -background none ' & $svgs[$s] & " " & $manualPath & "\out\PNG\" & $pngName)
				ElseIf StringInStr($svgs[$s], "smart-ui") Or StringInStr($svgs[$s], "ANT_IN") Or StringInStr($svgs[$s], "LAN") Or StringInStr($svgs[$s], "my_bixby_tutorial") Or StringInStr($svgs[$s], "SC_Paring") Or StringInStr($svgs[$s], "WIFI_Connect") Or StringInStr($svgs[$s], "connection_ant_") Then
					;~ Nothing
				Else
					RunWait(@ComSpec & ' /c' & $magick & ' convert -density 5000 -background none ' & $svgs[$s] & " " & $manualPath & "\out\PNG\" & $pngName, $imagePath, @SW_HIDE)
					_FileWriteLog($hFile, $magick & ' convert -density 5000 -background none ' & $svgs[$s] & " " & $manualPath & "\out\PNG\" & $pngName)
				EndIf
			Next

			FileClose($hFile)
			GUISetState(@SW_ENABLE) ;~ 메인 윈도우 활성화
			ProgressOff() ;~ 프로그레스바 닫기
			MsgBox($MB_SYSTEMMODAL, "", "이미지 변환을 완료합니다.")
	
	EndSwitch
WEnd


;~ 프로세스 모듈
Func connectAHF($hFile, $lCode) ;~ ahformatter 연결
	If ($lCode = "BUR") Or ($lCode = "THA") Or ($lCode = "ARA") Or ($lCode = "HEB")  Or ($lCode = "PER") Or ($lCode = "KOR") Or ($lCode = "ENG-KR") Then
		Local $ahVer = "71"
	Else
		Local $ahVer = "63"
	EndIf
	RunWait(@ComSpec & ' /c' & 'net use z: \\10.10.10.222\Antenna-House\AHFormatterV' & $ahVer & ' /user:facc ast141# >NUL', @ScriptDir, @SW_HIDE)
	;~ net use Z: \\10.10.10.222\AHFormatterV63 /PERSISTENT:YES
	_FileWriteLog($hFile, 'net use z: \\10.10.10.222\Antenna-House\AHFormatterV' & $ahVer & ' >NUL')
	If Not FileExists("Z:\") Then
		MsgBox($MB_SYSTEMMODAL, "", "AHF Formatter에 연결되지 않았습니다. 사내 고정 IP를 사용하는지 확인하세요.")
		_FileWriteLog($hFile, 'ERROR : AHF Formatter not connect, chek ip address')
		Return "err01"
	Else
		_FileWriteLog($hFile, 'AHF Formatter Connect Complete')
		Return "ok"
	EndIf
EndFunc

Func disconnectAHF($hFile) ;~ ahformatter 해제
 	RunWait(@ComSpec & ' /c' & 'net use z: /delete /y >NUL', @ScriptDir, @SW_HIDE)
 	_FileWriteLog($hFile, 'Disconnect AHFormatter ... net use z: /delete /y >NUL')
EndFunc

Func makeDitamap($hFile, $dummy, $vDitamap, $vOption)
	Local $cmd1, $line1
	$cmd1 = Run(@ComSpec & ' /c' & 'set CLASSPATH= && set CLASSPATH=' & @ScriptDir & '\lib\saxon9ee.jar && java net.sf.saxon.Transform -o:' & $dummy & ' -s:' & $vDitamap & ' -xsl:' & @ScriptDir & '\_reference\xsls\00-identity.xsl lang_code=' & $vOption[0] & ' status=custpdf_html5 LV_name=' & $vOption[1], $manualPath, @SW_HIDE)
	_FileWriteLog($hFile, 'making ditmap files for languages ...' & @CRLF & 'set CLASSPATH= && set CLASSPATH=' & @ScriptDir & '\lib\saxon9ee.jar && java net.sf.saxon.Transform -o:' & $dummy & ' -s:' & $vDitamap & ' -xsl:' & @ScriptDir & '\_reference\xsls\00-identity.xsl lang_code=' & $vOption[0] & ' status=custpdf_html5 LV_name=' & $vOption[1])
EndFunc

Func makeDebug($hFile, $manualPath, $dummy, $sDummy)
	Local $cmd4, $line4
	FileCopy($sDummy, $manualPath)
	_FileWriteLog($hFile, 'Copy the file ' & $sDummy & ' to ' & $manualPath)
	$cmd4 = RunWait(@ComSpec & ' /c' & 'set CLASSPATH= && set CLASSPATH=' & @ScriptDir & '\lib\saxon9ee.jar && java net.sf.saxon.Transform -o:dummy.xml -s:dummy.xml -xsl:..\..\_reference\xsls\29-debug-abstract.xsl', $manualPath, @SW_HIDE)
	_FileWriteLog($hFile, 'set CLASSPATH= && set CLASSPATH=' & @ScriptDir & '\lib\saxon9ee.jar && java net.sf.saxon.Transform -o:dummy.xml -s:dummy.xml -xsl:..\..\_reference\xsls\29-debug-abstract.xsl')
	FileMove($manualPath & '\debugs-abstract.html', $manualPath & '\out\2_HTML\debugs\', $FC_OVERWRITE + $FC_CREATEPATH) ;디버그 파일 옮기기
	FileDelete($dummy)
	_FileWriteLog($hFile, 'Remove the file ' & $dummy)
EndFunc

Func makePdfandHTMLwithFilter($hFile, $ditaot, $manualPath, $NmapName, $vOption, $filter)
	Local $pdfSet = @ScriptDir & "\pdfSet\AHFSettings.xml"
	Local $cmd2, $line2
	$cmd2 = Run(@ComSpec & ' /c' & 'set CLASSPATH= && set CLASSPATH=' & @ScriptDir & '\lib\saxon9.jar && set CLASSPATH=' & @ScriptDir & '\lib\saxon9-xqj.jar &&' & $ditaot & '\bin\dita.bat --input=' & $manualPath & '\Basic\' & $NmapName & ' --format=custpdf_html5 -DLV_name=' & $vOption[1] & ' -Denv.AXF_OPT=' & $pdfSet & ' --args.filter=' & $filter & $vOption[2], $manualPath, @SW_HIDE, $STDOUT_CHILD)
	_FileWriteLog($hFile, 'set CLASSPATH= && set CLASSPATH=' & @ScriptDir & '\lib\saxon9.jar && set CLASSPATH=' & @ScriptDir & '\lib\saxon9-xqj.jar &&' & $ditaot & '\bin\dita.bat --input=' & $manualPath & '\Basic\' & $NmapName & ' --format=custpdf_html5 -DLV_name=' & $vOption[1] & ' -Denv.AXF_OPT=' & $pdfSet & ' --args.filter=' & $filter & $vOption[2])
	ProcessWaitClose($cmd2)
	While 1
		$line2 = StdoutRead($cmd2)
		If @error Then ExitLoop
		If Not $line2 = "" Then 
			GUICtrlSetData($CMD_WINDOW, $line2) 
			_FileWriteLog($hFile, $line2)
		EndIf
	WEnd
EndFunc

Func makePdfandHTMLNoneFilter($hFile, $ditaot, $manualPath, $NmapName, $vOption)
	Local $pdfSet = @ScriptDir & "\pdfSet\pdf-settings.xml"
	Local $cmd3, $line3
	$cmd3 = Run(@ComSpec & ' /c' & $ditaot & '\bin\dita.bat --input=' & $manualPath & '\Basic\' & $NmapName & ' --format=custpdf_html5 -DLV_name=' & $vOption[1] & ' -Denv.AXF_OPT=' & $pdfSet, $manualPath, @SW_HIDE, $STDOUT_CHILD)
	_FileWriteLog($hFile, $ditaot & '\bin\dita.bat --input=' & $manualPath & '\Basic\' & $NmapName & ' --format=custpdf_html5 -DLV_name=' & $vOption[1] & ' -Denv.AXF_OPT=' & $pdfSet)
	ProcessWaitClose($cmd3)
	While 1
		$line3 = StdoutRead($cmd3)
		If @error Then ExitLoop
		If Not $line3 = "" Then
			GUICtrlSetData($CMD_WINDOW, $line3)
			_FileWriteLog($hFile, $line3)
		EndIf
	WEnd
EndFunc

Func calTiming($RunningTime) ;~ 완료시간 계산하기
	Global $iHours = 0, $iMins = 0, $iSecs = 0
	Global $iEnd = TimerDiff($RunningTime)
	_TicksToTime($iEnd, $iHours, $iMins, $iSecs)
EndFunc