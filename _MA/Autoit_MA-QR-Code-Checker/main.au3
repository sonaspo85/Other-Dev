#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=qr.ico
#AutoIt3Wrapper_Outfile_x64=QRCodeURLValidator.exe
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Array.au3>
#include <Constants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <AutoItConstants.au3>
#include <Date.au3>
#include <File.au3>
#include <Excel.au3>
#include <ExcelConstants.au3>
#include <String.au3>
#include <StringConstants.au3>
#include <EditConstants.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>
#include <WinAPIShellEx.au3>
#include <Memory.au3>

Global $message = "파일을 선택하세요."

Global $Form1 = GUICreate("QR Code to URL Validator - ver 0.0.5", 500, 180, -1, -1, -1, $WS_EX_ACCEPTFILES)

Global $title = GUICtrlCreateLabel ("MA QSG - QR Code URL 검사기", 20, 18, 480)
GUICtrlSetFont(-1, 15, 600, 0)
Global $Label1 = GUICtrlCreateLabel ("PDF 파일 :", 20, 65)
Global $Input1 = GUICtrlCreateInput("", 100, 60, 280, 20, -1)
GUICtrlSetState($Input1, $GUI_DROPACCEPTED)
Global $btn_SelBook = GUICtrlCreateButton("파일선택", 390, 57, 81, 25)

Global $Label2 = GUICtrlCreateLabel ("호출 파일 :", 20, 95)
Global $Input2 = GUICtrlCreateInput("", 100, 90, 280, 20, -1)
GUICtrlSetState($Input2, $GUI_DROPACCEPTED)
Global $btn_SelXls = GUICtrlCreateButton("파일선택", 390, 87, 81, 25)

Global $checkQR = GUICtrlCreateButton("검사하기", 390, 127, 81, 25)

Global $sXmlFile = @ScriptDir & "\functions\languages.xml"
Global $oXMLObj = ObjCreate('Microsoft.XMLDOM')


MsgBox($MB_SYSTEMMODAL, "주의", "프로세스를 진행하기 전에 열려있는 엑셀 파일을 모두 닫으세요.")

If FileExists($sXmlFile) Then
	$oXMLObj.load($sXmlFile)
Else
	MsgBox($MB_SYSTEMMODAL, "", "functions 폴더에 언어 코드 XML 파일이 없습니다.")
EndIf
Global $break

GUISetState()

