;~ #include <Array.au3>
;~ #include <Constants.au3>
;~ #include <MsgBoxConstants.au3>
;~ #include <StringConstants.au3>
;~ #include <GUIConstants.au3>
;~ #include <GUIConstantsEx.au3>
;~ #include <WindowsConstants.au3>
;~ #include <AutoItConstants.au3>
;~ #include <File.au3>
;~ #include <Excel.au3>
;~ #include <ExcelConstants.au3>
;~ #include <String.au3>
;~ #include <StringConstants.au3>
;~ #include <EditConstants.au3>
;~ #include <FileConstants.au3>
;~ #include <WinAPIFiles.au3>
;~ #include <WinAPIShellEx.au3>

;~ Local $Pages = "3,3"
;~ Local $Pages = "1,24,27,42,42,47,53,61,62,74,77,79,79,83,84,85,86,87,87,88,109,123"
;~ ConsoleWrite(_duplicatePages($Pages, "143", "UM"))

Func _duplicatePages($Pages, $lastNum, $type)
	Local $Array = StringSplit($Pages, ",")
	Local $i, $result, $Count
	
	;~ ConsoleWrite("111 " & UBound($Array) & @CRLF)
	
	For $i = 1 To UBound($Array) - 1
		$result = _ArrayFindAll($Array, $Array[$i], 1)
		If UBound($result) > 1 Then
			$Pages = StringRegExpReplace($Pages, "((" & $Array[$i] & ")(,?)){" & UBound($result) & ",}", "$2(" & UBound($result) &"),")
			$i = UBound($result) + $i
		EndIf
	Next
	;~ ConsoleWrite("333 " & $Pages & @CRLF)
	
	$Pages = StringRegExpReplace($Pages, ",$", "")
	
	;~ If $type <> "QSG" Then
	;~ 	$Pages = StringRegExpReplace($Pages, "^1(,|\()", "앞표지$1")
	;~ 	$Pages = StringRegExpReplace($Pages, "," & $lastNum & "$", ",뒷표지")
	;~ EndIf
	Return $Pages
EndFunc