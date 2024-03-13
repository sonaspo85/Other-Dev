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
#include <math.au3>
#include <Inet.au3>
#include "_eXtractSpec2.au3" ;~ spec 엑셀 파일에서 xml을 추출하는 모듈
#include "_idmlMerge2.au3" ;~ 인디자인 IDML 파일에서 xml을 추출하고 Merge하는 모듈
#include "_checkSpec.au3" ;~ 단말기 QSG의 스펙을 검사하는 모듈
#include "_checkSpecAcc.au3" ;~ 액세서리 QSG의 스펙을 검사하는 모듈
;~ #include "_URI.au3"
;~ 프로젝트와 관련한 워크플랜 주소 : https://wp2.astkorea.net/task/doc/#view/2021022507124407c33 하위에 업무 내용 참조

Global $sConfig = @ScriptDir & '\config.ini' ;~ UI에 입력한 경로를 저장
Global $idmlPath = IniRead($sConfig, "Path", "idmlzip", "") ; ini 파일에 설정된 idml zip 파일 경로
Global $path1 = StringReplace($idmlPath, StringMid($idmlPath,StringInStr($idmlPath,'\',0,-1)+1), "")
Global $excelPath = IniRead($sConfig, "Path", "excel", "") ; ini 파일에 설정된 스펙 excel 파일 경로
Global $path2 = StringReplace($excelPath, StringMid($excelPath,StringInStr($excelPath,'\',0,-1)+1), "")
;~ Global $codePath = IniRead($sConfig, "Path", "code", "") ; ini 파일에 설정된 User ID
;~ Global $path3 = StringReplace($codePath, StringMid($codePath,StringInStr($codePath,'\',0,-1)+1), "")

;~ 버전 검사 =========================================================================================
;~ 새로운 버전 개발 시 아래의 $ver 값을 수정, 컴파일 후에는 아래 guest 서버에 파일 내용을 수정할 것
;~ 현업팀의 요청으로 버전을 올리도록 함, 반드시 MA팀장과 협의 후 진행할 것
Global $ver = "4.5.2"
;~ ConsoleWrite("ver ---" & _INetGetSource('https://guest.astkorea.net/TCS/specChecker-ver.html'))
;~ guest 서버
;~ 10.10.11.9
;~ ID: ha
;~ PW: ast141#
;~ /TCS/specChecker-ver.html
Local $ckVer = _INetGetSource('https://guest.astkorea.net/TCS/specChecker-ver.html')

If $ver <> $ckVer Then ;~ 버전 값이 서로 다를 경우 메시지 출력
	MsgBox(0, "Error", "프로그램이 정식 배포된 버전과 다릅니다." & @CRLF & "현재 버전: " & $Ver & @CRLF & "정식 버전: " & $ckVer, 3)
EndIf
;~ ===================================================================================================

;~ UI 모듈 ===========================================================================================
Global $message = "Select file"
Global $Form1 = GUICreate("Spec Checker for QSG ver " & $ver, 500, 200, -1, -1, -1, $WS_EX_ACCEPTFILES)
Global $Label1 = GUICtrlCreateLabel ("Indesign", 20, 45)
Global $Input1 = GUICtrlCreateInput(IniRead($sConfig, "Path", "idmlzip", ""), 80, 40, 300, 20, -1) ;~ IDML 압축 파일
GUICtrlSetState($Input1, $GUI_DROPACCEPTED)
Global $Button1 = GUICtrlCreateButton("Choose File", 390, 36, 81, 25)

Global $Label2 = GUICtrlCreateLabel ("Spec", 20, 85)
Global $Input2 = GUICtrlCreateInput(IniRead($sConfig, "Path", "excel", ""), 80, 80, 300, 20, -1) ;~ 엑셀 파일
GUICtrlSetState($Input2, $GUI_DROPACCEPTED)
Global $Button2 = GUICtrlCreateButton("Choose File", 390, 76, 81, 25)

Global $Button3 = GUICtrlCreateButton("Run", 390, 160, 81, 25)
Global $Button4 = GUICtrlCreateButton("다국어 DB 열기", 285, 160, 96, 25)
;~ ===================================================================================================

GUISetState() ;~ UI 활성화

;~ UI 각 버튼의 function 설정 =========================================================================
While 1
	Global $msg = GuiGetMsg()

	Switch $msg
		Case $GUI_EVENT_CLOSE
			;~ UI를 종료하면 config 값을 남기고 종료
			IniWrite($sConfig, "Path", "idmlzip", GUICtrlRead($Input1))
			IniWrite($sConfig, "Path", "excel", GUICtrlRead($Input2))
			GUIDelete()
			ExitLoop

		Case $GUI_EVENT_DROPPED
			;~ 드래그앤드랍 이벤트
			If @GUI_DropId = $Input1 Then
				GUICtrlSetData($Input1, @GUI_DragFile)
				IniWrite($sConfig, "Path", "idmlzip", GUICtrlRead($Input1))
			ElseIf @GUI_DropId = $Input2 Then
				GUICtrlSetData($Input2, @GUI_DragFile)
				IniWrite($sConfig, "Path", "excel", GUICtrlRead($Input2))
			EndIf

		Case $Button4 ;~ 다국어 DB 파일 단순 열기 기능
			Local $rsDB = @ScriptDir & "\resource\spec2xml-data.xlsm"
			If Not FileExists($rsDB) Then
				MsgBox(0, "Error", $rsDB & " 파일이 없습니다.")
			Else
				Local $oExcel = _Excel_Open(True, True, True)
				Local $oWorkbook = _Excel_BookOpen($oExcel, $rsDB, False, True, Default, Default, Default)
			EndIf
			$oExcel = "" ;~ 엑셀 메모리 비활성화

		Case $Button1 ;~ 인디자인 파일 선택 기능
			$idmlzip = FileOpenDialog($message, $path1, "Indesign Files (*.zip)", 1 )
			$idmlzipPath = StringRegExpReplace($idmlzip, "([^\\]+)\.(zip)", "")
			ConsoleWrite($idmlzip & @CRLF & $idmlzipPath & @CRLF)
			If @error Then
				MsgBox($MB_SYSTEMMODAL, "", "No file were selected")
			Else
				GUICtrlSetData($Input1, $idmlzip)
			EndIf
			IniWrite($sConfig, "Path", "idmlzip", GUICtrlRead($Input1)) ;~ config 값 저장

		Case $Button2 ;~ spec 엑셀 파일 선택 기능
			$var = FileOpenDialog($message, $path2, "EXCEL Files (*.xlsx)", 1 )
			$path = StringRegExpReplace($var, "([^\\]+)\.(xlsx)", "")
			ConsoleWrite($var & @CRLF & $path & @CRLF)
			If @error Then
				MsgBox($MB_SYSTEMMODAL, "", "No file were selected")
			Else
				GUICtrlSetData($Input2, $var)
			EndIf
			IniWrite($sConfig, "Path", "excel", GUICtrlRead($Input2))

		Case $Button3 ;~ compare 프로세스 실행 기능
			Global $aPos = WinGetPos($Form1) ;~ UI의 현재 위치에 따라 메시지 출력 위치를 설정하기 위함
			Local $idmlFile = GUICtrlRead($Input1)
			Local $specFile = GUICtrlRead($Input2)
			Local $output = @ScriptDir & "\output\outputHTML.html"
			local $manualN = StringRegExpReplace(StringMid($idmlFile,StringInStr($idmlFile,'\',0,-1)+1), ".zip", "")

			;~ 선택한 파일들이 경로에 없을 경우 ======================================================================
			If Not FileExists($idmlFile) And Not FileExists($specFile) Then
				MsgBox($MB_SYSTEMMODAL, "", "선택한 파일이 경로에 없습니다.")
				ContinueLoop ;~ 프로세스를 중지하는 기능
			ElseIf Not (StringInStr($idmlFile, ".zip")) Then
				MsgBox($MB_SYSTEMMODAL, "", "Indesign 파일 항목에 잘못된 파일이 선택했습니다.")
				ContinueLoop
			ElseIf Not (StringInStr($specFile, ".xlsx")) Then
				MsgBox($MB_SYSTEMMODAL, "", "스펙 Excle 파일 항목에 잘못된 파일이 선택했습니다.")
				ContinueLoop
			;~ =======================================================================================================
			Else
				;~ 진행 중 알림 창이 뜨고 메인 UI는 비활성화 ==========================================================
				SplashTextOn("", "Running Process ...", 200, 50, $aPos[0] + 150, $aPos[1] + 60, $DLG_CENTERONTOP , "")
				GUISetState(@SW_DISABLE)
				;~ ----------------------------------------------------------------------------------------------------
				
				;~ 프로세스 진행시 temp 폴더 내 파일을 삭제하고 진행한다. 윈도우에 따라 적용되지 않는 경우가 있어 3가지 방법 시도
				If FileExists(@ScriptDir & "\temp") Then
					FileDelete(@ScriptDir & "\temp\*.*")
					DirRemove(@ScriptDir & "\temp", 1)
					RunWait(@ComSpec & ' /c' & 'rm -r ' & @ScriptDir & "\temp", @ScriptDir, @SW_HIDE)
				EndIf
				;~ ====================================================================================================
				;~ temp 폴더 재생성, 인디자인의 압축을 풀고 xslt 및 프로세스 로직을 실행하기 위함 =======================
				DirCreate(@ScriptDir & "\temp")
				;~ ====================================================================================================
				
				;~ Validation.xml 파일 삭제, 새로운 validation 파일을 만들고 시작
				If FileExists(@ScriptDir & "\xsls\Validation.xml") Then
					FileDelete(@ScriptDir & "\xsls\Validation.xml")
				EndIf
				
				Local $specResult = _eXtractSpec($specFile) ;~ validator.xml 추출 모듈
				;~ _eXtractSpec 함수가 실패한 경우 메시지 출력, 프로세스 중지 ==========================================
				If $specResult = -1 Then
					SplashOff()
					MsgBox(0, "Error", "Spec 엑셀 파일의 시트 구성이 올바르지 않습니다. 다시 확인하세요.")
					GUISetState(@SW_ENABLE) ;~ 비활성화된 메인 UI를 활성화한다.
					ContinueLoop
				ElseIf $specResult = -2 Then
					SplashOff()
					MsgBox(0, "Error", "Spec 엑셀 파일이 경로에 없습니다. 경로를 다시 확인하세요.")
					GUISetState(@SW_ENABLE)
					ContinueLoop
				EndIf
				;~ ====================================================================================================

				;~ idmlMerge 진행, 스펙 xml 추출하기 ==================================================================
				Local $reSult01 = _idmlMergeGroup($idmlFile) ;~ _idmlMerge2.au3

				If $reSult01 = 1 Then
					SplashOff()
					MsgBox(0, "Error", "인디자인 파일이 올바르게 변환되지 않았습니다. 파일명의 언어 표기 또는 인디자인 문서 본문에 오류가 없는지 확인하세요.")
					GUISetState(@SW_ENABLE)
					ContinueLoop
				ElseIf $reSult01 = 2 Then
					SplashOff()
					MsgBox(0, "Error", $idmlFile & " 파일이 복사되지 않았습니다. 다시 확인하세요.")
					GUISetState(@SW_ENABLE)
					ContinueLoop
				ElseIf $reSult01 = 3 Then
					SplashOff()
					MsgBox(0, "Error", "IDML 파일이 없습니다. 압축 파일을 확인하세요.")
					GUISetState(@SW_ENABLE)
					ContinueLoop
				EndIf
				;~ ====================================================================================================

				;~ 검증 로직 실행 =====================================================================================
				Local $result02
				ConsoleWrite($specResult & @CRLF) ;~ 제품 유형을 반환받아 검증 로직을 분기한다.
				;~ 제품 유형에 따라 검증 로직을 변경해야할 경우 현업 담
				If $specResult = "Mobile phone" Or $specResult = "Tablet" Then
					;~ 모바일 폰, 태블렛 - 단말기 스펙 검증 : _checkSpec.au3 파일
					$result02 = checkSpec($manualN, $reSult01, $ver)
					ConsoleWrite($result02)
				ElseIf $specResult = "Watch" Or $specResult = "Hearable" Then
					;~ 워치, 버즈 액세서리 스펙 검증 : _checkSpecAcc.au3 파일
					ConsoleWrite($result02)
					$result02 = _CheckSpecAcc($manualN, $reSult01, $specResult, $ver)
				Else
					ConsoleWrite($specResult & @CRLF)
					$result02 = "WrongType"
				EndIf
				;~ ====================================================================================================

				;~ 검증 로직 성공 또는 실패할 경우 처리 ================================================================
				If $result02 = "NoneMerge" Then
					SplashOff()
					MsgBox(0, "Error", "Merged XML 파일이 없습니다.")
					GUISetState(@SW_ENABLE)
					ContinueLoop
				ElseIf $result02 = "WrongCode" Then
					SplashOff()
					MsgBox(0, "Error", "자재 코드 파일을 선택하지 않았거나 설정된 경로에 파일이 없습니다.")
					GUISetState(@SW_ENABLE)
					ContinueLoop
				ElseIf $result02 = "WrongLang" Then
					SplashOff()
					MsgBox(0, "Error", "올바르지 않은 언어가 포함되어 있습니다. 로그 파일을 확인하세요.")
					GUISetState(@SW_ENABLE)
					ContinueLoop
				ElseIf $result02 = "WrongType" Then
					SplashOff()
					MsgBox(0, "Error", "스펙 엑셀 파일의 제품 유형을 잘못 선택했거나 아직 검증을 진행할 수 없는 제품군입니다.")
					GUISetState(@SW_ENABLE)
					ContinueLoop
				ElseIf $result02 = "Fail SAR" Then
					GUISetState(@SW_ENABLE)
					ContinueLoop
				ElseIf $result02 = "complete" Then
					;~ 검증 로직 성공한 경우
					;~ 사업부 요청으로 프로세스 완료 후 temp 폴더 삭제,
					;~ temp 파일을 확인하려면 아래 두 줄을 주석 처리한 후 진행할 것
					FileDelete(@ScriptDir & "\temp\*.*")
					DirRemove(@ScriptDir & "\temp", 1)
					RunWait(@ComSpec & ' /c' & 'rm -r ' & @ScriptDir & "\temp", @ScriptDir, @SW_HIDE)
					SplashOff()
					MsgBox(0, "", "완료합니다.")
					GUISetState(@SW_ENABLE)
				EndIf
				;~ ====================================================================================================
			EndIf
	EndSwitch
WEnd