While 1
	Global $msg = GuiGetMsg()
	Switch $msg
		Case $GUI_EVENT_CLOSE
			GUIDelete()
			ExitLoop

		Case $btn_SelBook
			$iPdf = FileOpenDialog($message, @ScriptDir, "Acrobat PDF File (*.pdf)", 1)
			If @error Then
				;~ Nothing
			Else
				GUICtrlSetData($Input1, $iPdf)
			EndIf

		Case $btn_SelXls
			$iXls = FileOpenDialog($message, @ScriptDir, "Excel File (*.xlsx)", 1)
			If @error Then
				;~ Nothing
			Else
				GUICtrlSetData($Input2, $iXls)
			EndIf

		Case $checkQR
			Local $captures = @ScriptDir & "\capture"

			FileDelete($captures & "\*.png")
			If FileExists(@ScriptDir & "\functions\models.txt") Then
				FileDelete(@ScriptDir & "\functions\models.txt")
			EndIf
			If FileExists(@ScriptDir & "\functions\urls.txt") Then
				FileDelete(@ScriptDir & "\functions\urls.txt")
			EndIf
			If FileExists(@ScriptDir & "\functions\qrcodes.json") Then
				FileDelete(@ScriptDir & "\functions\qrcodes.json")
			EndIf

			Local $pdfPath = GUICtrlRead($Input1)
			Local $xslPath = GUICtrlRead($Input2)
			Local $pdfName = StringMid($pdfPath, StringInStr($pdfPath, '\', 0, -1) + 1)
			
			If Not FileExists($pdfPath) Then
				MsgBox(0, "Error", "PDF 파일이 없습니다.")
				ContinueCase
			EndIf

			If Not FileExists($xslPath) Then
				MsgBox(0, "Error", "엑셀 파일이 없습니다.")
				ContinueCase
			EndIf

			GUISetState(@SW_DISABLE)

			ProgressOn("QR Code to URL Validator", "QR Code to URL Validator를 실행합니다.", "", -1, -1, BitOr($DLG_CENTERONTOP, $DLG_MOVEABLE))

			If FileExists(@ScriptDir & "\temp") Then
				DirRemove(@ScriptDir & "\temp")
			EndIf
			DirCreate(@ScriptDir & "\temp")
			FileCopy($pdfPath, @ScriptDir & "\temp", 1)
			
			Local $tempPdf = @ScriptDir & "\temp\" & $pdfName
			ConsoleWrite($tempPdf & @CRLF)

			;~ RunWait(@ComSpec & ' /c' & 'node ./functions/deCodeQR.js "' & $tempPdf & '"', @ScriptDir, @SW_HIDE)
			RunWait(@ComSpec & ' /c ' & '.\bin\BarcodeReaderCLI.exe -type=qr -output="' & @ScriptDir & '\functions\qrcodes.json" ' & '"' & $tempPdf & '"', @ScriptDir, @SW_HIDE)
			ConsoleWrite('.\bin\BarcodeReaderCLI.exe -type=qr -output="' & @ScriptDir & '\functions\qrcodes.json" ' & '"' & $tempPdf & '"' & @CRLF)
			;~ ProcessWaitClose($barcode)

			Local $qrPath = @ScriptDir & "\functions\qrcodes.json"

			If Not FileExists($qrPath) Then
				ProgressOff()
				MsgBox(0, "Error", $qrPath & " 파일이 없습니다.")
				GUISetState(@SW_ENABLE)
				ContinueCase
			EndIf

			Local $qrcode = FileRead(@ScriptDir & "\functions\qrcodes.json")
			Local $bc_count = StringRegExp($qrcode, 'barcodes', 1)
			;~ ConsoleWrite('Barcodes : ' & UBound($bc_count) & @CRLF)

			If UBound($bc_count) > 1 Then
				ProgressOff()
				MsgBox(0, "Error", "PDF 파일에 QR 코드가 하나 이상 존재합니다.")
				GUISetState(@SW_ENABLE)
				ContinueCase
			EndIf

			Local $i, $result = True
			Local $chkClose = True

			If IsObj(ObjGet("", "Excel.Application")) Then
				Local $oExcel = ObjCreate("Excel.Application")
				$chkClose = False
			Else
				;~ Local $oExcel = _Excel_Open(True, False, False)
				Local $oExcel = ObjCreate("Excel.Application")
				$oExcel.Application.Visible = False
				$oExcel.Application.DisplayAlerts = False
				$oExcel.Application.ScreenUpdating = False
			EndIf

			Local $wkBook = _Excel_BookOpen($oExcel, $xslPath, False, True)
			Local $wkBook = $oExcel.Workbooks.Open($xslPath, Default, False, Default, Default, Default)
			;~ Local $wkSht = $wkBook.Sheets($wkBook.Sheets.Count) ;~ 호출 시트
			Local $wkSht = $wkBook.ActiveSheet

			;~ 언어 갯수를 계산한다.
			Local $lastCols = $wkSht.Cells(4, 2).End(-4161).Column
			ConsoleWrite($lastCols)
			Local $Count = $lastCols - 2
			Local $Language
			For $i = 3 To $lastCols
				If $wkSht.Cells(4, $i).Value = "" Then
					ExitLoop
				EndIf
				$Language = $wkSht.Cells(4, $i).Value
				;~ If StringInStr($Language, "English") Then
				;~ 	$Language = "English"
				;~ EndIf

				$prog = (($i - 2) / $Count) * 100
				ProgressSet($prog, $Language, "진행률 " & ($i - 2) & "/" & $Count)

				Local $lang = _getLangCode($oXMLObj, $Language)
				
				If $lang = "" Or $lang = "0" Then
					$result = False
					ProgressOff()
					MsgBox(0, "Error", $Language & " 언어명이 잘못되었습니다.")
					_ForceCloseBook($chkClose, $oExcel, $wkBook)
					GUISetState(@SW_ENABLE)
					ExitLoop
				EndIf
				RunWait(@ComSpec & ' /c' & 'node ./functions/request-url.js "' & $lang & '" "' & $Language & '"', @ScriptDir, @SW_HIDE)

				Local $url = FileReadLine(@ScriptDir & '\functions\urls.txt', 1)

				If Not FileExists($captures & "\" & $lang & ".png") Then
					$result = False
					ProgressOff()
					MsgBox(0, "Error", $lang & " 언어를 처리하던 중 오류가 발생했습니다." & @CRLF & "로그 파일을 확인하세요.")
					_ForceCloseBook($chkClose, $oExcel, $wkBook)
					GUISetState(@SW_ENABLE)
					ExitLoop
				EndIf

				Local $capimg = $captures & "\" & $lang & ".png"
				;~ _Excel_PictureAdd($wkBook, $wkSht, $capimg, $wkSht.Cells(6, $i), Default, 180.2667, Default, True) ;240.75
				Local $addPic = $wkSht.Shapes.AddPicture($capimg, 0, 1, $wkSht.Cells(6, $i).Left, $wkSht.Cells(6, $i).Top, 180.2667, 377.6801)
				With $addPic.Line
					.Weight = 1
					.ForeColor.ColorIndex = 1
				EndWith

				If $Language = "English (CHN)" Or  $Language = "Simplified Chinese (PRC)" Or  $Language = "English (HK)" Or $Language = "HongKong China" Or $Language = "English (TC)" Or $Language = "Taiwan" Then
					Local $addCapimg = $captures & "\" & $Language & ".png"
					Local $addLpic =  $wkSht.Shapes.AddPicture($addCapimg, 0, 1, $wkSht.Cells(7, $i).Left, $wkSht.Cells(7, $i).Top, 180.2667, 377.6801)
					With $addLpic.Line
						.Weight = 1
						.ForeColor.ColorIndex = 1
					EndWith
				EndIf
			Next

			ProgressSet(100, "리포트 작성 중", "Complete")

			If $result = False Then
				ContinueCase
				ProgressOff()
				GUISetState(@SW_ENABLE)
			EndIf

			;~ $wkBook.Close(True)
			$wkBook.Save()
			$oExcel.Application.Visible = True
			$oExcel.Application.ScreenUpdating = True
			$oExcel.Application.DisplayAlerts = True
			;~ $oExcel.Quit()
			$oExcel = ""
			;~ _Excel_Close($oExcel, False, True)

			;~ If $chkClose = False Then
			;~ 	;~ 엑셀을 닫을 필요 없음
			;~ 	;~ $wkBook = _Excel_BookOpen($oExcel, $xslPath)
			;~ 	;~ $wkBook.Save()
			;~ 	$wkBook = $oExcel.Workbooks.Open($xslPath, Default, False, Default, Default, Default)
			;~ 	$wkBook.Save()
			;~ Else
			;~ 	;~ _Excel_Close($oExcel, False, True)
			;~ 	;~ $oExcel.Application.Quit
			;~ 	;~ $oExcel = _Excel_Open(True, False, True)
			;~ 	;~ $oExcel.Visible = True
			;~ 	;~ $oExcel.ScreenUpdating = True
			;~ 	;~ $wkBook = _Excel_BookOpen($oExcel, $xslPath)
			;~ 	;~ $wkBook.Save()
				
			;~ EndIf
			DirRemove(@ScriptDir & "\temp", 1)
			ProgressOff()
			MsgBox(0, "QR Code to URL Validator", "모든 과정을 완료합니다.")
			GUISetState(@SW_ENABLE)
			
		Case $break
	EndSwitch
WEnd

Func _ForceCloseBook($chk, $oExcel, $wkBook)
	If $chk = False Then
		;~ 엑셀이 열려있는 경우 북 파일만 닫을 것
		$oExcel.Application.Visible = True
		$oExcel.Application.ScreenUpdating = True
		$wkBook.Close(False)
		;~ _Excel_Close($oExcel, False, True)
		;~ $oExcel.Application.Quit
	Else
		;~ 엑셀이 이미 닫혀있는 경우 엑셀 오브젝트까지 종료
		$oExcel.Application.Visible = True
		$oExcel.Application.ScreenUpdating = True
		$wkBook.Close(False)
		$oExcel.Quit
		;~ _Excel_Close($oExcel, False, True)
	EndIf
EndFunc

Func _getLangName($oXMLObj, $langCode)
	Local $vXMLNodeLists = $oXMLObj.selectNodes('//language')
	Local $i

	For $i in $vXMLNodeLists
		If $i.getAttribute("code") = $langCode Then
			Return $i.getAttribute("name")
		EndIf
	Next
EndFunc

Func _getLangCode($oXMLObj, $language)
	Local $vXMLNodeLists = $oXMLObj.selectNodes('//language')
	Local $i

	For $i in $vXMLNodeLists
		If $i.getAttribute("name") = $language Then
			Return $i.getAttribute("code")
		EndIf
	Next
EndFunc