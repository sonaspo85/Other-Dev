#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile_x64=MA-Estimate-tool.exe
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Date.au3>
#include <Array.au3>
#include <Constants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <AutoItConstants.au3>
#include <File.au3>
#include <Excel.au3>
#include <ExcelConstants.au3>
#include <String.au3>
#include <StringConstants.au3>
#include <EditConstants.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>
#include <WinAPIShellEx.au3>
#include "functions\_getRegion.au3"
#include "functions\_getRow.au3"
#include "functions\_duplicatePages.au3"
#include "functions\_mergeStat.au3"
#include "functions\_importprice.au3"
;~ #include "functions\_db2xml.au3"

Global $Form1 = GUICreate("Estimate Tool for MA ver 0.0.4", 500, 200, -1, -1, -1, $WS_EX_ACCEPTFILES)
Global $sConfig = @ScriptDir & '\config.ini'

Global $title = GUICtrlCreateLabel ("무선 청구서 제작 툴", 20, 18, 480)
GUICtrlSetFont(-1, 15, 600, 0)
Global $Label1 = GUICtrlCreateLabel ("청구서 :", 20, 65)
Global $Input1 = GUICtrlCreateInput("", 80, 60, 390, 20, -1) ;~ IDML 압축 파일명

;~ Global $Label2 = GUICtrlCreateLabel ("모델명 :", 20, 95)
;~ Global $Input2 = GUICtrlCreateInput("", 80, 90, 160, 20, -1) ;~ IDML 압축 파일명

Global $Label3 = GUICtrlCreateLabel ("담당자 :", 260, 95)
Global $selSec = GUICtrlCreateCombo("", 310, 90, 160, 20)
GUICtrlSetData($selSec, FileReadLine(@ScriptDir & "\resource\sec.txt", 1))

Global $Label4 = GUICtrlCreateLabel ("청구일 :", 20, 125)
Global $idDate = GUICtrlCreateDate("", 80, 120, 160)
Local $sStyle = "yyyy-MM-dd"
GUICtrlSendMsg($idDate, $DTM_SETFORMATW, 0, $sStyle)

Global $Label5 = GUICtrlCreateLabel ("템플릿 :", 260, 125)
Global $iTemp = GUICtrlCreateCombo("", 310, 120, 160, 20)
GUICtrlSetData($iTemp, "2022", "2022")

Global $genEstimate = GUICtrlCreateButton("청구서 만들기", 370, 160, 100, 25)
Global $mergeStat = GUICtrlCreateButton("통계 만들기", 20, 160, 100, 25)
Global $type = ["UM", "QSG"]
Global $getStamp = @ScriptDir & "\functions\getStamp\getStamp.exe"
Global $dbXML = ObjCreate('Microsoft.XMLDOM')
$dbXML.Load(@scriptDir & '\resource\db.xml')
Global $rexgVer = "(D\d+|Rev\.\d\.\d)"

_main()

