;~ #include <Array.au3>
;~ #include <Date.au3>
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

;~ ;~ Local $mfD = FileSelectFolder("청구 근거 폴더를 선택하세요.", IniRead($sConfig, "Config", "last_path", @ScriptDir))
;~ Local $mfD = "d:\TCS\_develop\146_MA-Estimate-manage\stat"
;~ Local $efArr = _FileListToArray($mfD, "*.xlsm", 1, True)
;~ Local $statics = @ScriptDir & "\template\statistics-template.xlsx"
;~ ;~ Local $hLog = @ScriptDir & "\log.txt"
;~ Local $oExcel = _Excel_Open(False, False, False)
;~ Local $wkBook = _Excel_BookOpen($oExcel, $statics)

;~ Local $stSht = $wkBook.Sheets(1)
;~ ;~ 시트 시작 인덱스 8
;~ Local $n, $i, $sType, $sBook, $jastSht
;~ Local $fileCount = UBound($efArr) - 1
;~ ProgressOn("청구서 항목별 통계", "청구서 항목별 통계 취합 중...", "", -1, -1, BitOr($DLG_CENTERONTOP, $DLG_MOVEABLE))
;~ For $n = 1 To UBound($efArr) - 1
;~ 	$progress = ($n / $fileCount) * 100
;~ 	ProgressSet($progress, "",  "진행률 " & $n & "/" & $fileCount)
	
;~ 	$sBook = _Excel_BookOpen($oExcel, $efArr[$n])
;~ 	$jastSht = $sBook.Sheets.Count
;~ 	_mergedStat($sBook, $jastSht)
;~ 	_Excel_BookClose($sBook, False)
;~ Next

;~ Local $trBook = $mfD & "\" & StringRegExpReplace(_NowDate(), "\-", "") & "_청구서항목별통계.xlsx"
;~ _Excel_BookSaveAs($wkBook, $trBook, $xlWorkbookDefault, True)
;~ _Excel_Close($oExcel, True)
;~ $oExcel = "" ; 엑셀 메모리 초기화
;~ ProgressOff()

Func _mergedStat($sBook, $stSht, $jastSht)
	For $i = 8 To $jastSht
		$sType = $sBook.Sheets($i).Cells(2, 5).Value
		$jang = $sBook.Sheets($i).Cells(3, 5).Value
		Local $j, $j, $pages, $bVal, $bPrice, $Pagesum, $Pageprice
		;~ ConsoleWrite($sBook.Sheets($i).Name & " : " & $sType & " : " & $jang & @CRLF)
		;~ FileWriteLine($hLog, $sBook.Sheets($i).Name & " : " & $sType & " : " & $jang)

		If $sType = "HTML" Then
			For $j = 7 To 12
				$pages = Number($sBook.Sheets($i).Cells($j, 8).Value)
				$price = Number($sBook.Sheets($i).Cells($j, 9).Value)
				$bVal = _beforeValue($stSht, ($j + 34), 3)
				$bPrice = _beforeValue($stSht, ($j + 34), 4)
				$Pagesum = $bVal + $pages
				$Pageprice = $bPrice + $price
				$stSht.Cells($j + 34, 3).Value = $Pagesum
				$stSht.Cells($j + 34, 4).Value = $Pageprice
				;~ FileWriteLine($hLog, @TAB & ($j + 34) & "--" & StringRegExpReplace($sBook.Sheets($i).Cells($j, 3).Value, @LF, " ") & ":" & $pages)
			Next
		Else
			If StringInStr($jang, "Korean") Or StringInStr($jang, "English") Then
				For $j = 7 To 19
					$pages = Number($sBook.Sheets($i).Cells($j, 8).Value)
					$price = Number($sBook.Sheets($i).Cells($j, 9).Value)
					$bVal = _beforeValue($stSht, ($j - 3), 3)
					$bPrice = _beforeValue($stSht, ($j - 3), 4)
					$Pagesum = $bVal + $pages
					$Pageprice = $bPrice + $price
					$stSht.Cells($j - 3, 3).Value = $Pagesum
					$stSht.Cells($j - 3, 4).Value = $Pageprice
					;~ FileWriteLine($hLog, @TAB & ($j - 3) & "--" & StringRegExpReplace($sBook.Sheets($i).Cells($j, 3).Value, @LF, " ") & ":" & $pages)
				Next

				For $j = 23 To 35
					$pages = Number($sBook.Sheets($i).Cells($j, 8).Value)
					$price = Number($sBook.Sheets($i).Cells($j, 9).Value)
					$bVal = _beforeValue($stSht, ($j + 5), 3)
					$bPrice = _beforeValue($stSht, ($j + 5), 4)
					$Pagesum =  $bVal + $pages
					$Pageprice = $bPrice + $price
					$stSht.Cells($j + 5, 3).Value = $Pagesum
					$stSht.Cells($j + 5, 4).Value = $Pageprice
					;~ FileWriteLine($hLog, @TAB & ($j + 5) & "--" & StringRegExpReplace($sBook.Sheets($i).Cells($j, 3).Value, @LF, " ") & ":" & $pages)
				Next
			Else
				For $j = 7 To 17
					$pages = Number($sBook.Sheets($i).Cells($j, 8).Value)
					$price = Number($sBook.Sheets($i).Cells($j, 9).Value)
					$bVal = _beforeValue($stSht, ($j + 10), 3)
					$bPrice = _beforeValue($stSht, ($j + 10), 4)
					$Pagesum = $bVal + $pages
					$Pageprice = $bPrice + $price
					$stSht.Cells($j + 10, 3).Value = $Pagesum
					$stSht.Cells($j + 10, 4).Value = $Pageprice
					;~ FileWriteLine($hLog, @TAB & ($j + 10) & "--" & StringRegExpReplace($sBook.Sheets($i).Cells($j, 3).Value, @LF, " ") & ":" & $pages)
				Next

				For $j = 28 To 39
					$pages = Number($sBook.Sheets($i).Cells($j, 8).Value)
					$price = Number($sBook.Sheets($i).Cells($j, 9).Value)
					$bVal = _beforeValue($stSht, $j, 3)
					$bPrice = _beforeValue($stSht, $j, 4)
					$Pagesum = $bVal + $pages
					$Pageprice = $bPrice + $price
					$stSht.Cells($j, 3).Value = $Pagesum
					$stSht.Cells($j, 4).Value = $Pageprice
					;~ FileWriteLine($hLog, @TAB & $j & "--" & StringRegExpReplace($sBook.Sheets($i).Cells($j, 3).Value, @LF, " ") & ":" & $pages)
				Next
			EndIf
		EndIf
	Next
EndFunc

Func _beforeValue($stSht, $row, $col)
	Local $Value
	If $stSht.Cells($row, $col).Value = "" Then
		$Value = 0
	Else
		$Value = Number($stSht.Cells($row, $col).Value)
	EndIf
	Return $Value
EndFunc