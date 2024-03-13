#include <File.au3>
#include <Array.au3>
#include <Excel.au3>
#include <ExcelConstants.au3>
#include <FileConstants.au3>
#include <String.au3>
#include <StringConstants.au3>

Global $ParentDir = StringLeft(@scriptDir, StringInStr(@scriptDir,"\",0,-1)-1)
Global $db = $ParentDir & "\resource\DB.xlsx"

Local $sExcel = _Excel_Open(False, False, False)
Local $dbBook = _Excel_BookOpen($sExcel, $db, True, False)
Local $dbSht = $dbBook.Sheets(1)

Local $lRow = $dbSht.Cells(1, 1).End(-4121).Row
ConsoleWrite($lRow & @CRLF)
Local $i, $stamp, $sName, $basic, $multiLng, $html
Local $dbPath = $ParentDir & "\resource\db.xml"

If FileExists($dbPath) Then
	FileDelete($dbPath)
EndIf

_FileCreate($dbPath)
Local $dbXML = FileOpen($dbPath, $FO_APPEND)

FileWriteLine($dbXML, '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
FileWriteLine($dbXML, '<root>')

With $dbSht
	For $i = 2 To $lRow
		$stamp = .Cells($i, 1).Value
		$sName = .Cells($i, 2).Value
		$basic = .Cells($i, 3).Value
		$multiLng = .Cells($i, 4).Value
		$html = .Cells($i, 5).Value
		$pages = .Cells($i, 6).Value
		FileWriteLine($dbXML, @TAB & '<stamp name="' & $stamp &'" hName="' & $sName & '" basic="' & $basic & '" multi="' & $multiLng & '" html="' & $html & '" pages="' & $pages &'"/>')
		ConsoleWrite('<stamp name="' & $stamp &'" hName="' & $sName & '" basic="' & $basic & '" multi="' & $multiLng & '" html="' & $html & '" pages="' & $pages &'"/>' & @CRLF)
	Next
EndWith
FileWriteLine($dbXML, '</root>')
FileClose($dbXML)
_Excel_BookClose($dbBook, False)
_Excel_Close($sExcel, False)