Func _main()
	GUISetState()

	While 1
		Global $msg = GuiGetMsg()
		Global $break
		Switch $msg

		Case $GUI_EVENT_CLOSE
			GUIDelete()
			ExitLoop

		Case $mergeStat
			Local $mfD = FileSelectFolder("청구서가 모아진 폴더를 선택하세요.", @ScriptDir)
			Local $efArr = _FileListToArray($mfD, "*.xlsx", 1, True)
			Local $statics = @ScriptDir & "\template\statistics-template.xlsx"
			Local $oExcel = _Excel_Open(False, False, False)
			Local $wkBook = _Excel_BookOpen($oExcel, $statics)
			Local $stSht = $wkBook.Sheets(1)
			Local $n, $i, $sType, $sBook, $jastSht
			Local $fileCount = UBound($efArr) - 1
			GUISetState(@SW_DISABLE)
			ProgressOn("청구서 항목별 통계", "청구서 항목별 통계 취합 중...", "", -1, -1, BitOr($DLG_CENTERONTOP, $DLG_MOVEABLE))
			For $n = 1 To UBound($efArr) - 1
				$progress = ($n / $fileCount) * 100
				ProgressSet($progress, "",  "진행률 " & $n & "/" & $fileCount)

				$sBook = _Excel_BookOpen($oExcel, $efArr[$n])
				$jastSht = $sBook.Sheets.Count
				_mergedStat($sBook, $stSht, $jastSht)
				_Excel_BookClose($sBook, False)
			Next

			Local $trBook = $mfD & "\" & StringRegExpReplace(_NowDate(), "\-", "") & "_청구서항목별통계.xlsx"
			_Excel_BookSaveAs($wkBook, $trBook, $xlWorkbookDefault, True)
			_Excel_Close($oExcel, True)
			$oExcel = "" ; 엑셀 메모리 초기화
			ProgressOff()
			MsgBox(0, "청구서 항목별 통계", "완료합니다.")
			GUISetState(@SW_ENABLE)

		Case $genEstimate
			Local $getName = GUICtrlRead($Input1)
			;~ Local $modName = GUICtrlRead($Input2)
			Local $secName = GUICtrlRead($selSec)
			Local $getDate = GUICtrlRead($idDate)
			Local $getTemp = GUICtrlRead($iTemp)
			Local $template

			If $getName = "" Or $secName = "" Or $getTemp = "" Then
				MsgBox(0, "Error", "입력하지 않은 항목이 있습니다.")
				ContinueCase
			EndIf

			Local $fD = FileSelectFolder("청구 근거 폴더를 선택하세요.", IniRead($sConfig, "Config", "last_path", @ScriptDir))

			If @error Then
				ContinueCase
			EndIf

			If Not FileExists($fD) Then
				MsgBox(0, "Error", "선택한 폴더가 졶재하지 않습니다.")
				ContinueCase
			EndIf

			IniWrite($sConfig, "Config", "last_path", $fD)

			Switch $getTemp
				Case "2022"
					$template = @ScriptDir & "\template\2022_template.xlsx"
			EndSwitch

			If Not FileExists($template) Then
				MsgBox(0, "Error", $template & @CRLF & "파일이 없습니다.")
				ContinueCase
			EndIf
			GUISetState(@SW_DISABLE)
			ProgressOn("청구서 제작", "청구서 제작 중입니다...", "", -1, -1, BitOr($DLG_CENTERONTOP, $DLG_MOVEABLE))

			Local $oExcel = _Excel_Open(False, False, False)
			Local $wkBook = _Excel_BookOpen($oExcel, $template)
			Local $tgBook = $fd & "\" & StringRegExpReplace($getDate, "\-", "") & "_" & $getName & ".xlsx"
			_Excel_BookSaveAs($wkBook, $tgBook, $xlWorkbookDefault , True)

			Local $RS = _writeEstimate($fD, $type, $oExcel, $wkBook, $secName, $getDate)
			;~ Error 유형 별 종료
			If $RS = -1 Then
				ProgressOff()
				GUISetState(@SW_ENABLE)
				_Excel_BookSave($oExcel)
				_Excel_Close($oExcel, False, True)
				;~ $oExcel.Application.Visible = True
				;~ $oExcel.Application.ScreenUpdating = True
				;~ $oExcel.Application.DisplayAlerts = True
				$oExcel = ""
				FileDelete($tgBook)
				ContinueCase
			ElseIf $RS = -2 Then
				GUISetState(@SW_ENABLE)
				_Excel_BookSave($oExcel)
				_Excel_Close($oExcel, False, True)
				;~ $oExcel.Application.Visible = True
				;~ $oExcel.Application.ScreenUpdating = True
				;~ $oExcel.Application.DisplayAlerts = True
				$oExcel = ""
				FileDelete($tgBook)
				MsgBox(0, 'Error', '설정하지 않은 언어가 있습니다. 폴더의 언어명을 확인한 후 진행하세요.')
				ContinueCase
			EndIf

			;~ Total 정리하기
			ProgressSet(100, "Total 정리 중...",  "")
			Local $tSht = $wkBook.Sheets("Total")
			$tSht.Activate
			$tSht.Cells(5, 3).Value = $getDate
			$tSht.Cells(8, 6).Value = $secName
			Local $xx, $tRow, $tModName, $tType, $tRegion, $tLang, $tSum
			Local $bModName, $bType, $bRegion, $bLang, $bSum
			Local $totalSht = $wkBook.Sheets.Count - 7
			;~ totalSht가 30개를 넘을 경우 totalSht - 30 만큼 row 추가
			If $totalSht > 30 Then
				Local $xy
				For $xy = 1 To $totalSht - 30
					$tSht.Cells(39, 2).EntireRow.Insert
					$tSht.Range("E39:F39").Merge
				Next
			EndIf
			$tRow = 11
			For $xx = 1 To $totalSht
				If $xx = 1 Then
					$tModName = $wkBook.Sheets($xx + 7).Cells(2, 3).Value
					$tType = $wkBook.Sheets($xx + 7).Cells(2, 5).Value
					$tRegion = $wkBook.Sheets($xx + 7).Cells(3, 3).Value
					$tLang = $wkBook.Sheets($xx + 7).Cells(3, 5).Value
					$tSum = $wkBook.Sheets($xx + 7).Cells(2, 8).Value

					$tSht.Cells($tRow, 2).Value = $tModName
					$tSht.Cells($tRow, 3).Value = $tType
					$tSht.Cells($tRow, 4).Value = $tRegion
					$tSht.Cells($tRow, 5).Value = $tLang
					$tSht.Cells($tRow, 7).Value = $tSum
					$tRow = $tRow + 1
				Else
					$bModName = $tSht.Cells($tRow - 1, 2).Value
					$bType = $tSht.Cells($tRow - 1, 3).Value
					$bRegion = $tSht.Cells($tRow - 1, 4).Value
					$bLang = $tSht.Cells($tRow - 1, 5).Value
					$bSum = $tSht.Cells($tRow - 1, 7).Value

					$tModName = $wkBook.Sheets($xx + 7).Cells(2, 3).Value
					$tType = $wkBook.Sheets($xx + 7).Cells(2, 5).Value
					$tRegion = $wkBook.Sheets($xx + 7).Cells(3, 3).Value
					$tLang = $wkBook.Sheets($xx + 7).Cells(3, 5).Value
					$tSum = $wkBook.Sheets($xx + 7).Cells(2, 8).Value

					If ($bModName = $tModName) And ($bType = $tType) And ($bRegion = $tRegion) And ($bLang = $tLang) Then
						$tSht.Cells($tRow - 1, 7).Value = $tSum + $bSum
					Else
						$tSht.Cells($tRow, 2).Value = $tModName
						$tSht.Cells($tRow, 3).Value = $tType
						$tSht.Cells($tRow, 4).Value = $tRegion
						$tSht.Cells($tRow, 5).Value = $tLang
						$tSht.Cells($tRow, 7).Value = $tSum
						$tRow = $tRow + 1
					EndIf
				EndIf
			Next
			Local $lRow = $tSht.Cells(10, 2).End(-4121).Row
			Local $xi, $xj, $cellVal, $ListArr = []
			For $xi = 11 To $lRow
				$cellVal = ""
				For $xj = 2 To 7
					If $xj = 6 Then
						;~ nothing
					ElseIf $xj = 7 Then
						$cellVal &= $tSht.Cells($xi, $xj).Value
					Else
						$cellVal &= $tSht.Cells($xi, $xj).Value & ","
					EndIf
				Next
				_ArrayAdd($ListArr, $cellVal)
			Next

			_ArraySort($ListArr)
			;~ _ArrayDisplay($ListArr)

			Local $xl, $xn = 1
			For $xl = 11 To $lRow
				$tSht.Cells($xl, 2).Value = StringSplit($ListArr[$xn], ",")[1]
				$tSht.Cells($xl, 3).Value = StringSplit($ListArr[$xn], ",")[2]
				$tSht.Cells($xl, 4).Value = StringSplit($ListArr[$xn], ",")[3]
				$tSht.Cells($xl, 5).Value = StringSplit($ListArr[$xn], ",")[4]
				$tSht.Cells($xl, 7).Value = StringSplit($ListArr[$xn], ",")[5]
				$xn = $xn + 1
			Next

			_Excel_BookSave($wkBook)

			Local $s
			For $s = 7 To $wkBook.Sheets.Count
				$wkBook.Sheets($s).Select(False)
			Next
			Local $pdfName = $fD & "\" & $getName & "_" & StringRegExpReplace($getDate, "\-", "") & ".pdf"
			_Excel_Export($oExcel, $wkBook.ActiveSheet, $pdfName, $xlTypePDF)

			_Excel_BookSave($oExcel)
			_Excel_Close($oExcel, False, True)
			$oExcel = ""
			ProgressOff()
			MsgBox(0, "Message", "완료합니다.")
			GUISetState(@SW_ENABLE)

		Case $break

		EndSwitch
	WEnd
