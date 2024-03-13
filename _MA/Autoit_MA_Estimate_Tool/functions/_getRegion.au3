;~ ConsoleWrite(_getRegion("SM-A5360_UM_Open_China_SS_Chi_D00_220112_사업부요청.pdf"))

Func _getRegion($pdfFile)
	Switch $pdfFile
		Case StringInStr($pdfFile, "EU_ASIA_Type") = True
			Return "EU_ASIA_Type"
		Case StringInStr($pdfFile, "EUROPE") = True
			Return "EUROPE"
		Case StringInStr($pdfFile, "Open_HHP_EUROPE") = True
			Return "Open_HHP_EUROPE"
		Case StringInStr($pdfFile, "EU") = True
			Return "EU"
		Case StringInStr($pdfFile, "MIDDLE_EAST_ASIA_AFRICA") = True
			Return "MIDDLE_EAST_ASIA_AFRICA"
		Case StringInStr($pdfFile, "ASIA") = True
			Return "ASIA"
		Case StringInStr($pdfFile, "Open_BALTIC") = True
			Return "Open_BALTIC"
		Case StringInStr($pdfFile, "BALTIC") = True
			Return "BALTIC"
		Case StringInStr($pdfFile, "CA_COMMON") = True
			Return "CA_COMMON"
		Case StringInStr($pdfFile, "HK_COMMON") = True
			Return "HK_COMMON"
		Case StringInStr($pdfFile, "CANADA_Type") = True
			Return "CANADA_Type"
		Case StringInStr($pdfFile, "CANADA") = True
			Return "CANADA"
		Case StringInStr($pdfFile, "CHINA_Type") = True
			Return "CHINA_Type"
		Case StringInStr($pdfFile, "ChinaTelecom_China") = True
			Return "ChinaTelecom China"
		Case StringInStr($pdfFile, "CMCC_China") = True
			Return "CMCC China"
		Case StringInStr($pdfFile, "Open_China") = True
			Return "Open_China"
		Case StringInStr($pdfFile, "CIS_Type") = True
			Return "CIS_Type"
		Case StringInStr($pdfFile, "CIS") = True
			Return "CIS"
		Case StringInStr($pdfFile, "SWA_INDIA") = True
			Return "SWA_INDIA"
		Case StringInStr($pdfFile, "INDIA") = True
			Return "INDIA"
		Case StringInStr($pdfFile, "INDONESIAN_Type") = True
			Return "INDONESIAN_Type"
		Case StringInStr($pdfFile, "INDONESIA_ONLY") = True
			Return "INDONESIA_ONLY"
		Case StringInStr($pdfFile, "JAPAN_Type") = True
			Return "JAPAN_Type"
		Case StringInStr($pdfFile, "JAPAN") = True
			Return "JAPAN"
		Case StringInStr($pdfFile, "KOREA_Type") = True
			Return "KOREA_Type"
		Case StringInStr($pdfFile, "KX") = True
			Return "한국향"
		Case StringInStr($pdfFile, "LATIN_AMERICA_Type") = True
			Return "LATIN_AMERICA_Type"
		Case StringInStr($pdfFile, "LTN") = True
			Return "LTN"
		Case StringInStr($pdfFile, "MALAYSIA_ONLY") = True
			Return "MALAYSIA_ONLY"
		Case StringInStr($pdfFile, "MEA_HHP_ALGERIA") = True
			Return "MEA_HHP_ALGERIA"
		Case StringInStr($pdfFile, "MEA") = True
			Return "MEA"
		Case StringInStr($pdfFile, "Open_Hongkong") = True
			Return "Open HongKong"
		Case StringInStr($pdfFile, "Open_SCAN") = True
			Return "Open_SCAN"
		Case StringInStr($pdfFile, "Open_SEAD") = True
			Return "Open_SEAD"
		Case StringInStr($pdfFile, "Open_SWITZERLAND") = True
			Return "Open_SWITZERLAND"
		Case StringInStr($pdfFile, "Open_Taiwan") = True
			Return "Open_Taiwan"
		Case StringInStr($pdfFile, "SCAN") = True
			Return "SCAN"
		Case StringInStr($pdfFile, "SEA_HHP_THAILAND") = True
			Return "SEA_HHP_THAILAND"
		Case StringInStr($pdfFile, "SEA_Type") = True
			Return "(Accessory)SEA_Type"
		Case StringInStr($pdfFile, "TAIWAN_Type") = True
			Return "TAIWAN_Type"
		Case StringInStr($pdfFile, "TURKEY ONLY") = True
			Return "TURKEY ONLY"
		Case StringInStr($pdfFile, "TURKISH_Type") = True
			Return "TURKISH_Type"
		Case StringInStr($pdfFile, "USA_Type") = True
			Return "USA_Type"
		Case StringInStr($pdfFile, "VIETNAM_ONLY") = True
			Return "VIETNAM_ONLY"
		Case StringInStr($pdfFile, "VPS_Global") = True
			Return "VPS_Global"
		Case StringInStr($pdfFile, "USA") = True
			Return "USA"
		Case StringInStr($pdfFile, "SWA") = True
			Return "SWA"
		Case StringInStr($pdfFile, "SEA") = True
			Return "SEA"
		Case StringInStr($pdfFile, "Open") = True
			Return "Open"
		Case Else
			Return "None"
	EndSwitch
EndFunc