#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_x64=tmx2xml-transform.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
#include <Excel.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <GuiConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <AutoItConstants.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>
#include <WinAPIShellEx.au3>
#include <EditConstants.au3>
#Include <Date.au3>
#include <Inet.au3>
#include <FTPEx.au3>
#Include <Date.au3>

Local $hGUI = GUICreate("TMX2XML for TMX Search:Transform", 575, 200, -1, -1, -1, $WS_EX_ACCEPTFILES)
Local $msgfolder = "폴더를 선택하세요."
Global $sConfig = @ScriptDir & '\config.ini'

GUICtrlCreateLabel ("파트 선택", 20, 70)
Global $hCombo = GUICtrlCreateCombo("", 20, 90, 80, 20)
GUICtrlSetData($hCombo, 'EBT|TV|모비스|모비스(CCNC)|모비스(타사)|무선 Device|무선(타사)|무선 AC|무선 Warranty|무선 Feature|생활가전|현대자동차')

GUICtrlCreateLabel ("TMX 폴더 선택", 110, 70)
Local $Input1 = GUICtrlCreateInput(IniRead($sConfig, "Config", "tmxfolder", ""), 110, 90, 352, 20, -1)
GUICtrlSetState($Input1, $GUI_DROPACCEPTED)
GUICtrlSetTip($Input1, 'TMX 폴더를 드래그하세요.')

Local $btnTMX = GUICtrlCreateButton("폴더 선택", 472, 86, 81, 25)
Local $btnRun = GUICtrlCreateButton("실행", 472, 150, 81, 25)
;~ Local $ditatmx = GUICtrlCreateButton("DITA:TMX", 372, 150, 81, 25)

GUISetState(@SW_SHOW)