EndFunc

Func _writeEstimate($destfD, $type, $oExcel, $wkBook, $secName, $getDate)
	;~ Local $destfD = "d:\TCS\_develop\146_MA-Estimate-manage\2.Reference\SM-A235F_MEA_MEA_QSG_UM_HTML_5개어_청구근거"
	;~ type 폴더인지 확인한다.
	Local $typeLists = _FileListToArray($destfD, "*", 2, False)
	Local $typePath = _FileListToArray($destfD, "*", 2, True)
	Local $t, $sType, $typeCount = UBound($typeLists) - 1, $cnt = 1

	For $t = 1 To $typeCount
		$sType = $typeLists[$t]
		If _ArraySearch($type, $sType, 0, 0, 0, 0) = -1 Then
			ProgressOff()
			MsgBox(0, "Error", "잘못된 폴더 타입 " & $sType & @CRLF & "하위 폴더 명이 올바른지 확인하고 진행하세요.")
			Return -1
		Else
			Local $langLists = _FileListToArray($typePath[$t], "*", 2, False)
			Local $langPath = _FileListToArray($typePath[$t], "*", 2, True)
			Local $l, $langName, $langCount = UBound($langLists) - 1
			Local $progress

			For $l = 1 To $langCount
				$langName = $langLists[$l]
				If StringInStr($langName, " (") Then
					$langName = StringReplace($langName, " (", "(")
				EndIf
				$progress = ($l / $langCount) * 100
				ProgressSet($progress, $sType & " : " & $langName & " 진행 중",  "진행률 " & $l & "/" & $langCount)
				ConsoleWrite($langName & @CRLF)

				Local $pdfLists = _FileListToArray($langPath[$l], "*.pdf", 1, False)
				Local $pdfPath = _FileListToArray($langPath[$l], "*.pdf", 1, True)
				Local $p, $pdfName, $pdfCount = UBound($pdfLists) - 1, $htmlList = [], $umList = []
				Local $Ver, $verLists = [], $uniqVer, $wriVerLists, $stampText
				Local $modName = StringSplit($pdfLists[1], "_")[1]

				;~ stamp 정보 출력하기
				For $p = 1 To $pdfCount
					$stampText = StringRegExpReplace($pdfPath[$p], ".pdf$", ".txt")
					If FileExists($stampText) Then
						FileDelete($stampText)
					EndIf
					;~ RunWait(@ComSpec & ' /c' & $getStamp & ' ' & '"' & $pdfPath[$p] & '"', @ScriptDir, @SW_HIDE)
					ShellExecute($getStamp, '"' & $pdfPath[$p] & '"', @ScriptDir, $SHEX_OPEN, @SW_HIDE)
				Next

				For $p = 1 To $pdfCount
					$pdfName = $pdfLists[$p]
					$Ver = StringRegExp($pdfName, $rexgVer, 1)

					Local $w
					;~ UM, QSG 구분
					If $sType = "QSG" Then
						_ArrayAdd($verLists, $Ver[0])
					ElseIf $sType = "UM" Then
						If StringInStr($pdfName, "HTML") Then
							_ArrayAdd($htmlList, $pdfName)
						ElseIf StringInStr($pdfName, "UM") Then
							_ArrayAdd($umList, $pdfName)
						EndIf
					EndIf
				Next

				Local $w, $mType
				If $sType = "QSG" Then
					ConsoleWrite("QSG: " & @CRLF)
					$mType = "QSG"
					$wriVerLists = _getRevLists($langName, $verLists)
					;~ 공통 ###########################################################
					Local $w, $i, $lastVer
					If StringInStr($langName, "English") Or StringInStr($langName, "Korean") Then ;~ 베이직 언어인 경우
						ConsoleWrite(_ArrayToString($wriVerLists) & @CRLF)
						ConsoleWrite(@TAB & _ArrayToString($pdfLists) & @CRLF)
						For $w = 1 To UBound($wriVerLists) - 1
							ConsoleWrite($mType & ":" & $langName & ":" & $wriVerLists[$w] & @CRLF)
							$cnt = _writeSheet($cnt, $oExcel, $wkBook, $secName, $mType, $modName, $langName, $wriVerLists[$w], $pdfLists, $langPath[$l])
							If $cnt = False Then
								ProgressOff()
								MsgBox(0, 'Error', $langName & ' 언어는 설정되어 있지 않습니다.')
								Return -2
							EndIf
						Next
					Else ;~ 다국어인 경우 최종 차수를 입력한다.
						ConsoleWrite($wriVerLists[UBound($wriVerLists) - 1] & @CRLF)
						$lastVer = $wriVerLists[UBound($wriVerLists) - 1]
						ConsoleWrite(_ArrayToString($lastVer) & @CRLF)
						ConsoleWrite($mType & ":" & $langName & ":" & $wriVerLists[UBound($wriVerLists) - 1] & @CRLF)
						ConsoleWrite(@TAB & _ArrayToString($pdfLists) & @CRLF)
						$cnt = _writeSheet($cnt, $oExcel, $wkBook, $secName, $mType, $modName, $langName, $lastVer, $pdfLists, $langPath[$l])
						If $cnt = False Then
							ProgressOff()
							MsgBox(0, 'Error', $langName & ' 언어는 설정되어 있지 않습니다.')
							Return -2
						EndIf
					EndIf
					;~ ################################################################
				Else
					;~ HTML, ONLINE-UM 구분
					If UBound($htmlList) - 1 > 0 Then
						Local  $verHtmlLists = []
						ConsoleWrite("HTML : " & UBound($htmlList) - 1)
						$mType = "HTML"
						Local $h, $htmlCount =  UBound($htmlList) - 1
						For $h = 1 To $htmlCount
							$Ver = StringRegExp($htmlList[$h], $rexgVer, 1)
							_ArrayAdd($verHtmlLists, $Ver[0])
						Next
						$wriVerLists = _getRevLists($langName, $verHtmlLists)
						;~ 공통 ###########################################################
						Local $w, $i, $lastVer
						If StringInStr($langName, "English") Or StringInStr($langName, "Korean") Then ;~ 베이직 언어인 경우
							ConsoleWrite(_ArrayToString($wriVerLists) & @CRLF)
							ConsoleWrite(@TAB & _ArrayToString($htmlList) & @CRLF)
							For $w = 1 To UBound($wriVerLists) - 1
								ConsoleWrite($mType & ":" & $langName & ":" & $wriVerLists[$w] & @CRLF)
								$cnt =_writeSheet($cnt, $oExcel, $wkBook, $secName, $mType, $modName, $langName, $wriVerLists[$w], $htmlList, $langPath[$l])
								If $cnt = False Then
									ProgressOff()
									MsgBox(0, 'Error', $langName & ' 언어는 설정되어 있지 않습니다.')
									Return -2
								EndIf
							Next
						Else ;~ 다국어인 경우 최종 차수를 입력한다.
							ConsoleWrite($wriVerLists[UBound($wriVerLists) - 1] & @CRLF)
							ConsoleWrite(_ArrayToString($lastVer) & @CRLF)
							ConsoleWrite($mType & ":" & $langName & ":" & $wriVerLists[UBound($wriVerLists) - 1] & @CRLF)
							ConsoleWrite(@TAB & _ArrayToString($htmlList) & @CRLF)
							$lastVer = $wriVerLists[UBound($wriVerLists) - 1]
							$cnt = _writeSheet($cnt, $oExcel, $wkBook, $secName, $mType, $modName, $langName, $lastVer, $htmlList, $langPath[$l])
							If $cnt = False Then
								ProgressOff()
								MsgBox(0, 'Error', $langName & ' 언어는 설정되어 있지 않습니다.')
								Return -2
							EndIf
						EndIf
						;~ ################################################################
					EndIf
					If UBound($umList) - 1 > 0 Then
						Local $verUmLists = []
						ConsoleWrite("ONLINE-UM : " & UBound($umList) - 1)
						$mType = "ONLINE-UM"
						Local $u, $umCount = UBound($umList) - 1
						For $u = 1 To $umCount
							$Ver = StringRegExp($umList[$u], $rexgVer, 1)
							_ArrayAdd($verUmLists, $Ver[0])
						Next
						$wriVerLists = _getRevLists($langName, $verUmLists)
						;~ 공통 ###########################################################
						Local $w, $i, $lastVer
						If StringInStr($langName, "English") Or StringInStr($langName, "Korean") Then ;~ 베이직 언어인 경우
							ConsoleWrite(_ArrayToString($wriVerLists) & @CRLF)
							ConsoleWrite(@TAB & _ArrayToString($umList) & @CRLF)
							For $w = 1 To UBound($wriVerLists) - 1
								ConsoleWrite($mType & ":" & $langName & ":" & $wriVerLists[$w] & @CRLF)
								$cnt = _writeSheet($cnt, $oExcel, $wkBook, $secName, $mType, $modName, $langName, $wriVerLists[$w], $umList, $langPath[$l])
								If $cnt = False Then
									ProgressOff()
									MsgBox(0, 'Error', $langName & ' 언어는 설정되어 있지 않습니다.')
									Return -2
								EndIf
							Next
						Else ;~ 다국어인 경우 최종 차수를 입력한다.
							ConsoleWrite($wriVerLists[UBound($wriVerLists) - 1] & @CRLF)
							ConsoleWrite(_ArrayToString($lastVer) & @CRLF)
							ConsoleWrite($mType & ":" & $langName & ":" & $wriVerLists[UBound($wriVerLists) - 1] & @CRLF)
							ConsoleWrite(@TAB & _ArrayToString($umList) & @CRLF)
							$lastVer = $wriVerLists[UBound($wriVerLists) - 1]
							$cnt = _writeSheet($cnt, $oExcel, $wkBook, $secName, $mType, $modName, $langName, $lastVer, $umList, $langPath[$l])
							If $cnt = False Then
								ProgressOff()
								MsgBox(0, 'Error', $langName & ' 언어는 설정되어 있지 않습니다.')
								Return -2
							EndIf
						EndIf
						;~ ################################################################
					EndIf
				EndIf
				FileDelete($langPath[$l] & "\*.txt")
			Next
		EndIf
	Next
