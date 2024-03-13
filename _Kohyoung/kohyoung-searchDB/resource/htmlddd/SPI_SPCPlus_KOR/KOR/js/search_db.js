var search=[
{
"toc_id": "chapter01_KOR.html",
 "chapter_i": "1",
 "chapter": "개요",
 "title": "",
 "title2": "",
 "body": "SPC Plus는 ㈜고영테크놀러지의 SPI 장비로 진행한 PCB 검사의 결과를 통계적으로 관리하는 프로그램입니다. 사용자에게 PCB 검사 결과에 대한 통계나 에러 데이터 분석 결과를 제공하여 생산 품질을 개선할 수 있게 돕습니다. 사용자는 SPC Plus를 통해 검사 결과를 바탕으로 검사에 도움이 되는 통계 값들을 여러 가지 시점으로 확인할 수 있습니다. SPC Plus의 주요 기능은 다음과 같습니다. 각각의 PCB의 검사 결과 조회 불량 원인 분석 해당 프린터의 생산 효율 조회 결과에 대한 통계 값을 바탕으로 리포트를 제작 실시간 공정 관리 네트워크를 통해 SMT 전체 라인의 진행 상황을 실시간으로 조회"
},
{
"toc_id": "chapter02_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "",
 "title2": "",
 "body": "이 장에서는 SPC Plus의 화면 구조에 대해 설명합니다. SPC Plus의 화면은 아래와 같이 3가지로 구성됩니다. 메인 메뉴 세부 메뉴 메인 화면"
},
{
"toc_id": "chapter02_heading01_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 메뉴",
 "title2": "",
 "body": "SPC Plus의 메인 메뉴는 SPC Plus 화면의 가장 상단에 있습니다. 메인 메뉴에는 다음 6 가지 항목이 있습니다. ※ 참고 - PCBView, DetectView, DefectSPC, MultiSPC, Histogram은 ListView에서 통계 범위를 지정해야 사용할 수 있습니다. - M.R.T.Chart는 M.R.T.SaveData에서 저장한 데이터가 있어야 사용할 수 있습니다. Home Analysis Search RealTime Tools Help"
},
{
"toc_id": "chapter02_heading02_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "세부 메뉴",
 "title2": "",
 "body": "SPC Plus의 세부 메뉴는 메인 메뉴의 바로 아래에 위치하고 있습니다. 또한 세부 메뉴는 메인 메뉴에 속해 있으며, 따라서 메인 메뉴에 따라 세부 메뉴의 항목이 변합니다. 항목 설명 ListView 설정한 시간 내의 PCB 검사 결과를 PCB 단위로 검색 시, 검사 결과를 정렬하여 표시 PCBView 한 장의 PCB를 상세하게 조회 Barcode 바코드를 이용하여 보드 검색 DefectSPC 선택한 PCB들의 검사 결과와 그에 따른 공정 능력 지수에 대한 통계를 산출 MultiSPC 여러 부품들의 검사 결과에 대해 동시 통계를 산출 M.R.T. Chart Multi Real Time Chart에서 나타난 수치를 제한 없이 저장한 데이터를 로드하여 조회 DefectView 선택한 PCB에서 발생한 불량 수량에 대해 상세 분석 Histogram 여러 PCB의 검사 결과를 히스토그램으로 확인 DefectList 일정 시간 동안의 불량 판정 발생량과 발생 비율에 대한 통계를 산출 YieldView 설정한 시간 동안의 Yield 율이나 평균 Offset, NG 수량 등의 통계 Lot Search PCB의 lot 번호를 기준으로 수율을 산출하고 출력 PCB Shrinkage 선택 보드의 Shrinkage 표시 RealTime Chart 현재 진행하고 있는 검사 작업의 상태를 실시간으로 조회 Comm. History 3D Inspector과 SPC Plus 간의 통신 내역 조회 Print 현재 화면을 프린터로 출력 Setup SPC Plus의 작업 환경 설정 User 사용자 계정 설정 Auto Report 검사 결과를 Excel과 연동하여 변환 출력 및 저장 About SPC Plus에 대한 버전 정보 등을 표시 ※ 참고: 각 세부 메뉴에 대한 상세한 설명은 SPC Plus 기능을 참고하십시오."
},
{
"toc_id": "chapter02_heading03_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 화면",
 "title2": "",
 "body": "SPC Plus의 메인 화면에는 세부 메뉴에서 선택한 View 메뉴에 따라 각각 다른 화면이 나타납니다. ※ 참고: View 메뉴에 대한 자세한 사항은 SPC Plus 기능을 참고하십시오."
},
{
"toc_id": "chapter03_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "",
 "title2": "",
 "body": "이 장에서는 SPC Plus의 Home메뉴에 속한 View 메뉴들을 이용하여 수행하는 다양한 기능들에 대해 설명합니다."
},
{
"toc_id": "chapter03_heading01_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "ListView",
 "title2": "",
 "body": "ListView는 설정한 시간 내의 PCB 검사 결과를 PCB 단위로 검색 시, 검사 결과를 정렬하여 나타내는 메뉴입니다. 다른 View 메뉴로 작업할 때, 통계를 낼 범위를 설정하기도 합니다. 항목 설명 SearchLine IP 주소를 입력하여, 특정 SPI 검사기의 검사 결과 자료 입수 Start/End Date 검색을 시작/종결할 날짜와 시간 설정 Use Time 1일, 1주, 1달 중에서 원하는 시간 단위 선택 JobFilename 입력한 조건의 JOB 파일을 사용하는 PCB만 검색 User Name 입력한 조건의 user가 검사한 PCB만 검색 Lot 입력한 조건의 lot에서 꺼낸 PCB만 검색 Barcode Search 입력한 바코드 번호를 가진 PCB만 검색 View 조건 입력창에 입력한 조건에 따라 검색 List Export 현재 검색된 PCB정보를 파일형식으로 저장 Result Export 선택한 PCB의 결과 정보를 지정한 형식의 파일로 저장 List Header Save 현재 설정한 header의 차례를 저장 Volume VS Area Volume과 area의 관계를 Scatter Chart 형식으로 나열 Screen Capture 메인 화면을 그림 파일 형식으로 저장 Repeatability 특정 PCB 검사 결과의 repeatability를 산출하거나 비교 ※ 참고 - 리스트의 header를 클릭하면 그 항목을 기준으로 하여 결과를 정렬합니다. - 위 항목 중 SearchLine에 대한 설정은 SPC Plus Config 프로그램에서 하십시오. - 위 항목 중 List Export와 Result Export, Screen Capture의 파일 저장 형식은 view 메뉴 중 Setup에서 설정하십시오. 검사 조건 입력창에서, 원하는 항목을 지정한 후 View 버튼을 클릭하십시오. 그러면 입력한 조건에 해당하는 PCB의 검사 결과가 조회창에 나열됩니다."
},
{
"toc_id": "chapter03_heading02_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "PCBView",
 "title2": "",
 "body": "PCBView는 한 장의 PCB를 상세히 조회할 수 있는 메뉴입니다. 다른 View 메뉴로 작업할 때, 통계를 낼 범위를 설정하기도 합니다. PCBView에서는 다음과 같은 정보를 얻을 수 있습니다. PCB 전체의 불량 상황 불량이 발생한 패드에 대한 정보 전체 패드에 대한 결과 정보 해당 PCB의 경향(trend)에 대한 정보 ListView에서 특정 PCB를 더블 클릭하거나 활성화한 후, PCBView 아이콘을 클릭하십시오. 그러면 해당 PCB에 대한 PCBView 화면이 나타납니다. 항목 설명 ALL 모든 패드에 대한 자료를 조회 Value Trend Value Trend 기능 사용 Volume 검사 결과가 특정 범위 안에 있는 패드를 검색 PadID 특정 PadID 혹은 ComponentID를 가진 패드를 검색 , 이전 혹은 다음 불량 패드(defected pad)를 검색 불량 유형 선택한 유형의 불량이 발생한 패드들만 표시 리스트 출력 (List Export) 검색된 PCB의 리스트를 파일 형태로 저장 List Header 저장 (List Header Save) 현재 설정한 header의 차례를 저장 Pad Trends 선택한 패드의 경향(trend)를 나타내는 창을 표시 ※ 참고 - 해당 PCB에 불량 판정을 받은 패드(detected pad)가 있을 경우, 조건 입력창에서 조건을 바꾸거나 혹은 버튼을 클릭하면 불량 판정을 받은 패드를 상세히 조회할 수 있습니다. - 위 항목 중 Value Trend 기능 대해서는 다음 페이지에서 상세히 설명하겠습니다."
},
{
"toc_id": "chapter03_heading02_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "PCBView",
 "title2": "Value Trend 기능",
 "body": "Value Trend는 한 장의 PCB에 도포된 납의 경향(trend)를 파악하는 기능입니다. 이 기능을 사용하려면 다음 순서대로 작업하십시오. PCBView 아이콘을 클릭하십시오. PCBView 화면에서 Value Trend를 선택하십시오. 그러면 다음 화면이 나타납니다. Trend 선택 메뉴 옆에 있는 목록에서 원하는 불량 유형을 고르면, Trend 화면에 선택한 항목에 대한 경향이 나타납니다. ※ 참고: 색상에 대한 기준 값은, User Set 버튼을 클릭하면 변경할 수 있습니다."
},
{
"toc_id": "chapter03_heading02_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "PCBView",
 "title2": "그룹에 따른 Trend 조회 기능",
 "body": "이 기능은 그룹별 trend를 조회하는 기능입니다. 이 기능을 사용하려면, 다음 순서대로 작업하십시오. PCBView 아이콘을 클릭하십시오. PCBView 화면에서 Value Trend를 선택하십시오. 그러면 다음 화면이 나타납니다. Group Search를 선택하십시오. Group Search 옆의 선택상자에서 검색할 그룹을 선택하고 해당 조건을 입력한 후 Search 버튼을 클릭하십시오."
},
{
"toc_id": "chapter03_heading02_sub03_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "PCBView",
 "title2": "메인 화면에 3D View 표시 기능",
 "body": "이 기능은 3D View가 팝업창으로 뜨지 않고 화면 내에 나타나게 하는 기능입니다. 이 기능을 사용하려면 다음 순서대로 작업하십시오. PCBView 아이콘을 클릭하십시오. PCBView 화면에서 Fix 3D를 선택하십시오."
},
{
"toc_id": "chapter03_heading02_sub04_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "PCBView",
 "title2": "Area View 기능",
 "body": "이 기능은 PCB에서 선택한 크기에 맞추어 2D Image와 Offset을 표시하는 기능입니다. 이 기능을 사용하려면 다음 순서대로 작업하십시오. PCBView 아이콘을 클릭하십시오. PCBView 화면의 왼쪽 하단에 있는 Area 항목을 선택하십시오. View 버튼을 클릭하십시오. ※ 참고: ROI 항목을 선택하면, 2D Image 상에 Offset과 Center 값을 표시할 수 있습니다."
},
{
"toc_id": "chapter03_heading03_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "불량보기(DefectView)",
 "title2": "",
 "body": "불량보기(DefectView)는 선택한 PCB에서 발생한 defect 수량에 대한 자세한 분석을 할 수 있는 메뉴입니다. 불량보기에서는 다음과 같은 작업을 할 수 있습니다. 설정한 PCB들이 불량 판정을 받은 원인 검토 가장 자주 발생하는 불량 유형 확인 문제가 자주 발생하는 component 확인 ListView에서 2개 이상의 PCB를 선택한 후, 불량보기 아이콘을 클릭하십시오. 그러면 아래와 같은 화면이 나타납니다. 불량보기(Defect View) 창 기타 메뉴들에 대한 설명은 아래와 같습니다. 항목 설명 All, Array, Panel - All: 선택한 PCB의 불량 수량 - Array: 선택한 array의 불량 수량 - Panel: 선택한 패널의 불량 수량 선택 리스트 (Select List) Setup에서 Defect Limit로 제한해서 표시되지 않은 PCB와 표시된 PCB를 목록으로 나열 화면 저장 (Screen Capture) 현재 화면을 그림 파일 형식으로 저장 끝내기 (Close) 현재 작업을 종료 ※ 참고 - 검사를 진행할 때, JOB 파일에 ComponentID를 입력하면 좀더 상세한 정보를 얻을 수 있습니다. - 위 항목 중 화면 저장의 파일 저장 경로는 세부 메뉴 중 Setup에서 설정하십시오."
},
{
"toc_id": "chapter03_heading04_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "DefectSPC",
 "title2": "",
 "body": "DefectSPC는 선택한 PCB들의 검사 결과와 그에 따른 공정 능력 지수에 대한 통계를 산출하는 메뉴입니다. 해당 PCB들의 X bar-S chart, X bar-R chart, IMR(X-Bar-Rs) Chart를 제공하여 문제 해결을 돕습니다. 이 메뉴를 사용하려면, 다음 순서대로 작업하십시오. ListView에서 2개 이상의 PCB를 선택한 후, DefectSPC 아이콘을 클릭하십시오. 그러면 SPC Condition 대화상자가 나타납니다. SPC Condition 대화상자에서 원하는 사항을 선택한 후, OK 버튼을 클릭하십시오. 기타 항목들에 대한 설명은 다음을 참고하십시오. 항목 설명 Custom USL/LSL 공정능력 지수를 구할 때의 USL값이나 LSL 값을 따로 지정 X-bar custom UCL/LCL X-bar chart에 사용될 UCL과 LCL값을 수동으로 지정 Sigma Custom UCL/LCL Sigma chart에 사용될 UCL값과 LCL값을 수동으로 지정 List Export 현재 보여지는 Chart의 Value값들을 파일 형태로 저장 Select List Setup에서 Defect Limit로 제한해서 표시되지 않은 PCB와 표시된 PCB를 목록으로 나열 Screen Capture 현재 화면을 그림 파일 형식으로 저장 ※ 참고 - DefectSPC는 전체 패드에 대한 것보다 특정 ComponentID에 대한 통계를 낼 때 사용하기에 적합한 메뉴입니다. - 위 항목 중 Screen Capture의 파일 저장 경로는 Setup에서 설정하십시오."
},
{
"toc_id": "chapter03_heading04_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "DefectSPC",
 "title2": "SPC Condition 대화 상자",
 "body": "SPC Condition 대화 상자에서 옵션을 정하면, PCB의 특정 영역에 대해서만 통계를 낼 수 있습니다. SPC Condition 대화상자에서 옵션을 정하려면, 다음 순서대로 작업하십시오. SPC Condition 대화상자에서 Group Pad를 선택하고 Select Group 버튼을 클릭하십시오. 그러면 PCB Group 대화상자가 나타납니다. 특정 영역을 선택한 후, 확인 버튼을 클릭하십시오. 그러면 아래와 같이 해당 영역에 대한 Defect View가 나타납니다."
},
{
"toc_id": "chapter03_heading04_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "DefectSPC",
 "title2": "Customer UCL/LCL, Customer USL/LSL 설정값 저장",
 "body": "이 기능은 관리상한(UCL)/관리하한(LCL)값을 설정해 주는 기능입니다. 이 기능을 사용하려면 하기와 같은 절차를 수행합니다. DefectSPC 화면 우측 Process Capability의 Custom USL/LSL 버튼을 클릭하여 Custom USL/LSL 대화상자를 활성화합니다. 위와 같이 Customer Cp/Cpk 항목을 선택하고, 설정값을 저장한 후 OK 버튼을 클릭합니다. ※ 참고 - UCL: Upper Control Limit: 관리상한 - LCL: Lower Control Limit: 관리하한 - USL: Upper Specification Limit: 규격상한 - LSL: Lower Specification Limit: 규격하한"
},
{
"toc_id": "chapter03_heading04_sub03_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "DefectSPC",
 "title2": "Defect SPC &gt; PCB View 위치에 PCB 정보 표시",
 "body": "Defect SPC에서 PCB View 대신 PCB 정보를 표시하도록 설정할 수 있습니다. 설정 방법 PCB View 대신 PCB 정보를 표시하려면, C:\\Kohyoung\\KY3030\\PollingConfig.ini 파일을 열고 아래와 같이 설정하십시오. [BASIC] --&gt; DISPLAY_CPCPK_PCBINFO=True ※ 참고: 위 항목을 별도로 설정하지 않으면, 기존과 동일하게 Defect SPC 화면에 PCB View를 표시합니다."
},
{
"toc_id": "chapter03_heading05_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "MultiSPC",
 "title2": "",
 "body": "MultiSPC는 여러 개의 component의 검사 결과에 대한 동시 통계를 산출하는 메뉴입니다. 특정 componentID를 가진 패드의 공정 기간에 따른 변화나 문제점 파악 등을 위해 사용됩니다. 이 메뉴를 사용하려면, 다음 순서대로 작업하십시오. ListView에서 2개 이상의 PCB를 선택한 후, MultiSPC 아이콘을 클릭하십시오. 그러면 SPC Condition 대화상자가 나타납니다. Multi Select 항목에 원하는 ComponentID를 입력한 후 OK 버튼을 클릭하십시오. 위와 같은 MultiSPC 화면이 나타납니다. 선택창에서 다른 요소를 선택하면 해당 요소에 대한 차트로 갱신됩니다. ※ 참고: Multi SPC에서는 최대 6개의 Component에 대한 작업이 가능합니다."
},
{
"toc_id": "chapter03_heading06_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "M.R.T. Chart (Multi Real Time Chart)",
 "title2": "",
 "body": "M.R.T. Chart는 Multi Real Time Chart에서 나타난 수치를 제한 없이 저장한 데이터를 로드하여 조회하는 기능입니다."
},
{
"toc_id": "chapter03_heading06_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "M.R.T. Chart (Multi Real Time Chart)",
 "title2": "두 가지 모드",
 "body": "M.R.T.Chart는 다음 2개의 모드가 있습니다. One Chart 모드 Six Chart 모드 ※ 참고: 이 매뉴얼은 One Chart 모드를 기준으로 하여 설명합니다. One Chart 모드 메인 화면에서 6개의 chart 데이터 중 1개 데이터를 확대해서 조회할 때 사용하는 모드입니다. M.R.T.Chart 화면 하단의 선택창에서 One Chart를 선택하십시오. Six Chart 모드 메인 화면에서 6개의 chart 데이터를 모두 조회할 때 사용하는 모드입니다. M.R.T.Chart 화면 하단의 선택창에서 Six Chart를 선택하십시오. MRT Chart 자동 출력 현재 화면에 표시된 MRT Chart와 로 데이터(Raw Data)는 Excel 파일로 자동 출력됩니다. ※ 제한 사항 - 이 기능을 사용하려면, Excel이 설치되어 있어야 합니다. - 이 기능은 Six Chart에서만 동작합니다. No. Description Export Export 관련 메뉴 표시 ※ One Chart 선택 시, Chart Export 버튼과 Screen Capture 버튼이 표시되지 않습니다. 저장 경로 출력된 파일이 저장될 경로 표시 Select Folder 출력 파일이 저장될 경로 선택 ※ 저장될 폴더 이름 중간에 빈 공간이 없어야 합니다. File Export 기존의 출력 파일과 동일. 설정 옵션에 따라, txt 또는 csv 파일로 출력 Chart Export Excel 파일 형식으로 출력 - 현재 보여주고 있는 M.R.T. Chart를 출력 - 각 Chart 별로 스크린 캡쳐하여 Report Sheet로 생성 - 각 Chart 별로 Chart의 데이터를 DATA Sheet로 생성 - 각 Chart의 UCL/CL/LCL, CP/CPK 값을 TOTAL_RESULT Sheet로 생성 - 파일명은 ‘MMDD_HHMM_ChartOption_Lane.xls’ 형식으로 저장 ex) 1005_1635_Volume_Lane0.xls - Report Sheet의 이미지는 파일이 저장된 경로에 ‘MMDD_HHMM’ 형식의 폴더에 저장 Screen Capture Chart만 스크린 캡쳐하여 저장. 각 Chart만 스크린 캡쳐하여 출력 파일 저장 경로에 ‘MMDD_HHMMSS’ 형식의 폴더에 저장함."
},
{
"toc_id": "chapter03_heading06_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "M.R.T. Chart (Multi Real Time Chart)",
 "title2": "X Value &amp; S Value Histogram 추가",
 "body": "항목 설명 Chart/Histogram 차트 방식으로 볼지 히스토그램으로 볼지 선택 Histogram Value X Value와 S Value 중 해당 항목 선택 X Value: Volume, Area, Height 값 S Value: 표준편차 Histogram Bar Size 히스토그램의 범위를 선택 List Export 현재 보여지는 차트의 Value값들을 파일 형태로 저장 X VALUE나 S VALUE Histogram을 추가하려면, 다음 순서대로 작업하세요. M.R.T.Chart 화면 하단의 선택창에서 Histogram을 선택하십시오. X Value와 S Value 중 필요한 항목을 선택하십시오."
},
{
"toc_id": "chapter03_heading06_sub03_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "M.R.T. Chart (Multi Real Time Chart)",
 "title2": "MRT 알람 메시지에 코멘트 입력 옵션",
 "body": "MRT Alarm Message 설정에서 Use Comment like SPCPlus옵션을 선택하여, KY-3030에서도 SPCPlus와 동일하게 MRT 알람 메시지에 코멘트를 입력할 수 있습니다. 설정 방법 SPCPlus &gt; Setup &gt; RealTime M.R.T. Setup 탭으로 이동하십시오. Alarm Message 패널에서 KY-3030와 Use Comment like SPCPlus 항목을 선택하십시오. OK 버튼을 클릭하여 설정을 적용하십시오. 사용 방법 SPIGUI를 실행하고, 검사를 진행하십시오. MRT Alarm이 발생하면, 화면에 Alarming Error 창이 팝업합니다. Alarm Log를 선택하고, 하단 입력창에 코멘트를 입력한 후 Add Comment를 클릭하십시오."
},
{
"toc_id": "chapter03_heading07_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "YieldView",
 "title2": "",
 "body": "YieldView는 일정 기간 동안의 작업의 효율성을 파악하기 위한 기능입니다. 설정한 시간 동안의 yield율이나 평균 offset, NG 수량 등의 통계 정보를 얻기 위해 사용합니다. 기간 설정에서 기간 및 기타 설정을 입력한 후, 시작 버튼을 클릭하십시오. 그러면 해당하는 PCB들에 대한 생산 지수가 표시됩니다. 옵션 설정에서 표시 기간이나, 표시할 내용을 변경한 후, 재확인 버튼을 클릭하면 Graph view의 그래프가 변경됩니다. Defect Chart에는 설정한 PCB에서 발생한 불량 판정이 파이 그래프로 나타납니다. ※ 참고: YieldView는 한달 이내의 작업에 대한 통계 처리만 가능합니다."
},
{
"toc_id": "chapter03_heading08_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "DefectList",
 "title2": "",
 "body": "DefectList는 일정 시간 동안의 불량 판정 발생량과 발생 비율에 대한 통계를 산출합니다. DefectList에서는 defect 발생량이나 발생 비율에 대한 통계를 사용하여 라인 환경을 최적화할 수 있습니다. 검색 조건 입력창에서 기간이나 옵션을 설정한 후, 보기나 갱신 버튼을 클릭하면 Defect Chart나 PPM, Defect Counter의 내용이 바뀝니다. Defect Chart: 설정한 PCB에서 발생한 불량 유형의 비율을 파이 그래프로 표시 Defect Counter: 설정한 PCB에서 발생한 불량 패드의 총 개수를 표시 PPM: 백만 개의 PCB 당, 또는 백만 개의 Component 당 발생하는 불량 유형을 표시 항목 설명 Query 검색 옵션에 따라 검색 결과를 list에 표기 Defect type 특정 종류의 불량 유형만 검색 Sort by 정렬하는 기준을 변경 Refresh 입력한 설정에 따라 리스트를 갱신 Export CSV CSV 형식으로 리포트 파일을 작성 Screen Capture 설정한 위치에 Image를 저장 ※ 참고: 위 항목 중 Screen Capture의 파일 저장 경로는 Setup에서 설정하십시오."
},
{
"toc_id": "chapter03_heading09_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Histogram",
 "title2": "",
 "body": "프로그램의 Histogram은 여러 PCB의 검사 결과를 히스토그램으로 확인하는 메뉴입니다. 여러 PCB의 히스토그램을 보면서 PCB 생산의 흐름 및 경향을 한눈에 파악할 수 있습니다. 각 항목에 대해서는 다음 페이지부터 상세하게 설명하겠습니다. ※ 참고: Histogram에서는 전체 패드를 읽어오면 더 정확한 값을 얻을 수 있으며, 어레이나 패널 별로도 확인할 수 있습니다."
},
{
"toc_id": "chapter03_heading09_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Histogram",
 "title2": "히스토그램 목록",
 "body": "히스토그램 목록은 히스토그램 설정창에서 선택한 요인(부피, 높이, 범위, 비틀림)에 대해서 일정 범위까지의 값에 대한 그래프를 보입니다. 히스토그램 목록의 그래프는 다음 요소로 구성되어 있습니다. 4가지 색상의 선 파란색 선: 최저 값 노란색 선: 화면의 중심선 녹색 선: 평균값 빨간색 선: 최대값 3가지 색상의 막대 검은색 막대: 정상 파란색 막대: 해당 요인의 값이 기준 값보다 부족하므로 불량 처리된 패드의 양 빨간색 막대: 해당 요인의 값이 기준 값보다 과하므로 불량 처리된 패드의 양"
},
{
"toc_id": "chapter03_heading09_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Histogram",
 "title2": "PCB 정보 창",
 "body": "PCB 정보창에서는 하기들에 대한 PCB 정보가 보입니다. ID번호 PCB 이름 전체 패드 수 검사 날짜 검사 시간 체적 바코드"
},
{
"toc_id": "chapter03_heading09_sub03_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Histogram",
 "title2": "히스토그램 설정 창",
 "body": "히스토그램 설정창의 average option은 히스토그램 목록에 보일 선들의 위치를 설정하는 항목입니다. average option의 항목에 대해서는 다음 표를 참고하십시오. 항목 설명 Indivisual Avg 히스토그램 리스트를 각각의 기준에 따라 중심, Min, Max 라인 변경 Screen Histo. Avg 화면에 나온 히스토그램들의 평균을 기준으로 중심, Min, Max 라인 변경 All Histo. Avg 전체 히스토그램들의 평균을 기준으로 중심, Min, Max 라인 변경 제한 (Limit) 사용자가 제한 값 설정 화면 저장 (Capture) Setup에서 설정한 위치에 이미지를 저장"
},
{
"toc_id": "chapter03_heading09_sub04_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Histogram",
 "title2": "히스토그램 보기 ",
 "body": "히스토그램의 상세정보를 보다 편리하고 유용하게 보기 위해, 하기의 3 가지 탭으로 분류합니다. Select Histogram Total Histogram Large Histogram Select Histogram Select Histogram 탭에서는 volume, area, height, offset의 히스토그램을 각각 선택하여 볼 수 있습니다. Total Histogram Total Histogram 탭에서는 volume, area, height, offset 히스토그램을 아래와 같이 한 눈에 볼 수 있습니다. Large Histogram Large Histogram 탭에서는 작은 히스토그램을 클릭하여 아래와 같이 큰 히스토그램으로 볼 수 있습니다."
},
{
"toc_id": "chapter03_heading10_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Print",
 "title2": "",
 "body": "Print는 현재 화면을 프린터로 출력할 때 사용하는 메뉴입니다. Print 아이콘을 클릭하면 위 그림과 같은 미리보기 팝업창이 나타납니다. 미리보기의 화면을 프린터로 출력하려면, 팝업창 상단의 Print 버튼을 클릭하십시오. ※ 참고: 현재의 프린터 관련 설정을 하려면 Default Printer 버튼을 클릭하십시오."
},
{
"toc_id": "chapter03_heading11_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Setup",
 "title2": "",
 "body": "Setup은 SPC Plus에서의 작업 환경 및 파일 출력 환경을 설정할 수 있는 메뉴입니다. Setup 아이콘을 클릭하시면 아래와 같은 대화상자가 뜹니다. ※ 참고: 이 메뉴는 구입하신 장비의 종류에 따라 약간의 차이가 존재할 수 있습니다."
},
{
"toc_id": "chapter03_heading11_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Setup",
 "title2": "Basic Setup 탭",
 "body": "Setup 대화상자의 Basic Setup 탭에서는 기본 작업환경 및 파일 출력 환경을 설정합니다. 항목 설명 Export Result Type ListView에서 PCB의 기록을 파일로 저장할 때, 파일의 형식을 선택 UnExport Item: 파일에 포함되지 않을 항목을 선택 Export Item: 파일에 포함될 항목을 선택 Sort By: 파일에 저장할 때, 리스트를 정렬하는 기준을 선택 Export Type: 출력할 파일의 타입을 선택 All: 전체 패드 출력 Group: 그룹 패드 출력 Offset * 1000: Offset값을 *1000 하여 보여줌 PCB View Use Defect: 불량 패드들에 대한 데이터를 보여줌 Use GoldTab: GoldTab 불량에 대한 데이터를 보여줌 Show Vol.Avg: PCBView에서 3Dviewer를 확인할 때, Volume Average 항목을 보이지 않도록 하는 옵션 RealTime Mode RealTime 화면 선택 RealTime 3D RealTime Chart RealTime (Dual Lane) RealTime Multi ※ 참고: 이 메뉴는 버전에 따라 다른 항목이 존재할 수 있습니다. Defect Limit Defect SPC나 Defect View에서 통계를 낼 때, 일정 비율 이상의 defect를 가지는 결과물(예: Bare board 검사, Printer 조정 중 등)을 통계에서 제외하는 기능 Screen Capture Folder 스크린 캡쳐 이미지가 저장되는 폴더 위치를 설정 (YieldView 제외) Cp/Cpk Sampling Unit Cp/Cpk 값을 구할 때, 패드 단위, PCB 단위 또는 전체 패드의 평균을 이용하여 표준 편차 계산"
},
{
"toc_id": "chapter03_heading11_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Setup",
 "title2": "Display 탭",
 "body": "항목 설명 Customized Defect Color Defect 유형 별 표시 색상 설정 PCB List Type PCB List에 표시하거나 표시하지 않을 항목을 설정 Display Rotation 180 – Review Rear Lane에서 Review PC를 사용하여 작업하는 오퍼레이터를 위해, 모니터 화면의 PCB View를 180도 회전시켜 보여주는 기능"
},
{
"toc_id": "chapter03_heading12_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "RealTime",
 "title2": "",
 "body": "RealTime은 SPI 장비의 상태와 검사 결과를 실시간으로 확인하는 메뉴입니다. 이 메뉴는 다음 3가지 유형의 화면모드로 구성되어 있습니다. Real Time Chart Real Time 3D Real Time Multi ※ 참고: Realtime의 요소는 Setup에서 설정하십시오."
},
{
"toc_id": "chapter03_heading12_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "RealTime",
 "title2": "Real Time Chart",
 "body": "Real time chart는 통계 수치에 중점을 둔 Realtime 화면모드입니다. Real time chart 모드에 대한 상세한 사항은 다음을 참고하십시오. 검사 결과: 마지막으로 검사한 100개의 PCB의 검사 결과를 실시간으로 표시 녹색 블록: Good 하늘색 블록: Warning 빨간색 블록: NG(불량) 최근 검사 요소: 마지막으로 검사한 100개의 PCB에 대한 X-Bar Sigma chart를 표시 선택한 요소에 대한 결과 조회: CP &amp; CPK 왼쪽 창에서 원하는 요소를 선택한 후 OK 버튼을 클릭 Yield 차트: 최근 24시간 동안의 yield율을 표시 공정 능력 지수 차트: 마지막으로 검사한 100개의 PCB를 10개 단위로 하여, 공정 능력 지수 표시"
},
{
"toc_id": "chapter03_heading12_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "RealTime",
 "title2": "Real Time 3D",
 "body": "Real time 3D는 실시간으로 마지막 PCB의 검사 결과를 얻는 것에 중점을 둔 Realtime 화면모드입니다. Real time 3D에 대한 상세한 사항은 다음을 참고하십시오. 마지막 PCB 검사 결과: 장비에서 마지막으로 검사 완료한 PCB의 검사 결과를 표시 3D View: PCB에서 일정 부분을 선택하여, 매 검사마다 해당 부분의 검사 결과를 통합해서 3D로 표시 Rotation Check: 마지막으로 검사한 PCB의 휜 정도를 표시 옆의 배율을 큰 값으로 선택하면 Rotation이 실제보다 확대해서 조회 ※ 참고: Local상의 SPC Plus에서 3D Capture 창을 활성화하면, 검사 속도가 느려질 수도 있습니다."
},
{
"toc_id": "chapter03_heading12_sub03_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "RealTime",
 "title2": "Real Time Multi",
 "body": "Real Time Multi는 실시간으로 마지막 PCB의 검사 결과 중 6가지의 그룹이나 Component을 설정하여 계량형 차트(X Bar-S, X Bar–R, X Bar–MR 등)의 수치를 통해 공정관리상 이상이 있는 수치에 경보를 울리는 기능(Alarming 기능)을 사용하는데 중점을 둔 Realtime 화면모드입니다. 다음과 같이 3가지 용도의 차트가 있습니다. 한 가지 차트를 크게 보기 두 가지 차트를 크게 보기 6가지 차트를 동시에 보기 Alarming을 설정하면 공정상태의 이상 유무를 확인할 수 있습니다. ※ 참고: Real Time Multi를 사용하려면 Setup을 참고하십시오."
},
{
"toc_id": "chapter03_heading13_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Defect Review",
 "title2": "",
 "body": "Defect Review는 NG랙 혹은 Repair 컨베이어에 쌓여 있는 PCB의 상태를 확인하고, 해당 PCB를 수리할지 다음 장비로 이송할지를 결정하는 메뉴입니다. 버튼 창의 각 항목들에 대한 설명은 아래와 같습니다. 항목 설명 &lt;&lt; Previous, Next &gt;&gt; 이전 혹은 다음 defect로 이동 NG 해당 PCB를 불량으로 판정 Pass 해당 PCB를 양품으로 판정 Return 3D Inspector 프로그램으로 이동 PCB View (Review All Data) PCBView로 전환 ※ 참고: Defect Review에서는 불량 유형 당 50개까지의 defect를 리스트에 포함합니다. 모든 defect를 확인하려면, PCB View (Review All Data) 버튼을 클릭하십시오."
},
{
"toc_id": "chapter03_heading14_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Defect Analysis",
 "title2": "",
 "body": "Defect Analysis는 누적된 불량 항목에 대해 분석하는 기능으로서, 간단한 설정을 통해 SPC Plus 화면 상단의 메인 메뉴에 추가할 수 있습니다. Defect Analysis 메뉴는 아래와 같이 4 가지의 세부 메뉴로 구성하고 있습니다. Real Defect Trend View 누적 불량에 대한 경향 확인 viewer Defect Check Tool 불량 보드를 순차 적으로 분석 가능한 tool Defect Guide 불량 별 불량 처리 가이드 Before &amp; After Report Defect SPC의 그룹 비교를 한눈에 볼 수 있도록 출력되는 report 형식"
},
{
"toc_id": "chapter03_heading14_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Defect Analysis",
 "title2": "Defect Analysis Setting",
 "body": "Defect Analysis 기능을 SPC Plus에서 사용하기 위해서는, 프로그램에 메뉴를 설정하여 활성화시켜야 합니다. 본 기능을 활성화하는 방법은 아래와 같습니다. 우선, Defect Analysis 메뉴를 설정하려면 3D Inspector를 실행하기 전에 다음의 절차를 수행하십시오. KYConfig 대화상자에서 Defect Analysis 항목 및 경로를 선택하고, 저장할 PCB의 최대수량을 넣어 주십시오. SPC Config 대화상자를 활성화하여, 왼쪽 하단의 Defect Analysis 항목을 선택하고 경로를 지정해 주십시오. SPC Plus를 실행하면 상단 메인 메뉴에 Defect Analysis 메뉴가 추가된 것을 확인할 수 있습니다. 프로그램을 실행 중에, Defect Analysis 기능을 활성화하거나 비활성화하려면, 다음의 절차를 수행하십시오. 3D Inspector 세부 메뉴의 Setup 메뉴를 클릭하여, Zebra Basic Setup 대화상자를 활성화합니다. Basic 탭의 왼쪽 중반에 Defect Analysis 항목을 선택(또는 선택해제)하십시오. 3D Inspector의 파일 메뉴에서, 검사 수량 지정 메뉴를 선택하십시오. 생산수량 대화상자가 활성화되면, DA.Data Clear 항목을 선택하십시오. 위에서 설정한 변경내용을 적용합니다."
},
{
"toc_id": "chapter03_heading14_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Defect Analysis",
 "title2": "설정 완료 후 사용 방법",
 "body": "Defect Analysis 기능 설정 완료 후 3D Inspector을 실행하면, 오른쪽 하단에 Defect Analysis 메뉴가 생성됩니다. 불량 누적치를 아래 화면과 같이 차트로서 확인할 수 있으며, 차트 바 이외의 부분을 클릭하면 SPC Plus의 Real Defect Trend View와 연동됩니다. Real Defect Trend Tool Defect Analysis의 세부메뉴 중 Real Defect Trend Tool을 선택하면, 하기와 같이 각 보드의 불량 별 수량을 확인할 수 있습니다. Defect Check Tool Defect Analysis의 세부 메뉴 중 Defect Check Tool은 하기와 같은 역할을 합니다. Value trend의 Volume과 Volume 히스토그램으로 불량 데이터를 산출하고 인쇄의 전, 후로 구분함으로써, 발생된 불량의 위치 및 편차, 주기성, 인쇄 방향에 따른 발생 빈도 여부에 대하여 분석합니다. 발생된 불량의 누적 패드를 legend의 사용자 설정에 따라 인쇄 전후로 분석. Defect Guide Line Defect Analysis의 세부 메뉴 중 Defect Guide Line은 각 불량 분석에 대한 guide line을 제시하는 기능입니다. Before &amp; After Report Defect Analysis의 세부 메뉴 중 Before &amp; After Report는, 선택에 따른 개선 전후의 SPC값을 동시에 비교 분석하는 기능입니다."
},
{
"toc_id": "chapter03_heading15_KOR.html",
 "chapter_i": "3",
 "chapter": "SPC Plus 기능",
 "title": "Lot Search 기능",
 "title2": "",
 "body": "SPC Plus의 메인 메뉴 중 Search 메뉴 안의 Lot Search 항목을 클릭하면, 하기와 같이 Lot Search 대화상자가 활성화합니다. 이 메뉴는 lot별 혹은 JOB 파일 별로의 yield율 및 각 JOB 파일, lot별 혹은 패드별 누적 trend를 볼 수 있는 기능입니다. 이 메뉴는 아래와 같이 3 가지의 기능을 수행합니다. 각 lot 별 혹은 JOB 파일 별로 yield율을 계산하여 보여줍니다. 검사된 그룹 내의 각 패드별, defect 종류 별로 defect 수량을 확인할 수 있습니다. 2번에서 보여준 수량을 눈으로 확인 할 수 있는 defect 누적 trend를 확인할 수 있습니다."
},
{
"toc_id": "chapter04_KOR.html",
 "chapter_i": "4",
 "chapter": "부록",
 "title": "",
 "title2": "",
 "body": "CP 공정 능력 지수 CPK 치우침을 고려한 공정 능력 지수 Defect 결함이 있는 패드에 대한 ㈜고영테크놀러지의 총칭. 과납, 미납 뒤틀림, 브리지, 골드 탭, 형상, 높이로 나뉜다. Inspection Result 설명 과납 정해진 양보다 많은 양의 납이 발림 미납 정해진 양보다 적은 양의 납이 발림 뒤틀림 정해진 위치와는 다른 위치에 납이 발림 브리지 다른 패드와 납 혹은 다른 이물질로 이어져 있음 골드 탭 골드 탭 위에 이물질이 존재함 형상 정해진 모양과 다른 모양을 가짐 높이 납이 쌓인 높이가 일정치를 초과 혹은 미만임. LCL 관리 하한(Lower Control Limit) UCL 관리 상한(Upper Control Limit) PCB Status PCB의 검사 결과 Inspection Result 설명 Good 아무 문제도 없는 양품 PCB입니다 Warning 불량은 없으나 패드 중, 결과 값이 warning조건 내에 있는 패드가 존재하는 PCB 카운터 처리 시 및 yield율 체크 시, Good PCB로 처리됩니다. Pass 3D Inspector의 검사는 NG 판정이지만, 사용자에 의해 양품으로 변환된 PCB 카운터 처리 시에는 Pass로 적용되나 yield율을 낼 때는 Good으로 처리됩니다 NG 불량(Not Good)으로 처리된 PCB입니다. SPC 통계적 공정 관리(Statistical Process Control) SPI 납의 도포 상태를 확인하는 검사 장비(Solder Paste Inspection) Yield 율 PCB를 검사했을 때, Good PCB가 나오는 비율. 사용자의 설정에 따라 Good PCB와 Pass PCB의 수량을 합하여 계산될 수도 있음."
},
{
"toc_id": "Info.html",
 "chapter_i": "5",
 "chapter": "문서 정보",
 "title": "",
 "title2": "",
 "body": "User Guide SPC Plus Rev. 2.0 Copyright © 2022 Koh Young Technology Inc. All Rights Reserved."
},
{
"toc_id": "chapter00_heading01_KOR.html",
 "chapter_i": "5",
 "chapter": "문서 정보",
 "title": "저작권 및 면책조항",
 "title2": "",
 "body": "이 매뉴얼은 ㈜고영테크놀러지의 서면 승인 없이는 전체 또는 일부를 복사, 복제, 번역 또는 그 어떠한 전자매체나 기계가 읽을 수 있는 형태로 출판될 수 없습니다. 이 매뉴얼은 ㈜고영테크놀러지의 통제 하에 있지 않는 기타 업체로의 웹사이트 링크를 포함하고 있을 수도 있으며, ㈜고영테크놀러지는 링크된 그 어떠한 사이트에 대해서도 책임을 지지 않습니다. 또한, 출처를 미처 밝히지 못한 인용 자료들의 저작권은 원작자에게 있음을 밝힙니다. 혹시라도 있을 수 있는 오류나 누락에 대해 ㈜고영테크놀러지는 일체의 책임을 지지 않습니다. 제품의 버전이나 실행되는 형태에 따라 사진이 다를 수도 있습니다. 사양이나 사진은 매뉴얼 제작 시점의 최신 자료에 기초하고 있으나, 예고 없이 변경될 수도 있습니다."
},
{
"toc_id": "chapter00_heading02_KOR.html",
 "chapter_i": "5",
 "chapter": "문서 정보",
 "title": "개정 이력",
 "title2": "",
 "body": "개정 번호 날짜 설명 2.0 2022-10-01 문서 템플릿 변경 및 내용 일부 업데이트"
},
{
"toc_id": "chapter00_heading03_KOR.html",
 "chapter_i": "5",
 "chapter": "문서 정보",
 "title": "문서의 목적",
 "title2": "",
 "body": "본 문서는 고영테크놀러지의 SPC Plus 프로그램의 사용 방법에 대해 기술합니다."
},
{
"toc_id": "chapter00_heading04_KOR.html",
 "chapter_i": "5",
 "chapter": "문서 정보",
 "title": "용어/약어 설명",
 "title2": "",
 "body": "용어/약어 설명 N/A ﻿ ﻿ ﻿"
}
]