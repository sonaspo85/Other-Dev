Option Explicit
Sub loadCustomTabOfRibbon(ribbon As IRibbonUI)
     '//엑셀이 시작되면 사용자정의 탭을 활성화시킨다.
    On Error Resume Next
    ribbon.ActivateTab "myTabId001"
End Sub
Sub eXportData(control As IRibbonControl)
    Call eXportData2xml
    MsgBox ("완료합니다.")
End Sub
Public Sub eXportData2xml()
    Dim wkSht As Worksheet
    Dim unitSht As Worksheet
    Dim oText As New CStringBuilder
    Dim sText As String
    Dim lLastCol As Long
    Dim lLastRow As Long
    Dim i As Long, j As Long
    Dim sXML As String
    Dim sRoot As String
    Dim sRootx As String
    Dim sLngCell As Range
    Dim oCell As Range
    Dim lCell As Range
    Dim torf As String
    Dim sFile As String
    Dim sID As String
    Dim sUnit As Variant
    Dim cUnit As String
    Const Q As String = """"
    
    Set wkSht = ThisWorkbook.Sheets("Package-contents")
    Set unitSht = ThisWorkbook.Sheets("unit")
    lLastRow = GetLastRow(wkSht)
    lLastCol = GetLastCol(wkSht)
    
    sXML = "<?xml version=" & Q & "1.0" & Q & " encoding=" & Q & "UTF-8" & Q & "?>"
    sRoot = "<root>"
    sRootx = "</root>"
    
    oText.Add sXML
    oText.Add sRoot
    
    'packages 구성, apply=false
    oText.Add vbTab & "<packages>"
    For j = 2 To lLastCol
        DoEvents
        Set sLngCell = wkSht.Cells(1, j)
        oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & "true" & Q & " exc=" & Q & Q & ">"
        For i = 2 To lLastRow
            Set oCell = wkSht.Cells(i, j)
            sID = LCase(Replace(wkSht.Cells(i, 2).Value, " ", ""))
            sID = Replace(Replace(sID, "(", "_"), ")", "_")
            oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & ">" & oCell.Value & "</item>"
        Next i
        oText.Add vbTab & vbTab & "</items>"
    Next j
    oText.Add vbTab & "</packages>"
    
    'Sar 구성
    Set wkSht = ThisWorkbook.Sheets("SAR")
    lLastRow = GetLastRow(wkSht)
    lLastCol = GetLastCol(wkSht)
    
    oText.Add vbTab & "<sars>"
    For j = 2 To lLastCol
        DoEvents
        Set sLngCell = wkSht.Cells(1, j)
        'SAR 적용 여부
        If sLngCell.Value = "Fre(EU)" Or sLngCell.Value = "Fre" Or sLngCell.Value = "Tur" Or sLngCell.Value = "Ind" Or sLngCell.Value = "Khm" _
        Or sLngCell.Value = "Mya" Or sLngCell.Value = "Chi(Singapore)" Or sLngCell.Value = "Tha" Or sLngCell.Value = "Vie" Or sLngCell.Value = "Ben" _
        Or sLngCell.Value = "Eng(India)" Or sLngCell.Value = "Chi(Taiwan)" Or sLngCell.Value = "Ind" Or sLngCell.Value = "Lao" Then
            torf = "true"
        Else
            torf = "false"
        End If

        oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & torf & Q & " exc=" & Q & Q & ">"
        For i = 2 To lLastRow - 1
            Set oCell = wkSht.Cells(i, j)
            If i = 2 Then
                sID = "maxsar"
                If oCell.Value = "" Then
                    oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & "></item>"
                Else
                    oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & ">" & oCell.Value & "</item>"
                End If
            ElseIf i > 2 And i < 9 And i <> 4 And i <> 6 Then
                sID = LCase(Replace(wkSht.Cells(i, 2).Value, " ", ""))
                Set lCell = wkSht.Cells(i + 1, j)
                Debug.Print lCell.Address & ":" & oCell.Address
                If oCell.Value = "" Then
                    oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & " unit=" & Q & sUnit(1) & Q & "></item>"
                Else
                    If i > 6 Then
                        sUnit = Split(Replace(wkSht.Cells(6, j).Value, """", "&quot;"), " ")
                    Else
                        sUnit = Split(Replace(lCell.Value, """", "&quot;"), " ") 'HEB의 경우 unit 값에 따옴표가 들어감
                    End If
                    oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & " unit=" & Q & sUnit(1) & Q & ">" & oCell.Value & "</item>"
                End If
            Else
                'Nothing
            End If
        Next i
        If sLngCell.Value = "Fre(EU)" Then
                oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "limbsar1" & Q & " unit=" & Q & sUnit(1) & Q & ">" & "DAS membre" & "</item>"
            End If
        oText.Add vbTab & vbTab & "</items>"
    Next j
    oText.Add vbTab & "</sars>"

    '이격 거리 구성
    oText.Add vbTab & "<distance>"
    For i = 2 To lLastCol
        DoEvents
        j = 9

        Set sLngCell = wkSht.Cells(1, i)
        If sLngCell.Value = "Fre(EU)" Or sLngCell.Value = "Fre" Or sLngCell.Value = "Tur" Or sLngCell.Value = "Ind" Or sLngCell.Value = "Khm" Or sLngCell.Value = "Mya" _
        Or sLngCell.Value = "Chi(Singapore)" Or sLngCell.Value = "Vie" Or sLngCell.Value = "Ben" Or sLngCell.Value = "Lao" Then
            torf = "true"
        Else
            torf = "false"
        End If

        oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & torf & Q & " exc=" & Q & Q & ">"
        '언어에 따라 cm 단위가 다름
        If sLngCell.Value = "Ara" Then
            cUnit = unitSht.Range("E5").Value
        ElseIf sLngCell.Value = "Arm" Then
            cUnit = unitSht.Range("F5").Value
        ElseIf sLngCell.Value = "Far" Then
            cUnit = unitSht.Range("P5").Value
        ElseIf sLngCell.Value = "Geo" Then
            cUnit = unitSht.Range("S5").Value
        ElseIf sLngCell.Value = "Gre" Then
            cUnit = unitSht.Range("U5").Value
        ElseIf sLngCell.Value = "Heb" Then
            cUnit = Replace(unitSht.Range("V5").Value, """", "&quot;")
        ElseIf sLngCell.Value = "Hin" Then
            cUnit = unitSht.Range("W5").Value
        ElseIf sLngCell.Value = "HongKong" Then
            cUnit = unitSht.Range("X5").Value
        ElseIf sLngCell.Value = "Chi(Singapore)" Then
            cUnit = unitSht.Range("AP5").Value
        ElseIf sLngCell.Value = "Aze" Or sLngCell.Value = "Uzb" Then
            cUnit = "sm"
        ElseIf sLngCell.Value = "Tha" Then
            cUnit = unitSht.Range("AV5").Value
        ElseIf sLngCell.Value = "Urd" Then
            cUnit = unitSht.Range("AY5").Value
        ElseIf sLngCell.Value = "Ukr" Or sLngCell.Value = "Bul" Or sLngCell.Value = "Kaz" Or sLngCell.Value = "Mac" Or sLngCell.Value = "Mon" Or sLngCell.Value = "Rus" Then
            cUnit = "см"
        Else
            cUnit = "cm"
        End If
        Set oCell = wkSht.Cells(j, i)
        oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "distance" & Q & " unit=" & Q & cUnit & Q & ">" & oCell.Value & "</item>"
        oText.Add vbTab & vbTab & "</items>"
    Next i
    oText.Add vbTab & "</distance>"
    
    'Wearable 이격 거리 구성
    oText.Add vbTab & "<w-distance>"
    For i = 2 To lLastCol
        DoEvents
        j = 10

        Set sLngCell = wkSht.Cells(1, i)
        If sLngCell.Value = "Fre(EU)" Or sLngCell.Value = "Fre" Or sLngCell.Value = "Tur" Or sLngCell.Value = "Ind" Or sLngCell.Value = "Khm" Or sLngCell.Value = "Mya" _
        Or sLngCell.Value = "Chi(Singapore)" Or sLngCell.Value = "Vie" Or sLngCell.Value = "Ben" Or sLngCell.Value = "Lao" Then
            torf = "true"
        Else
            torf = "false"
        End If

        oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & torf & Q & " exc=" & Q & Q & ">"
        '언어에 따라 cm 단위가 다름
        If sLngCell.Value = "Ara" Then
            cUnit = unitSht.Range("E5").Value
        ElseIf sLngCell.Value = "Arm" Then
            cUnit = unitSht.Range("F5").Value
        ElseIf sLngCell.Value = "Far" Then
            cUnit = unitSht.Range("P5").Value
        ElseIf sLngCell.Value = "Geo" Then
            cUnit = unitSht.Range("S5").Value
        ElseIf sLngCell.Value = "Gre" Then
            cUnit = unitSht.Range("U5").Value
        ElseIf sLngCell.Value = "Heb" Then
            cUnit = Replace(unitSht.Range("V5").Value, """", "&quot;")
        ElseIf sLngCell.Value = "Hin" Then
            cUnit = unitSht.Range("W5").Value
        ElseIf sLngCell.Value = "HongKong" Then
            cUnit = unitSht.Range("X5").Value
        ElseIf sLngCell.Value = "Chi(Singapore)" Then
            cUnit = unitSht.Range("AP5").Value
        ElseIf sLngCell.Value = "Aze" Or sLngCell.Value = "Uzb" Then
            cUnit = "sm"
        ElseIf sLngCell.Value = "Tha" Then
            cUnit = unitSht.Range("AV5").Value
        ElseIf sLngCell.Value = "Urd" Then
            cUnit = unitSht.Range("AY5").Value
        ElseIf sLngCell.Value = "Ukr" Or sLngCell.Value = "Bul" Or sLngCell.Value = "Kaz" Or sLngCell.Value = "Mac" Or sLngCell.Value = "Mon" Or sLngCell.Value = "Rus" Then
            cUnit = "см"
        Else
            cUnit = "cm"
        End If
        Set oCell = wkSht.Cells(j, i)
        oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "distance" & Q & " unit=" & Q & cUnit & Q & ">" & oCell.Value & "</item>"
        oText.Add vbTab & vbTab & "</items>"
    Next i
    oText.Add vbTab & "</w-distance>"
    
    'Buds Sar
    Dim strVal As String
    oText.Add vbTab & "<buds-sars>"
    For i = 2 To lLastCol
        DoEvents
        j = 11
        Set sLngCell = wkSht.Cells(1, i)
        Set oCell = wkSht.Cells(j, i)
        Set lCell = wkSht.Cells(i + 1, j)
        
        'SAR 적용 여부
        If sLngCell.Value = "Fre(EU)" Or sLngCell.Value = "Fre" Or sLngCell.Value = "Tur" Or sLngCell.Value = "Ind" Or sLngCell.Value = "Khm" _
        Or sLngCell.Value = "Mya" Or sLngCell.Value = "Chi(Singapore)" Or sLngCell.Value = "Tha" Or sLngCell.Value = "Vie" Or sLngCell.Value = "Ben" _
        Or sLngCell.Value = "Eng(India)" Or sLngCell.Value = "Chi(Taiwan)" Or sLngCell.Value = "Ind" Or sLngCell.Value = "Lao" Then
            torf = "true"
        Else
            torf = "false"
        End If
        
        If IsEmpty(wkSht.Cells(6, i).Value) Then
            strVal = "1.299 W/kg"
        Else
            strVal = wkSht.Cells(6, i).Value
        End If
        sUnit = Split(Replace(strVal, """", "&quot;"), " ")
        
        oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & torf & Q & " exc=" & Q & Q & ">"
        oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "body-wornsar" & Q & " unit=" & Q & sUnit(1) & Q & ">" & oCell.Value & "</item>"
        oText.Add vbTab & vbTab & "</items>"
    Next
    oText.Add vbTab & "</buds-sars>"
    'Band and mode 구성
    Set wkSht = ThisWorkbook.Sheets("Band-mode")
    lLastRow = GetLastRow(wkSht)
    lLastCol = GetLastCol(wkSht)
    
    oText.Add vbTab & "<bandmode>"
    For i = 2 To lLastCol
        DoEvents
        Dim sLang As String
        Dim sMulti As String

        Set sLngCell = wkSht.Cells(1, i)
        sLang = sLngCell.Value
        If sLang = "Kaz" Or sLang = "Mon" Or sLang = "Uzb" Or sLang = "Heb" Or sLang = "Ara" Or sLang = "Urd" Or sLang = "Spa(LTN)" _
           Or sLang = "Aze" Or sLang = "Geo" Or sLang = "Ben" Or sLang = "Ind" Or sLang = "Khm" Or sLang = "Lao" _
           Or sLang = "Mya" Or sLang = "Chi(Singapore)" Or sLang = "Tha" Or sLang = "Eng(India)" Or sLang = "Rus" _
           Or sLang = "Rum" Or sLang = "Ukr" Or sLang = "Fre" Or sLang = "Vie" Or sLang = "HongKong" Or sLang = "Arm" Then
            torf = "false"
        Else
            torf = "true"
        End If

        If sLang = "Fre" Then
            oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & torf & Q & " exc=" & Q & "MEA" & Q & ">"
        Else
            oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & torf & Q & " exc=" & Q & Q & ">"
        End If

        For j = 2 To lLastRow
            If j = 2 Or j = 3 Then
                Set oCell = wkSht.Cells(j, i)
                sID = LCase(Replace(wkSht.Cells(j, 2).Value, " ", ""))
                oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & ">" & oCell.Value & "</item>"
            ElseIf j = 4 Or j = 6 Or j = 8 Or j = 10 Or j = 12 Or j = 14 Or j = 16 Or j = 18 Or j = 20 Or j = 22 Or j = 24 Or j = 26 Or j = 30 Or j = 32 Then
                Set oCell = wkSht.Cells(j, i)
                Set lCell = wkSht.Cells(j + 1, i)

                If j = 8 Or j = 10 Then
                    If sLngCell.Value = "Ukr" Then
                        sMulti = "true"
                    Else
                        sMulti = "true"
                    End If
                    If j = 8 Then
                        sID = "wcdma900/wcdma2100"
                    ElseIf j = 10 Then
                        sID = "lte"
                    End If
                ElseIf j = 16 Then
                    sMulti = "false"
                    sID = "wifi5_1_5_7ghz"
                ElseIf j = 20 Then
                    sMulti = "false"
                    sID = "wifi5_9_6_4ghz"
                ElseIf j = 22 Then
                    sMulti = "false"
                    sID = "nfc1"
                ElseIf j = 24 Then
                    sMulti = "false"
                    sID = LCase(Replace(wkSht.Cells(j, 2).Value, " ", ""))
                ElseIf j = 26 Then
                    sMulti = "false"
                    sID = "uwb6-8_5ghz"
                ElseIf j = 32 Then
                    sMulti = "false"
                    sID = "mst3_6khz"
                Else
                    sMulti = "false"
                    sID = LCase(Replace(wkSht.Cells(j, 2).Value, " ", ""))
                    sID = Replace(Replace(Replace(Replace(sID, "/", ""), ".", "_"), "-", ""), ",", "_")
                End If
                
                If lCell.Value = "" Then
                    sUnit = ""
                ElseIf j = 22 Or j = 24 Then
                    sUnit = "dBμA/m"
                Else
                    sUnit = Split(Replace(lCell.Value, """", "&quot;"), " ")
                    Debug.Print lCell.Value
                    sUnit = sUnit(1)
                End If

                If oCell.Value = "" Then
                    oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & " unit=" & Q & sUnit & Q & " multi=" & Q & sMulti & Q & "></item>"
                ElseIf oCell.Value = "WCDMA Band VIII/Band I" Then
                    oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "wcdma900" & Q & " unit=" & Q & sUnit & Q & " multi=" & Q & "false" & Q & ">" & "WCDMA Band VIII" & "</item>"
                    oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "wcdma2100" & Q & " unit=" & Q & sUnit & Q & " multi=" & Q & "false" & Q & ">" & "WCDMA Band I" & "</item>"
                Else
                    oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & " unit=" & Q & sUnit & Q & " multi=" & Q & sMulti & Q & ">" & Replace(oCell.Value, ChrW(&HA0), " ") & "</item>"
                End If
            ElseIf j = 28 Or j > 28 Then 'n1/n3 ...
'                Set oCell = wkSht.Cells(j, i)
'                oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "5g" & Q & " unit=" & Q & "dBm" & Q & " multi=" & Q & "Multi" & Q & ">" & oCell.Value & "</item>"
            Else
                'Nothing
            End If
        Next j
        oText.Add vbTab & vbTab & "</items>"
    Next i
    oText.Add vbTab & "</bandmode>"

    '터키 only 제품 사양
    Set wkSht = ThisWorkbook.Sheets("etc")
    lLastRow = GetLastRow(wkSht)
    lLastCol = GetLastCol(wkSht)
    
    oText.Add vbTab & "<productSpec>"
    Set sLngCell = wkSht.Cells(1, 51)
    oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & "true" & Q & " exc=" & Q & Q & ">"
    For j = 2 To 12
        sID = LCase(Replace(wkSht.Cells(j, 2).Value, " ", ""))
        Set oCell = wkSht.Cells(j, 51)
        oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & ">" & oCell.Value & "</item>"
    Next j
    oText.Add vbTab & vbTab & "</items>"
    oText.Add vbTab & "</productSpec>"
    '터키 only 제품 보증 문구
    oText.Add vbTab & "<turgaranty>"
    oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & "true" & Q & " exc=" & Q & Q & ">"
    oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "garanty" & Q & ">" & wkSht.Cells(20, 51).Value & "</item>"
    oText.Add vbTab & vbTab & "</items>"
    oText.Add vbTab & "</turgaranty>"
    
    '터키 only band mode Wifi 5 지원 문구
    oText.Add vbTab & "<turwifi5>"
    oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & "true" & Q & " exc=" & Q & Q & ">"
    oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "turwifi5" & Q & ">" & wkSht.Cells(21, 51).Value & "</item>"
    oText.Add vbTab & vbTab & "</items>"
    oText.Add vbTab & "</turwifi5>"

    'LTN-Spa Only 전기 사양
    oText.Add vbTab & "<electronic>"
    Set sLngCell = wkSht.Cells(1, 5)
    With wkSht
        oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & "true" & Q & " exc=" & Q & Q & ">"
        oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "electronicspec" & Q & ">" & .Cells(13, 5).Value & "</item>"
        oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "adapter" & Q & " name=" & Q & .Cells(14, 5).Value & Q & ">"
        oText.Add vbTab & vbTab & vbTab & vbTab & "<entries id=" & Q & "entry" & Q & " name=" & Q & .Cells(15, 5).Value & Q & ">"
        oText.Add vbTab & vbTab & vbTab & vbTab & vbTab & "<entry id=" & Q & "entry1" & Q & " unit=" & Q & "Vca" & Q & "/>"
        oText.Add vbTab & vbTab & vbTab & vbTab & vbTab & "<entry id=" & Q & "entry2" & Q & " unit=" & Q & "Hz" & Q & "/>"
        oText.Add vbTab & vbTab & vbTab & vbTab & vbTab & "<entry id=" & Q & "entry3" & Q & " unit=" & Q & "A" & Q & "/>"
        oText.Add vbTab & vbTab & vbTab & vbTab & "</entries>"
        oText.Add vbTab & vbTab & vbTab & vbTab & "<entries id=" & Q & "departure" & Q & " name=" & Q & .Cells(16, 5).Value & Q & ">"
        oText.Add vbTab & vbTab & vbTab & vbTab & vbTab & "<entry id=" & Q & "departure1" & Q & " unit=" & Q & "Vcc;A;o" & Q & "/>"
        oText.Add vbTab & vbTab & vbTab & vbTab & vbTab & "<entry id=" & Q & "departure2" & Q & " unit=" & Q & "Vcc;A" & Q & "/>"
        oText.Add vbTab & vbTab & vbTab & vbTab & "</entries>"
        oText.Add vbTab & vbTab & vbTab & "</item>"
        oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "device" & Q & " name=" & Q & .Cells(17, 5).Value & Q & ">"
        oText.Add vbTab & vbTab & vbTab & vbTab & "<entries id=" & Q & "entry" & Q & " name=" & Q & .Cells(18, 5).Value & Q & ">"
        oText.Add vbTab & vbTab & vbTab & vbTab & vbTab & "<entry id=" & Q & "entry1" & Q & " unit=" & Q & "Vcc;A" & Q & "/>"
        oText.Add vbTab & vbTab & vbTab & vbTab & "</entries>"
        oText.Add vbTab & vbTab & vbTab & "</item>"
    End With
    oText.Add vbTab & vbTab & "</items>"
    oText.Add vbTab & "</electronic>"

    'Ind Only 국가 등록 번호
    oText.Add vbTab & "<registration>"
    oText.Add vbTab & vbTab & "<items lang=" & Q & "Ind" & Q & " apply=" & Q & "true" & Q & " exc=" & Q & Q & ">"
    oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & "regNum" & Q & ">" & wkSht.Cells(19, 27).Value & "</item>"
    oText.Add vbTab & vbTab & "</items>"
    oText.Add vbTab & "</registration>"
    
    'fingerPrint
    Set wkSht = ThisWorkbook.Sheets("Fingerprint-sensor")
    lLastRow = GetLastRow(wkSht)
    lLastCol = GetLastCol(wkSht)
    
    oText.Add vbTab & "<fingerprint>"
    For i = 2 To lLastCol
        DoEvents
        Set sLngCell = wkSht.Cells(1, i)
        oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & "true" & Q & " exc=" & Q & Q & ">"
        For j = 2 To lLastRow
            Set oCell = wkSht.Cells(j, i)
            sID = LCase(Replace(wkSht.Cells(j, 1).Value, " ", ""))
            sID = Replace(Replace(sID, "(", "_"), ")", "_")
            oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & ">" & oCell.Value & "</item>"
        Next
        oText.Add vbTab & vbTab & "</items>"
    Next
    oText.Add vbTab & "</fingerprint>"
    
    'eDoc
    Set wkSht = ThisWorkbook.Sheets("e-DoC")
    lLastRow = GetLastRow(wkSht)
    lLastCol = GetLastCol(wkSht)
    
    oText.Add vbTab & "<eDoc>"
    For i = 2 To lLastCol
        DoEvents
        Set sLngCell = wkSht.Cells(1, i)
        oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & "true" & Q & " exc=" & Q & Q & ">"
        For j = 2 To lLastRow
            Set oCell = wkSht.Cells(j, i)
            sID = LCase(Replace(wkSht.Cells(j, 1).Value, " ", ""))
            sID = Replace(Replace(sID, "(", "_"), ")", "_")
            oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & ">" & oCell.Value & "</item>"
        Next
        oText.Add vbTab & vbTab & "</items>"
    Next
    oText.Add vbTab & "</eDoc>"
    
    'India BIS
    Set wkSht = ThisWorkbook.Sheets("INDIA-BIS")
    lLastRow = GetLastRow(wkSht)
    lLastCol = GetLastCol(wkSht)
    
    oText.Add vbTab & "<indiabis>"
    For i = 2 To 3
        DoEvents
        Set sLngCell = wkSht.Cells(1, i)
        oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & "true" & Q & " exc=" & Q & Q & ">"
        For j = 2 To lLastRow
            Set oCell = wkSht.Cells(j, i)
            sID = LCase(Replace(wkSht.Cells(j, 1).Value, " ", ""))
            sID = Replace(Replace(sID, "(", "_"), ")", "_")
            oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & ">" & oCell.Value & "</item>"
        Next
        oText.Add vbTab & vbTab & "</items>"
    Next
    oText.Add vbTab & "</indiabis>"
    
    'Opensource
    Set wkSht = ThisWorkbook.Sheets("opensource")
    lLastRow = GetLastRow(wkSht)
    lLastCol = GetLastCol(wkSht)
    
    oText.Add vbTab & "<opensources>"
    For i = 2 To lLastCol
        DoEvents
        Set sLngCell = wkSht.Cells(1, i)
        oText.Add vbTab & vbTab & "<items lang=" & Q & sLngCell.Value & Q & " apply=" & Q & "true" & Q & " exc=" & Q & Q & ">"
        For j = 2 To lLastRow
            Set oCell = wkSht.Cells(j, i)
            sID = LCase(Replace(wkSht.Cells(j, 1).Value, " ", ""))
            sID = Replace(Replace(sID, "(", "_"), ")", "_")
            oText.Add vbTab & vbTab & vbTab & "<item id=" & Q & sID & Q & ">" & oCell.Value & "</item>"
        Next
        oText.Add vbTab & vbTab & "</items>"
    Next
    oText.Add vbTab & "</opensources>"
    
    
    oText.Add sRootx
    Dim destfdPath As String
    destfdPath = Replace(ThisWorkbook.Path, "\resource", "")
    sFile = destfdPath & "\xsls\languages.xml"
    SaveUTF8 sFile, oText.StringData(vbCrLf)
End Sub