EndFunc

Func _writeSheet($cnt, $oExcel, $wkBook, $secName, $mType, $modName, $langName, $wriVer, $fileLists, $langPath)
	Local $dbSht = $wkBook.Sheets('청구서')
	Local $lngSht = $wkBook.Sheets('언어목록')
	Local $stampInfo, $total = UBound($fileLists) - 1
	;~ 버전에 따른 시트 추가 ##############################################################
	Local $shtCnt = $wkBook.Sheets.Count
	Local $langType
	If Not(StringInStr($langName, "Korean") Or StringInStr($langName, "English")) Then
		Local $xRow = $oExcel.Match(StringRegExpReplace($langName, '_', ' '), $lngSht.Columns('B:B'), 0)
		$langType = $lngSht.Cells($xRow, 5).Value
	EndIf
	ConsoleWrite('langType - ' & $langType)

	If $mType = "HTML" Then
		_Excel_SheetCopyMove($wkBook, "HTML", Default, $shtCnt, False, True)
	ElseIf $mType = "ONLINE-UM" Or $mType = "QSG" Then
		If StringInStr($langName, "Korean") Or StringInStr($langName, "English") Or $langType = '국영문' Then
			_Excel_SheetCopyMove($wkBook, "국영문", Default, $shtCnt, False, True)
		Else
			_Excel_SheetCopyMove($wkBook, "다국어", Default, $shtCnt, False, True)
		EndIf
	EndIf
	;~ ####################################################################################

	;~ 추가한 시트 활성화 #################################################################
	$lastSht = $wkBook.Sheets.Count
	$wkBook.Sheets($lastSht).Name = $cnt
	Local $wkSht = $wkBook.Sheets($lastSht)
	$wkSht.Activate
	;~ ####################################################################################

	;~ 기본 정보 입력 #####################################################################
	With $wkSht
		.Cells(2, 3).Value = $modName ; 모델명 입력
		If $mType = "QSG" Then
			.Cells(2, 5).Value = "Book-" & $mType ; 유형
		ElseIf $mType = "ONLINE-UM" Then
			.Cells(2, 5).Value = $mType ; 유형
		ElseIf $mType = "HTML" Then
			.Cells(2, 5).Value = $mType ; 유형
		EndIf
		.Cells(3, 3).Value = _getRegion($fileLists[$total]) ;~지역
		If StringInStr($langName, "Korean") Or StringInStr($langName, "English") Then
			.Cells(3, 5).Value = StringRegExpReplace($langName, "(\[|\])", "") ; 언어
		Else
			.Cells(3, 5).Value = $langName ; 언어
		EndIf
		.Cells(4, 3).Value = $wriVer ;버전
		.Cells(4, 5).Value = $secName ;담당자
	EndWith
	;~ ####################################################################################

	;~ 단가 정보 입력 #####################################################################
	Local $groupNum
	If StringInStr($langName, "Korean") And $mType = "ONLINE-UM" Then
		_importBasicPrice($wkSht, $dbSht, 3, 8, 0)
	ElseIf StringInStr($langName, "Korean") And $mType = "QSG" Then
		_importBasicPrice($wkSht, $dbSht, 3, 9, 1)
	ElseIf (StringInStr($langName, "English") Or $langType = '국영문') And $mType = "ONLINE-UM" Then
		_importBasicPrice($wkSht, $dbSht, 2, 8, 0)
	ElseIf (StringInStr($langName, "English") Or $langType = '국영문') And $mType = "QSG" Then
		_importBasicPrice($wkSht, $dbSht, 2, 9, 1)
	ElseIf $mType = 'HTML' Then
		Local $srow = $oExcel.Match(StringRegExpReplace($langName, '_', ' '), $lngSht.Columns('B:B'), 0)
		If Not StringInStr($langName, 'English') Then
			If $srow = '' Then
				Return False
			Else
				$groupNum = StringRegExpReplace($lngSht.Cells($srow, 5).Value, '(언어 구분 |그룹)', '')
			EndIf
		EndIf

		If StringInStr($langName, 'English') Then
			$srow = 2
			_importHTMLPrice($wkSht, $dbSht, $srow, $langName)
		ElseIf $lngSht.Cells($srow, 5).Value = '국영문' Then
			_importHTMLPrice($wkSht, $dbSht, 0, $langName)
		Else
			_importHTMLPrice($wkSht, $dbSht, $groupNum, $langName)
		EndIf
	Else
		Local $srow = $oExcel.Match(StringRegExpReplace($langName, '_', ' '), $lngSht.Columns('B:B'), 0)
		ConsoleWrite('Error ' & $srow & @CRLF)
		If Not $srow Then
			Return False
		Else
			$groupNum = StringRegExpReplace($lngSht.Cells($srow, 5).Value, '(언어 구분 |그룹)', '')
		EndIf
		ConsoleWrite('111111111 ' & $srow & '--' & $groupNum & '--' & $langName & '--' & $mType & @CRLF)
		If $mType = 'ONLINE-UM' Then
			ConsoleWrite('2222222' & @CRLF)
			_importMulitPrice($wkSht, $dbSht, 8, $groupNum, 0, $langName)
			_importTRprice($wkSht, $lngSht, $srow)
		ElseIf $mType = 'QSG' Then
			ConsoleWrite('3333333' & @CRLF)
			_importMulitPrice($wkSht, $dbSht, 9, $groupNum, 1, $langName)
			_importTRprice($wkSht, $lngSht, $srow)
		EndIf
	EndIf

	;~ ####################################################################################

	ConsoleWrite($wriVer & @CRLF)
	Local $Desc = "" ;~ 상세 내역 초기화
	For $i = 1 To $total
		Local $pdName = $fileLists[$i]
		$stampInfo = $langPath & "\" & StringRegExpReplace($pdName, ".pdf$", ".txt")
		If StringInStr($langName, "Korean") Or StringInStr($langName, "English") Or $langType = '국영문' Then
			If $wriVer = StringRegExp($pdName, $rexgVer, 1)[0] Then
				_writeDetail($wkSht, $i, $stampInfo, $pdName, $mType, $langName, $langType, $Desc)
			EndIf
		Else
			_writeDetail($wkSht, $i, $stampInfo, $pdName, $mType, $langName, $langType, $Desc)
		EndIf
	Next

	$cnt = $cnt + 1
	Return $cnt