While 1
   Local $msg = GuiGetMsg()
   Switch $msg
      Case $GUI_EVENT_CLOSE
         IniWrite($sConfig, "Config", "tmxfolder", GUICtrlRead($Input1))
         GUIDelete()
         ExitLoop

      Case $GUI_EVENT_DROPPED
         If @GUI_DropId = $Input1 Then
            GUICtrlSetData($Input1, @GUI_DragFile)
            IniWrite($sConfig, "Config", "tmxfolder", GUICtrlRead($Input1))
         EndIf

      Case $btnTMX
         Local $tmxPath = FileSelectFolder("TMX 파일이 들어있는 폴더를 선택하세요.", IniRead($sConfig, "Config", "tmxfolder", @ScriptDir))
         GUICtrlSetData($Input1, $tmxPath)
         IniWrite($sConfig, "Config", "tmxfolder", GUICtrlRead($Input1))

      Case $btnRun
         Local $seletedPart = GUICtrlRead($hCombo)
         Local $tmxPath = GUICtrlRead($Input1)

         If $seletedPart = "" And $tmxPath = "" Then
            MsgBox($MB_SYSTEMMODAL, "", "파트 및 TMX 폴더를 선택하세요.")
         ElseIf $seletedPart = "" Then
            MsgBox($MB_SYSTEMMODAL, "", "파트를 선택하세요.")
         ElseIf $tmxPath = "" Then
            MsgBox($MB_SYSTEMMODAL, "", "TMX 폴더를 선택하세요.")
         Else
            If FileExists(@ScriptDir & "\temp") Then
               DirRemove(@ScriptDir & "\temp",  $DIR_REMOVE)
            EndIf
            If FileExists(@ScriptDir & "\json") Then
               DirRemove(@ScriptDir & "\json",  $DIR_REMOVE)
            EndIf
            DirCreate(@ScriptDir & "\temp")
            DirCreate(@ScriptDir & "\json")

            ;~ xlst 변환
            Local $hFile = FileOpen(@ScriptDir & "\log.txt", 1)
            Local $tmxarr = _FileListToArray($tmxPath, "*.tmx")
            Local $n, $sfilName

            GUISetState(@SW_DISABLE)
            ProgressOn("", "진행 중...", "Working...")

            For $n = 1 To UBound($tmxarr) - 1
               $sfilName = StringRegExpReplace($tmxarr[$n], ".tmx", "")
               ConsoleWrite($tmxarr[$n] & " : " & $sfilName & @CRLF)
               ProgressSet($n)
               RunWait(@ComSpec & ' /c' & '@set CLASSPATH= && @set CLASSPATH=' & @ScriptDir & '\lib\saxon-ee-10.0.jar;%CLASSPATH% && @java net.sf.saxon.Transform -o:' & @ScriptDir & '\temp\' & $sfilName & '.xml -s:"' & $tmxPath & '\' & $tmxarr[$n] & '" -xsl:' & @ScriptDir & '\xslt\0a-tmx2xml.xsl', $tmxPath, @SW_HIDE, $STDOUT_CHILD)

               _FileWriteLog($hFile, '@set CLASSPATH= && @set CLASSPATH=' & @ScriptDir & '\lib\saxon-ee-10.0.jar;%CLASSPATH% && @java net.sf.saxon.Transform -o:' & @ScriptDir & '\temp\' & $sfilName & '.xml -s:"' & $tmxPath & '\' & $tmxarr[$n] & '" -xsl:' & @ScriptDir & '\xslt\0a-tmx2xml.xsl')

               RunWait(@ComSpec & ' /c' & '@set CLASSPATH= && @set CLASSPATH=' & @ScriptDir & '\lib\saxon-ee-10.0.jar;%CLASSPATH% && @java net.sf.saxon.Transform -o:' & @ScriptDir & '\json\' & $sfilName & '.json -s:"' & @ScriptDir & '\temp\' & $sfilName & '.xml" -xsl:' & @ScriptDir & '\xslt\0b-xml2json.xsl', $tmxPath, @SW_HIDE, $STDOUT_CHILD)

               _FileWriteLog($hFile, '@set CLASSPATH= && @set CLASSPATH=' & @ScriptDir & '\lib\saxon-ee-10.0.jar;%CLASSPATH% && @java net.sf.saxon.Transform -o:' & @ScriptDir & '\json\' & $sfilName & '.json -s:"' & @ScriptDir & '\temp\' & $sfilName & '.xml" -xsl:' & @ScriptDir & '\xslt\0b-xml2json.xsl')
               Sleep(5)
            Next

            ;~ ;~ 파일명 변환
            Local $xmlarray = _FileListToArray(@ScriptDir & "\json", "*.json")
            Local $i, $fName
            Local $result = True
            For $i = 1 To UBound($xmlarray) - 1
               $fName = $xmlarray[$i]
               ConsoleWrite($fName)
               If StringInStr($fName, "Arabic_ar-SA") Or StringInStr($fName, "en-GB_ar-SA") Or StringInStr($fName, "ARA_ar-SA") Or StringInStr($fName, "(AC)_ar-SA") Or StringInStr($fName, "en-US_ar-SA") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' ARA.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ARA-AS") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' ARA-AS.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ARA-EU") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' ARA-EU.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "sq-AL") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' ALB.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "az-Latn-AZ") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' AZE.json', @ScriptDir, @SW_HIDE)
			   ElseIf StringInStr($fName, "hy-AM") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' Arm.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "bn-BD") Or StringInStr($fName, "bn-IN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' BEN.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "bg-BG") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' BUL.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "Mya_my-MM") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' BUR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "SamsungOne_my-MM") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' SamsungOne-BUR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "Zawgyi_my-MM") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' Zawgyi-BUR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "fr-CA") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' CA-FRE.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "_SC_zh-CN") Or StringInStr($fName, "(PRC)_zh-CN") Or StringInStr($fName, "en-US_zh-CN") Or StringInStr($fName, "S-CHI_zh-CN") Or StringInStr($fName, "(AC)_zh-CN") Or StringInStr($fName, "en-GB_zh-CN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' S-CHI.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "K2SC_zh-CN") Or StringInStr($fName, "ko-KR_zh-CN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' KOR2S-CHI.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "SC2ENG") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' SC2ENG.json', @ScriptDir, @SW_HIDE)
			   ElseIf StringInStr($fName, "K2E_zh-TW") Then
					RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' KOR2TPE.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "zh-SG") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' SG-CHI.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "zh-HK") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' HKG.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "zh-TW") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' TPE.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "hr-HR") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' CRO.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "cs-CZ") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' CZE.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "da-DK") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' DAN.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "nl-NL") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' DUT.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "et-EE") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' EST.json', @ScriptDir, @SW_HIDE)
               ElseIf  StringInStr($fName, "en-GB_ko-KR") Or StringInStr($fName, "en-GB2ko-KR") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' ENGB2KOR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "E2K_ko-KR") Or StringInStr($fName, "en-US_ko-KR") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' ENUS2KOR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "K2E_en-US") Or StringInStr($fName, "ko-KR_en-US") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' KOR2ENG-US.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ko-KR_en-GB") Or StringInStr($fName, "ko-KR2en-GB") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' KOR2ENG-GB.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "fa-IR") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' FAR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "fi-FI") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' FIN.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "fr-FR") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' FRE.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ka-GE") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' GEORGIAN.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "de-DE") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' GER.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "el-GR") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' GRE.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "he-IL") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' HEB.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "hi-IN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' HIN.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "hu-HU") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' HUN.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "id-ID") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' IND.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "it-IT") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' ITA.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ja-JP") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' JPN.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "kk-KZ") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' KAZ.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "Main_km-KH") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' Main-KHM.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "Vendor_km-KH") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' Vendor-KHM.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "lo-LA") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' LAO.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "es-AR") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' Ltn-SPA.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "lv-LV") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' LAT.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "lt-LT") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' LIT.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "mk-MK") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' MKD.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "mn-MN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' MON.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "nb-NO") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' NOR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "pl-PL") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' POL.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "pt-PT") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' POR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "pt-BR") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' B-POR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ro-RO") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' ROM.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ru-RU") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' RUS.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "sr-Latn-RS") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' SER.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "sk-SK") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' SLK.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "sl-SI") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' SLV.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "es-ES") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' SPA.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "es-MX") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' M-SPA.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "sv-SE") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' SWE.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "th-TH") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' THA.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "tr-TR") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' TUR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "uk-UA") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' UKR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ur-PK") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' URD.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "uz-Latn-UZ") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' UZB.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "vi-VN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' VIE.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ms-MY") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' MAL.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ga-IE") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' IRI.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "mt-MT") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' Malta.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "bs-Latn-BA") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' BOS.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ky-KG") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' KIR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "tg-Cyrl-TJ") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' RGK.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "tk-TM") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' TUK.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "sr-Latn-ME") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' CNR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "mr-IN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' MAR.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "te-IN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' TEL.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ta-IN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' TAM.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "gu-IN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' GUJ.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "kn-IN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' KAN.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "or-IN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' ODI.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "ml-IN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' MAY.json', @ScriptDir, @SW_HIDE)
               ElseIf StringInStr($fName, "pa-IN") Then
                  RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' PUN.json', @ScriptDir, @SW_HIDE)
			   ElseIf StringInStr($fName, "is-IS") Then
					RunWait(@ComSpec & ' /c' & 'rename ' & 'json\' & $fName & ' IRL.json', @ScriptDir, @SW_HIDE)
               Else
                  MsgBox(0, "Error", "올바른 파일명이 아닙니다. : " & $fName & @CRLF & "파일명을 수정한 다음 다시 진행하세요.")
                  $result = False
                  ExitLoop
               EndIf
            Next

            ProgressOff()

            If $result = False Then
               GUISetState(@SW_ENABLE)
            Else
               Local $j, $PartfN, $updateFn
               ;~ ftp 연결
               $server = "10.10.10.222"
               $userName = "tcs_ftp"
               $pass = "ast1413"

               $Open = _FTP_Open('MyFTP Control')
               $Conn = _FTP_Connect($Open, $server, $username, $pass)

               Local $xmlarray1 = _FileListToArray(@ScriptDir & "\json", "*.json")

               ;~ update txt 만들기
               $updateFn = FileOpen(@ScriptDir & "\json\update.txt", 2)

               ;~ 서버 폴더 경로 지정
               If $seletedPart = "EBT" Then
                  $PartfN = "EBT"
                  FileWriteLine($updateFn, $PartfN & " 업데이트: " & @YEAR & "-" & @MON & "-" & @MDAY & " " &@HOUR & ":" &@MIN)
               ElseIf $seletedPart = "TV" Then
                  $PartfN = "TV"
                  FileWriteLine($updateFn, $PartfN & " 업데이트: " & @YEAR & "-" & @MON & "-" & @MDAY & " " &@HOUR & ":" &@MIN)
               ElseIf $seletedPart = "모비스" Then
                  $PartfN = "MOBIS"
                  FileWriteLine($updateFn, $PartfN & " 업데이트: " & @YEAR & "-" & @MON & "-" & @MDAY & " " &@HOUR & ":" &@MIN)
               ElseIf $seletedPart = "모비스(CCNC)" Then
                  $PartfN = "MOBIS-CCNC"
                  FileWriteLine($updateFn, $PartfN & " 업데이트: " & @YEAR & "-" & @MON & "-" & @MDAY & " " &@HOUR & ":" &@MIN)
   			   ElseIf $seletedPart = "모비스(타사)" Then
				  $PartfN = "MOBIS-external"
				  FileWriteLine($updateFn, $PartfN & " 업데이트: " & @YEAR & "-" & @MON & "-" & @MDAY & " " &@HOUR & ":" &@MIN)
               ElseIf $seletedPart = "무선 Device" Then
                  $PartfN = "MA-Device"
				ElseIf $seletedPart = "무선(타사)" Then
					$PartfN = "MA-external"
                  FileWriteLine($updateFn, $PartfN & " 업데이트: " & @YEAR & "-" & @MON & "-" & @MDAY & " " &@HOUR & ":" &@MIN)
               ElseIf $seletedPart = "무선 AC" Then
                  $PartfN = "MA-AC"
                  FileWriteLine($updateFn, $PartfN & " 업데이트: " & @YEAR & "-" & @MON & "-" & @MDAY & " " &@HOUR & ":" &@MIN)
               ElseIf $seletedPart = "무선 Feature" Then
                  $PartfN = "MA-Feature"
                  FileWriteLine($updateFn, $PartfN & " 업데이트: " & @YEAR & "-" & @MON & "-" & @MDAY & " " &@HOUR & ":" &@MIN)
               ElseIf $seletedPart = "무선 Warranty" Then
                  $PartfN = "MA-Warranty"
                  FileWriteLine($updateFn, $PartfN & " 업데이트: " & @YEAR & "-" & @MON & "-" & @MDAY & " " &@HOUR & ":" &@MIN)
               ElseIf $seletedPart = "생활가전" Then
                  $PartfN = "HA"
                  FileWriteLine($updateFn, $PartfN & " 업데이트: " & @YEAR & "-" & @MON & "-" & @MDAY & " " &@HOUR & ":" &@MIN)
               ElseIf $seletedPart = "현대자동차" Then
                  $PartfN = "HY-Auto"
                  FileWriteLine($updateFn, $PartfN & " 업데이트: " & @YEAR & "-" & @MON & "-" & @MDAY & " " &@HOUR & ":" &@MIN)
               EndIf
               FileClose($updateFn)

               ProgressOn("", "FTP 업로드 중...", "업로드 중...")
               For $j = 1 To UBound($xmlarray1) - 1
                  ProgressSet($j)
                  ConsoleWrite(@ScriptDir & "\json\" & $xmlarray1[$j] & " : " &  "/tmx_2/json/" & $PartfN & "/" & $xmlarray1[$j] & @CRLF)
                  Local $upload = _FTP_FilePut($Conn, @ScriptDir & "\json\" & $xmlarray1[$j], "/tmx_2/json/" & $PartfN & "/" & $xmlarray1[$j])
                  If $upload = 0 Or $upload = @error Then
                     MsgBox(0, "Error", "FTP 업로드를 실패했습니다. 방화벽에서 앱 허용을 설정하거나 개발자에게 문의하시기 바랍니다.")
                     $result = False
                     ExitLoop
                  EndIf
                  Sleep(5)
               Next

               ;~ update txt 업로드
               If $result = True Then
                  _FTP_FilePut($Conn, @ScriptDir & "\json\update.txt", "/tmx_2/json/" & $PartfN & "/update.txt")
               EndIf

               $Ftpc = _FTP_Close($Open)
               Sleep(750)
               ProgressOff()
               GUISetState(@SW_ENABLE)
               MsgBox($MB_SYSTEMMODAL, "", "완료합니다.")
            EndIf
         ;~ 프로세스 종료 위치
         EndIf

    ;~   Case $ditatmx
    ;~      Global $aPos = WinGetPos($hGUI)
    ;~      Local $hFile = FileOpen(@ScriptDir & "\log.txt", 1)
    ;~      ;~ tmx 파일 경로 선택
    ;~      ;~ 변환 프로세스 실행
    ;~      Local $tmxPath = FileSelectFolder("TMX 파일(tmx)이 들어있는 폴더를 선택하세요.", @ScriptDir)
    ;~      If @error Then
	;~ 			MsgBox($MB_SYSTEMMODAL, "", @error)
	;~ 		ElseIf $tmxPath = "" Then
	;~ 			MsgBox($MB_SYSTEMMODAL, "", "폴더를 선택하지 않았습니다.")
	;~ 		Else
    ;~         GUISetState(@SW_DISABLE)
    ;~         ProgressOn("", "진행 중...", "Working...", $aPos[0] + 150, $aPos[1] + 60, $DLG_CENTERONTOP)

    ;~         Local $tmxarr = _FileListToArray($tmxPath, "*.tmx")
    ;~         Local $i

    ;~         For $i = 1 To UBound($tmxarr) - 1
    ;~            ProgressSet($i / UBound($tmxarr) * 100, $i / UBound($tmxarr) * 100 & " %")
    ;~            RunWait(@ComSpec & ' /c' & '@set CLASSPATH= && @set CLASSPATH=' & @ScriptDir & '\lib\saxon-ee-10.0.jar;%CLASSPATH% && @java net.sf.saxon.Transform -o:' & $tmxPath & '\temp\tm-migrated.tmx -s:' & $tmxPath & '\' & $tmxarr[$i] & ' -xsl:' & @ScriptDir & '\xslt\tm-migrate.xsl', $tmxPath, @SW_HIDE)
    ;~            _FileWriteLog($hFile, '@set CLASSPATH= && @set CLASSPATH=' & @ScriptDir & '\lib\saxon-ee-10.0.jar;%CLASSPATH% && @java net.sf.saxon.Transform -o:' & $tmxPath & '\temp\tm-migrated.tmx -s:' & $tmxPath & '\' & $tmxarr[$i] & ' -xsl:' & @ScriptDir & '\xslt\tm-migrate.xsl')
    ;~            RunWait(@ComSpec & ' /c' & '@set CLASSPATH= && @set CLASSPATH=' & @ScriptDir & '\lib\saxon-ee-10.0.jar;%CLASSPATH% && @java net.sf.saxon.Transform -o:' & $tmxPath & '\temp\tm-cleaned-i-type.tmx -s:' & $tmxPath & '\temp\tm-migrated.tmx -xsl:' & @ScriptDir & '\xslt\tm-clean-i-type.xsl', $tmxPath, @SW_HIDE)
    ;~            _FileWriteLog($hFile, '@set CLASSPATH= && @set CLASSPATH=' & @ScriptDir & '\lib\saxon-ee-10.0.jar;%CLASSPATH% && @java net.sf.saxon.Transform -o:' & $tmxPath & '\temp\tm-cleaned-i-type.tmx -s:' & $tmxPath & '\temp\tm-migrated.tmx -xsl:' & @ScriptDir & '\xslt\tm-clean-i-type.xsl')
    ;~            RunWait(@ComSpec & ' /c' & '@set CLASSPATH= && @set CLASSPATH=' & @ScriptDir & '\lib\saxon-ee-10.0.jar;%CLASSPATH% && @java net.sf.saxon.Transform -o:' & $tmxPath & '\DITA-tmx\' & $tmxarr[$i] & ' -s:' & $tmxPath & '\temp\tm-cleaned-i-type.tmx -xsl:' & @ScriptDir & '\xslt\tm-fix-ept-i.xsl', $tmxPath, @SW_HIDE)
    ;~            _FileWriteLog($hFile, '@set CLASSPATH= && @set CLASSPATH=' & @ScriptDir & '\lib\saxon-ee-10.0.jar;%CLASSPATH% && @java net.sf.saxon.Transform -o:' & $tmxPath & '\DITA-tmx\' & $tmxarr[$i] & ' -s:' & $tmxPath & '\temp\tm-cleaned-i-type.tmx -xsl:' & @ScriptDir & '\xslt\tm-fix-ept-i.xsl')
    ;~            Sleep(5)
    ;~         Next
    ;~         ProgressOff()
    ;~         GUISetState(@SW_ENABLE)
    ;~         DirRemove($tmxPath & '\temp', $DIR_REMOVE)
    ;~         MsgBox(0, "", "DITA:TMX 완료합니다.")
    ;~         Run("explorer.exe " & $tmxPath & '\DITA-tmx')
    ;~      EndIf

   EndSwitch
WEnd