EndFunc


Func _getAttr($dbXML, $stName, $value)
	Local $stLists = $dbXML.selectNodes('//stamp')
	Local $ij

	For $ij in $stLists
		If $ij.getAttribute('name') = $stName Then
			Return $ij.getAttribute($value)
		EndIf
	Next
EndFunc

Func _writeDetail($wkSht, $i, $stampInfo, $pdName, $mType, $langName, $langType, $Desc)
	$Desc &= "—————< " & $pdName & " >—————" & @LF
	Local $m, $sLine, $hName
	Local $totalPage = StringSplit(FileReadLine($stampInfo, 1), ";")[2]

	For $m = 2 To _FileCountLines($stampInfo)
		$sLine = FileReadLine($stampInfo, $m)
		If $sLine = "" Then
			ContinueLoop
		EndIf
		$stName = StringSplit($sLine, ";")[1]
		$sPages = StringSplit($sLine, ";")[2]
		$rPages = _duplicatePages($sPages, $totalPage, $mType)

		If $mType = "HTML" Then
			$sRow = _getAttr($dbXML, $stName, "html")
		Else
			If StringInStr($langName, "Korean") Or StringInStr($langName, "English") Or $langType = '국영문' Then
				$sRow = _getAttr($dbXML, $stName, "basic")
			Else
				$sRow = _getAttr($dbXML, $stName, "multi")
			EndIf
		EndIf

		If $sRow = "False" Then
			ContinueLoop
		Else
			$pCount = UBound(StringSplit($sPages, ",")) - 1
			ConsoleWrite($stName & " -- " & $sRow & @CRLF)

			;~ stamp name에 따른 입력 방법
			If $stName = "G-trans" Then
				Local $wdCount = StringSplit($sLine, ";")[2]
				Local $wdNew = StringSplit(StringSplit($wdCount, "/")[2], ":")[2]
				Local $wdRep = StringSplit(StringSplit($wdCount, "/")[3], ":")[2]
				Local $wd100 = StringSplit(StringSplit($wdCount, "/")[4], ":")[2]
				Local $wd95_99 = StringSplit(StringSplit($wdCount, "/")[5], ":")[2]
				Local $wd75_94 = StringSplit(StringSplit($wdCount, "/")[6], ":")[2]
				Local $wdMin = StringSplit(StringSplit($wdCount, "/")[7], ":")[2]
				If UBound(StringSplit($wdCount, "/")) > 8 Then
					Local $transDay = StringSplit(StringSplit($wdCount, "/")[8], ":")[2]
					$wkSht.Cells($sRow - 2, 5).Value = $transDay
				EndIf
				With $wkSht
					If .Cells($sRow, 4).Value = "" Then
						.Cells($sRow, 4).Value = $wd95_99
					Else
						$bWd = Number(.Cells($sRow, 4).Value)
						.Cells($sRow, 4).Value = $bWd + $wd95_99
					EndIf

					If .Cells($sRow+1, 4).Value = "" Then
						.Cells($sRow+1, 4).Value = $wd75_94
					Else
						$bWd = Number(.Cells($sRow+1, 4).Value)
						.Cells($sRow+1, 4).Value = $bWd + $wd75_94
					EndIf

					If .Cells($sRow+2, 4).Value = "" Then
						.Cells($sRow+2, 4).Value = $wdNew
					Else
						$bWd = Number(.Cells($sRow+2, 4).Value)
						.Cells($sRow+2, 4).Value = $bWd + $wdNew
					EndIf
				EndWith
			ElseIf $stName = "G-exchange_rate" Then
				$exChange = StringSplit($sLine, ";")[2]
				$wkSht.Cells($sRow, 3).Value = $exChange
			ElseIf _getAttr($dbXML, $stName, "pages") = "True" Then
				$wkSht.Cells($sRow, 8).Value = $sPages
				$hName = "#" & _getAttr($dbXML, $stName, "hName")
				$Desc &= $hName & ": " & StringRegExpReplace($rPages, "\r", "") & @LF
			ElseIf _getAttr($dbXML, $stName, "pages") = "False" Then
				If $wkSht.Cells($sRow, 8).Value = "" Then
					$wkSht.Cells($sRow, 8).Value = $pCount
					$hName = "#" & _getAttr($dbXML, $stName, "hName")
					$Desc &= $hName & ": " & StringRegExpReplace($rPages, "\r", "") & @LF
				Else
					$bCount = Number($wkSht.Cells($sRow, 8).Value)
					$wkSht.Cells($sRow, 8).Value = $bCount + $pCount
					$hName = "#" & _getAttr($dbXML, $stName, "hName")
					$Desc &= $hName & ": " & StringRegExpReplace($rPages, "\r", "") & @LF
				EndIf
			EndIf
		EndIf
	Next
	Local $dRow, $bDesc
	If $mType = "HTML" Then
		$dRow = 19
	ElseIf $mType = "ONLINE-UM" Or $mType = "QSG" Then
		If StringInStr($langName, "Korean") Or StringInStr($langName, "English") Or $langType = '국영문' Then
			$dRow = 43
		Else
			$dRow = 47
		EndIf
	EndIf
	With $wkSht
		If .Cells($dRow, 2).Value = "" Then
			.Cells($dRow, 2).Value = "'" & StringRegExpReplace($Desc, "\,", ", ")
		ElseIf .Cells($dRow, 2).Value <> "" Then
			$bDesc = .Cells($dRow, 2).Value
			.Cells($dRow, 2).Value = $bDesc & StringRegExpReplace($Desc, "\,", ", ")
		EndIf
	EndWith
	;~ Return $Desc
EndFunc

Func _getRevLists($lang, $verLists)
	Local $verUnique = _ArrayUnique($verLists)
	_Arraysort($verUnique)

	;~ 베이직 언어인지 다국어인지 구분
	If StringInStr($lang, "English") Or StringInStr($lang, "Korean") Then
		_ArrayDelete($verUnique, 0)
		Return $verUnique
	Else
		Local $scRs = _ArrayFindAll($verUnique, "Rev", 0, 0, 0, 3)
		Local $v, $wriVers = []
		If UBound($scRs) > 0 Then
			For $v = 0 To UBound($scRs) - 1
				$sIndex = $scRs[$v]
				_ArrayAdd($wriVers, $verUnique[$sIndex])
			Next
		ElseIf UBound($scRs) = 0 Then
			_ArrayAdd($wriVers, "Rev.1.0")
		EndIf
		Return $wriVers
	EndIf
EndFunc