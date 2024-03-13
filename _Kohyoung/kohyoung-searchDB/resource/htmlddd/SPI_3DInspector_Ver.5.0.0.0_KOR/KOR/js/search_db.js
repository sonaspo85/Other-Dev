var search=[
{
"toc_id": "chapter01_KOR.html",
 "chapter_i": "1",
 "chapter": "3D Inspector 소개",
 "title": "",
 "title2": "",
 "body": "이 장에서는, 3D Inspector의 기능을 소개합니다. 3D Inspector는, PCB에 도포된 납의 형태를 3차원으로 검사하여 PCB의 양품/불량품을 판단하는 프로그램입니다. 3D Inspector는 CEditor 에 의해 입력된 JOB 파일(*.mdb)을 기반으로 PCB를 검사하며, 검사 결과를 SPC Plus를 통해 PCB의 납 상태 검사에 대한 통계 자료를 생성합니다. 따라서, 3D Inspector는 3차원 형상 데이터를 화면에 표시하여 반복적인 불량의 방지책을 마련할 수 있게 하는 프로그램입니다. 3D Inspector 의 주요 기능은 다음과 같습니다. PCB의 납 상태 검사 기능 PCB의 납 상태 결함에 따른 사용자 알림 기능 PCB의 납 상태 결함에 대한 결함 유형 판별 및 화면 표시 PCB의 검사 진행 상황에 대한 화면 표시 SPI 장비 설정 및 제어 기능 CEditor나 SPC Plus와 연동"
},
{
"toc_id": "chapter02_KOR.html",
 "chapter_i": "2",
 "chapter": "3D Inspector의 두 가지 모드",
 "title": "",
 "title2": "",
 "body": "이 장에서는 3D Inspector의 모드에 대해 설명합니다. 3D Inspector는 SPI 장비에 따라 다음과 같이 2가지 모드가 있습니다. Single Lane: single lane인 SPI 장비일 때 사용하는 모드 Dual Lane: dual lane인 SPI 장비일 때 사용하는 모드 2가지 모드는 대부분 유사하지만, 다음 화면일 경우에는 서로 다릅니다. PCB 검사를 진행하고 있을 때의 메인 화면 PCB 검사 결과가 나타날 때의 메인 화면 아래 그림은 3D Inspector 의 2가지 모드에 대한 메인 화면입니다. ※ 참고: 이 매뉴얼은 Single Lane 모드를 기준으로 하여 설명합니다."
},
{
"toc_id": "chapter03_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "",
 "title2": "",
 "body": "이 장에서는, 3D Inspector의 화면 구조에 대해 설명합니다. 3D Inspector의 화면은 아래와 같이 5가지로 구성됩니다. 메인 메뉴 세부 메뉴 메인 화면 검사 수행 도구 바 진행 상태 조회 창"
},
{
"toc_id": "chapter03_heading01_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 메뉴",
 "title2": "",
 "body": "메인 메뉴는 3D Inspector 에서 제공하는 모든 기능을 나열한 것으로, 3D Inspector 화면의 상단에 있습니다. 3D Inspector 의 메인 메뉴는 아래 그림과 같이 크게 6가지로 구성되어 있습니다. 생산(Production) 잡 생성(Job Creation) 통계(SPC) 설정(Setting) 즐겨찾기(Favorite) 도움말(Help)"
},
{
"toc_id": "chapter03_heading01_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 메뉴",
 "title2": "생산(Production)",
 "body": "생산(Production) 메뉴의 하위 세부 메뉴는 다음과 같습니다."
},
{
"toc_id": "chapter03_heading01_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 메뉴",
 "title2": "잡 생성(Job Creation)",
 "body": "잡 생성(Job Creation) 메뉴의 하위 세부 메뉴는 다음과 같습니다. 피두셜 메인 메뉴 중 JOB Creation의 Fiducial 메뉴를 선택하면, Fiducial Tool 창이 나타납니다. 이는 fiducial에 대한 세부 기능을 제어하는 대화상자이며, 보다 정밀한 fiducial 인식을 위한 teaching 기능을 수행합니다. Basic 탭 항목 설명 Fiducial LED Brightness Fiducial LED 밝기 조절 Fiducial Threshold Fiducial의 경계 값 설정 Fiducial ROI Fiducial의 검사 영역(ROI) 설정 Go to Fiducial 선택한 Fiducial의 위치로 이동 Fiducial Search Fiducial를 찾아 이동 Teaching ROI Fiducial의 검사 영역 Teaching를 통한 정확성 향상. Fiducial의 밝기값과 경계값, ROI 사이즈를 변경하려면 다음 순서대로 작업하십시오. SPI 장비의 Work Conveyor에 작업할 PCB가 있는지 확인합니다. PCB가 없다면 Work Conveyor에 작업할 PCB를 올려 놓으십시오. 기계 메뉴의 JOG를 클릭하십시오. 그러면 JOG 창이 나타납니다. Rail Up 버튼을 클릭하십시오. 도구 메뉴에서 Fiducial 도구 메뉴를 클릭하십시오. 그러면 위 그림과 같은, Fiducial Tool 창이 나타납니다. Array 번호나 A 또는 B를 선택한 후 Go to Fiducial 버튼을 클릭하십시오. 위 그림과 같이 자동으로 해당 fiducial 이미지가 나타납니다. Fiducial Upper LED Brightness이나 Fiducial Threshold의 값을 조정하여 fiducial를 선명하게 하십시오. 동시에 Fiducial ROI Size도 조정할 수 있습니다. Apply 버튼을 클릭하고 OK 버튼을 클릭하여 JOB 파일에 저장하십시오. Shape 탭 항목 설명 Shape Fiducial의 형상 정보 설정 w1, w2 특정 Fiducial의 크기 설정 십자가와 마름모 이외의 형상일 경우에는 w1, w2의 입력란이 비활성화 a1, a2 특수한 형태의 fiducial일 경우 입력란이 활성화 Test 선택한 fiducial이 올바르게 인식되는지 검사 Circle Outline Circle Fiducial의 외곽선 만으로 Score를 구하는 옵션 HASL Fiducial HASL처리된 PCB의 Fiducial을 검사할 때 사용하는 옵션 Fid. Accuracy Tool Gerber 파일 상의 두 피두셜 간격과 실제 이동한 거리의 Tolerance 설정 ※ 참고: 형상 정보 표기는 “???_???”로 표기되며, 앞의 “???”는 모양을 의미하며, 뒤의 “???”는 색을 의미합니다. (예: CIRCLE_WHITE: 하얀 원 모양 / CROSS_BLACK: 검은 십자가 모양) ※ 참고: KYConfig에 있는 Global Fiducial 항목이 선택된 경우, Shape 및 크기 설정을 무시합니다. Fid. Accuracy Tool 버튼을 클릭하여 실제 피두셜 간 거리의 Tolerance를 설정하려면, 아래와 같이 진행하십시오. Fid. Accuracy Tool 버튼을 클릭하면, 아래와 같이 Fiducial Accuracy Verification Tool 창이 나타납니다. 실제 두 피두셜 간 이동한 거리에 대한 Tolerance를 입력하고, Check Fiducial 버튼을 클릭하십시오. 아래와 같이 결과가 나타납니다. Fiducial Move 탭 Fiducial 좌표가 맞지 않을 경우에 사용하는 탭으로, fiducial의 위치 이동 및 재위치 설정, 저장, 자동 초기화 기능 등을 제공합니다. 항목 설명 Job Position 현재 fiducial의 위치로 이동 New Position 새로운 fiducial의 위치 설정 Apply 설정된 fiducial의 위치 저장 Zero Setting fiducial 설정 초기화 이 탭을 사용하려면, 다음 순서대로 작업하십시오. 도구 메뉴 또는 Fiducial 도구 메뉴를 클릭하십시오. 그러면, Fiducial Tool 창이 나타납니다. Go to Fiducial 버튼을 클릭하십시오. Job Position 버튼을 클릭하십시오. 그러면 JOG 대화상자를 활성화할 수 있습니다. JOG를 이용하여 Fiducial Tool 대화상자의 중앙에 위치한 Live Screen의 좌표 중심에 fiducial의 위치를 맞추십시오. Live Screen의 좌표 중심에 fiducial의 위치를 설정한 후, New Position 버튼을 클릭한 후 Apply 버튼을 클릭하십시오. OK 버튼을 클릭하십시오. Teaching 탭 이 탭은 해당 PCB의 fiducial이 아주 특이한 형상이어서 기본 Tool로는 인식이 불가능할 경우 사용합니다. Fiducial을 2D teaching를 통해 인식시킬 수 있는 기능입니다. ※ 참고: Fiducial Tool 대화상자의 Teaching 탭은 현재 동작하지 않습니다. ROI Move 탭 이 탭은 fiducial이나 PCB의 재질 또는 위치 문제로 fiducial을 중심으로 잡을 수 없는 경우 사용합니다. Fiducial을 찾는 지점을 중점이 아닌 지정 영역으로 이동하면, 반짝임 문제나 Limit를 넘어간 위치에 존재하는 문제점 등을 해결할 수 있습니다. 항목 설명 ROI View Fiducial의 ROI 표시 Auto ROI Move 자동으로 방향을 설정하여 ROI 이동 Zero Set Fiducial의 ROI 설정값 초기화 Apply 변경된 fiducial의 ROI 설정값을 선택한 fiducial에 적용 All Apply 변경된 fiducial의 ROI 설정값을 모든 fiducial에 적용 Add Fiducial 탭 이 탭에서는 피두셜을 추가할 수 있습니다. JOB 파일에 피두셜 정보가 없는 경우 이 탭에서 임시 피두셜을 지정할 수 있습니다. 항목 설명 Select REF. 레퍼런스 패드 선택 Move to Center 레퍼런스 패드를 화면 중심으로 이동 Set Position 레퍼런스 패드의 위치 지정 Move to Center 커서를 화면 중심으로 이동 Set Position 커서 위치지정 ADD Fiducial Fiducial 추가 PCB Jog PCB 이동 XY Jog 화면 이동 ※ 참고: Teaching 과정에 대한 더 자세한 설명은 본 문서의 Teaching 섹션을 참고하십시오. 카메라 이동최적화 해당 PCB에 대해 현재의 설정에 맞게 최적화된 카메라의 이동 경로를 재 연산하여 화면에 나타냅니다. X-Search 기능 X-Search 기능은 카메라의 이동 경로를 X축으로 최적화시키는 기능입니다. X-Search 기능을 실행하는 방법은 하기와 같습니다. KYConfig 대화상자에서 Search by X Axis 항목을 선택한 후, 3D Inspector를 실행하십시오. 파일 메뉴의 FOV Optimize 메뉴를 선택하여, Optimize Option 대화상자를 활성화하십시오. X first 항목을 선택하고 Set 버튼을 클릭하십시오. 카메라의 이동경로를 자동으로 X축 방향으로 Search합니다."
},
{
"toc_id": "chapter03_heading01_sub03_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 메뉴",
 "title2": "통계(SPC)",
 "body": "통계(SPC) 메뉴의 하위 세부 메뉴는 다음과 같습니다."
},
{
"toc_id": "chapter03_heading01_sub04_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 메뉴",
 "title2": "설정(Setting)",
 "body": "설정(Setting) 메뉴의 하위 세부 메뉴는 다음과 같습니다."
},
{
"toc_id": "chapter03_heading01_sub05_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 메뉴",
 "title2": "즐겨찾기(Favorite)",
 "body": "설정(Setting) 메뉴의 하위 세부 메뉴에는 Custom에서 사용자가 선택한 메뉴들이 표시됩니다."
},
{
"toc_id": "chapter03_heading01_sub06_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 메뉴",
 "title2": "도움말(Help)",
 "body": "도움말(Help) 메뉴의 하위 세부 메뉴는 다음과 같습니다. 통신로그(Comm.History) 이 절에서는 SPI 장비와 SPI 장비를 제어하는 PC간의 통신 정보를 조회하는 방법에 대해 설명합니다. 항목 설명 C 통신 데이터 감시 내용 삭제 R 통신 데이터 감시 내용 갱신 P 통신 데이터 감시 잠시 중지 Send 기계 제어가 제대로 수행하는지, 기계 제어의 명령어를 통해 확인 ※ 참고: 기계 제어의 명령어은 시스템 이상이 발생했을 때 이상 원인을 분석하기 위한 도구로, 이 매뉴얼에서는 제공하지 않습니다."
},
{
"toc_id": "chapter03_heading01_sub07_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 메뉴",
 "title2": "기타 메뉴",
 "body": "세부 메뉴 패널 우측에 위치하는 기타 메뉴는 다음과 같습니다."
},
{
"toc_id": "chapter03_heading02_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "검사 수행 도구 바",
 "title2": "",
 "body": "검사 수행 도구 바는, PCB 검사를 수행하기 위한 메뉴들로 구성되어 있습니다. 검사 수행 도구 바는 3D Inspector 메인 화면의 좌측 또는 우측에 위치하고 있습니다. 항목 설명 도구 바 위치 이동 (메인 화면의 왼쪽 또는 오른쪽) 시작(Start) PCB 검사를 시작 C.정지(CSTOP) 현재 검사중인 PCB를 검사 후 중지 정지(STOP) PCB 검사를 즉시 중지 초기화(RESET) PCB 검사 환경 초기화 Bypass 현재 PCB는 검사를 하지 않고 통과하게 함 PCB L/U PCB 검사 위치인 Work Conveyor에서의 PCB 이송 IN Work Conveyor를 검사 가능 상태로 되돌림 OUT Work Conveyor가 PCB를 빼낼 수 있게 모터 이동 이동(Jog) 수동으로 카메라를 특정 위치에 이동, Rail Up/Down 수행 NG L/U ﻿ ※ 참고 - 수동으로 검사를 진행하려면, 초기화를 클릭하여 초기화 작업을 먼저 수행해야 합니다. - 위 항목 중 C.정지와 정지는 중지 시점이 다릅니다. C.정지를 클릭하면, 즉시 검사를 중지하는 것이 아니라 현재 검사 중인 PCB는 검사를 완료한 후 작업을 중지합니다. - 위 항목 중 C.정지를 수행하면, 현재의 PCB의 검사를 완료한 후 다음 PCB는 검사를 하지 않습니다. - 위 항목 중 PCBL/U를 클릭하면, Work Conveyor에 PCB가 있다면 PCB를 Exit Conveyor로 이송합니다. Work Conveyor에 PCB가 없는 경우에는 Entry Conveyor에 있는 PCB를 Work Conveyor로 이송합니다. - 위 항목 중 OUT은 검사 중인 PCB를 직접 보아야 하거나, 테스트한 PCB를 빼내고 싶을 경우 사용하십시오."
},
{
"toc_id": "chapter03_heading03_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "SPI 장비 상태 표시 영역",
 "title2": "",
 "body": "SPI 장비 상태 표시 영역은, SPI 장비의 현재 상태 또는 사용자가 SPI 장비를 제어한 사항을 실시간으로 조회할 수 있게 돕는 기능입니다. 항목 설명 Idle SPI 장비에 전원만 켜진 상태로, 검사 전 대기 상태 Run 장비가 PCB를 현재 검사하고 있는 상태 BBT-Run Bare Board Data를 기준으로 PCB를 검사하고 있는 상태 Stop PCB 검사를 중단했거나 종료한 상태 Error 장비에 오류가 발생한 상태 Manual Run 수동으로 모터나 실린더를 작동시키고 있는 상태 Homing 장비를 초기화할 때, 장비의 모터가 원점(Origin)으로 이동하고 있는 상태 Home Check 장비가 homming 작업을 하기 직전 상태 Bypass 검사를 실행하지 않고 현재의 PCB를 곧장 다음 장비로 이송하고 있는 상태 Emergency 장비의 긴급 버튼을 눌렀거나 door가 열려 있는 상태 Optimize 장비의 반복성을 검사 중인 상태 Offline 장비의 내부 통신(TCP/IP)이 연결되지 않은 상태 ※ 참고: 위 항목 중 Manual Run은 주로 Manual Motion 기능을 가리키는 것으로, 장비를 수동으로 작동하는 상태임을 나타냅니다. ※ 참고: Manual Motion 기능은 장비가 Idle 상태일 때에만 가능합니다."
},
{
"toc_id": "chapter03_heading04_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 화면",
 "title2": "",
 "body": "메인 화면은 검사를 하는 해당 PCB의 정보를 표시하고 검사를 진행할 때 매 FOV 별 검사 진행 및 불량 표시 등 검사 진행 상황을 보여줍니다. 사용자는 메인 화면을 통해 PCB 검사 진행 상황을 즉각적으로 검토할 수 있습니다. 바코드 정보 JOB 파일 이름 / Pad 수량 현재 FOV Step / 총 Step ㄴ수 PCB 뷰어 옵션 PCB 뷰어 우클릭 메뉴"
},
{
"toc_id": "chapter03_heading04_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 화면",
 "title2": "바코드 수동 입력",
 "body": "메인 화면에서는 사용자가 바코드를 직접 입력하여 해당 PCB의 JOB 파일을 로드할 수 있습니다. 바코드를 직접 입력하려면 다음 순서대로 작업하십시오. 메인 화면에 있는 Barcode 버튼을 클릭하십시오. 그러면, Barcode 창이 나타납니다. Barcode 대화상자에 바코드를 입력하고 OK 버튼을 클릭하십시오."
},
{
"toc_id": "chapter03_heading04_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 화면",
 "title2": "JOB 파일 이름/패드 수량 조회",
 "body": "메인 화면에서는 현재 검사하고 있거나 앞으로 검사할 PCB에 해당되는 JOB 파일 이름과 패드의 수를 조회할 수 있습니다. ※ 참고: 화면에 나타나는 JOB 파일 이름은 그 파일의 이름이 아니라 CEditor의 PCB Info에 있는 파일 이름입니다."
},
{
"toc_id": "chapter03_heading04_sub03_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 화면",
 "title2": "현재 FOV Step/총 Step 수",
 "body": "메인 화면에서 검사하고 있는 PCB의 현재 단계(FOV의 Step) 및 PCB의 총 단계(FOV의 Step) 수를 표시합니다."
},
{
"toc_id": "chapter03_heading04_sub04_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 화면",
 "title2": "PCB 뷰어 옵션",
 "body": "PCB 뷰어 옵션은 메인 화면의 우측에 위치합니다. 항목 설명 패드 선택 PCB View 확대 PCB view 크기 복원 마우스 이용해서 스크린 이동 Bird eye view로 변환 Trend view 활성화 2D &amp; 3D view 활성화 Job Edit Mode 활성화 Pad 검색창 활성화 PCB Setting’s Comment 입력창 활성화"
},
{
"toc_id": "chapter03_heading04_sub05_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 화면",
 "title2": "PCB 뷰어 우클릭 메뉴",
 "body": "이 메뉴는 PCB 뷰어 화면에서 마우스 오른쪽 버튼을 클릭했을 때 나타나는 메뉴입니다. 항목 설명 3D View 해당 Pad의 3D View 창 활성화 Pad Tolerance Tolerance Setting 창 활성화 Pad Inspection Condition Inspection Condition 창 활성화 Add Pad 해당 Pad 추가 Delete Pad 해당 Pad 삭제 Unused 해당 Pad 사용 안 함 Edit Mask Pad mask editor 창 활성화 Edit Mask Edit Pad Mask는 검사되는 Pad 중 검사를 원하지 않는 부분을 제외시킬 때 사용하는 기능입니다. Edit Pad Mask 기능을 사용하려면, 다음 순서대로 작업하십시오. PCB 뷰어에서 마우스 오른쪽 버튼을 클릭하고, Edit Mask를 선택하십시오. Pad mask editor 창이 나타나면, 검사에서 제외하고자 하는 영역을 드레그하여 선택하십시오. 검사 후, Defect View에서 해당 Pad 검사 결과를 확인하면, 선택한 영역이 제외되었음을 확인 할 수 있습니다. 2D &amp; 3D Viewer에서도, 선택한 영역이 제외되었음을 확인할 수 있습니다."
},
{
"toc_id": "chapter03_heading04_sub06_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "메인 화면",
 "title2": "Background Image",
 "body": "Background Image는 PCB 뷰어에서 PCB 이미지를 단순한 흑백 이미지가 아닌 실제 컬러 이미지로 스캔하여 보여주는 기능을 활용한 여러 가지 옵션을 말합니다. Background Image는 아래와 같이 크게 세 가지 옵션으로 나눌 수 있습니다. Real Color Image Pre-Scan Image Full-Scan Optimize Real Color Image Real Color Image는 보드 검사 시 PCB 뷰어의 이미지를 실제 컬러로 보여줌으로써 사용자의 직관성을 높이는 기능입니다. Real Color Image를 적용하려면, 다음 순서대로 작업하십시오. 검사 설정(Inspection Setting) 메뉴로 가십시오. 환경설정(Inspection Options) 메뉴에서 조명 옵션(Light Option)을 선택하십시오. 'RGB LED' 항목을 선택하십시오. 보안(Engineer) 메뉴의 검사스타일(Inspection Style)에서, 'PCB Real Color Image' 항목에 체크하십시오. 검사 중 FOV 화면 및 검사 완료화면에서 보드이미지 전체가 컬러로 나오는지 확인하십시오. Pre-Scan Image Pre-Scan Image는, 검사 전에 보드를 스캔하여 실제 컬러 이미지로 보여줌으로써, 사용자가 검사 결과의 불량 패턴을 파악하는데 도움을 주는 기능입니다. Pre-Scan Image 기능을 적용하려면, 다음 순서대로 작업하십시오. 검사 설정(Inspection Setting) 메뉴로 가십시오. 환경설정(Inspection Options) 메뉴에서 조명 옵션(Light Option)을 선택하십시오. 'RGB LED' 항목을 선택하십시오. 보안(Engineer) 메뉴의 검사스타일(Inspection Style)에서, 'Use Pre Scan Image' 항목에 체크하고, Image Scan Tool 버튼을 클릭하십시오. Image Scan 창이 나타나면, Start Scan 버튼을 클릭하십시오. 스캔한 FOV가 컬러로 표시됩니다. Image Scan 창을 종료한 후, 메인 화면의 PCB 뷰어에서 PCB가 컬러로 나오는 것을 확인하십시오. 'Use Pre Scan Image' 항목을 선택 해제하면, PCB 이미지가 다시 흑백으로 표시됩니다. Full-Scan Optimize Full-Scan Optimize는, 보드 검사 시 FOV Optimize 순서가 아닌 PCB 전체를 스캔하고, 실시간으로 모든 FOV에 컬러를 적용하는 기능입니다. Full-Scan Optimize 기능을 적용하려면, 다음 순서대로 작업하십시오. 먼저, KYConfig의 ECT Setup 대화상자에서 'Use Full Scan Fov Optimize' 항목에 체크하십시오. CEditor의 FOV Optimize 메뉴에서 Re-Optimize 버튼을 클릭한 후, SET 버튼을 누르십시오. FOV Optimize 창 하단의 PCB Margin을 조절하여 PCB의 불필요한 여백을 제거하여 FOV 수를 최적화합니다. &lt;PCB Margin값 적용 전&gt; &lt;PCB Margin값 적용 후&gt; PCB 검사 시, 아래 이미지와 같이 전체 PCB가 스캔되어 실시간으로 모든 FOV에 컬러가 적용되는 것을 확인할 수 있습니다. &lt;Full-Scan Optimize 적용 전&gt; &lt;Full-Scan Optimize 적용 후&gt;"
},
{
"toc_id": "chapter03_heading05_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "불량정보(Defect View)",
 "title2": "",
 "body": "검사가 끝나면, 불량정보 탭이 메인 화면에 나타나며 PCB에 도포된 납 상태를 3D 이미지로 보여줍니다."
},
{
"toc_id": "chapter03_heading05_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "불량정보(Defect View)",
 "title2": "불량 이미지 및 패드 확인",
 "body": "불량 이미지 목록 및 패드 확인 창은 메인 화면 하단에 위치하고 있습니다."
},
{
"toc_id": "chapter03_heading06_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "상세정보(Detail View)",
 "title2": "",
 "body": "Defect View 탭에서 돋보기 모양 아이콘()을 클릭하면 Detail View 탭이 메인 화면에 나타납니다. Detail View 탭에서는 더 상세한 이미지 및 검사 결과를 확인할 수 있습니다."
},
{
"toc_id": "chapter03_heading07_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "진행 상태 조회 창",
 "title2": "",
 "body": "진행 상태 조회 창은 현재 검사 상황을 보여주며, 3D Inspector 화면의 우측과 화면 하단에 위치하고 있습니다. 아래의 진행 상태 조회 창 그림 및 설명을 참고하십시오. ※ 참고: 계획수량을 설정하면, 설정한 수량만큼 검사한 후 장비가 자동으로 멈추게 할 수 있습니다. ※ 참고: 위 항목 중 PASS는 PCB 검사에서 NG로 판정한 PCB를 Operator가 확인한 후 양품으로 수동 판정한 PCB들의 집합입니다. 히스토그램 히스토그램은 다음과 같이 3가지 모드로 나뉩니다. Histogram mode: PCB 검사 결과에 대한 납 도포 상태를 다각적인 분석(해당 PCB의 각 패드들에 대한 납 분포(체적, X축, Y축, 높이, 영역))을 통해 시간대 별로 분포도를 나타냅니다. 이로써, 향후 발생할 또는 발생한 PCB 검사의 PCB 불량(Defect)을 예측하거나 발생 원인을 파악할 수 있습니다. ※ 참고: 시간대 별로 보여지는 히스토그램의 그래프는 최대 80개까지 볼 수 있습니다. Defect mode: 시간대별로 PCB검사 결과에 의해 발생한 불량(defect)들의 백분율을 유형별로 표시한 것으로, 어떤 유형의 불량이 많이 발생했는지를 표시한 것입니다. Yield mode: 시간대 별로 생산률을 표시하여 특정 시간의 GOOD, NG, PASS 비율을 보다 빠르게 파악할 수 있습니다. PCB State mode Pad Trend mode"
},
{
"toc_id": "chapter03_heading07_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "진행 상태 조회 창",
 "title2": "PCB 검사 결과 별 GUI 히스토그램 표시",
 "body": "히스토그램을 PCB 검사 결과(NG, Good)에 따라 선택적으로 표시할 수 있습니다. 이 옵션을 적용하려면, GUI 히스토그램 표시 영역을 더블 클릭하십시오. 듀얼 레인의 경우에는, 히스토그램 영역을 한번만 클릭하십시오. &lt;Single Lane&gt; &lt;Dual Lane&gt; 히스토그램 설정 창이 나타나면, ‘Select Histogram Type by PCB Result’ 옵션을 설정하십시오. ALL: GOOD, NG PCB 모두 히스토그램 표시 (Default) GOOD: GOOD PCB만 히스토그램 표시 NG: NG PCB만 히스토그램 표시 적용 결과 ‘ALL’ ‘GOOD’ ‘NG’"
},
{
"toc_id": "chapter03_heading07_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "진행 상태 조회 창",
 "title2": "스퀴지 방향 설정",
 "body": "스퀴지(Squeegee) 방향을 조회하거나 설정할 수 있는 항목입니다. 항목 설명 Init. Printing 생산 초기에, Printer 최적화 등을 위해 검사 결과를 저장하지 않고자 할 때 사용하는 옵션 Change 스퀴지 방향을 수동으로 변경. 이 버튼을 클릭하면, Front to Rear 또는 Rear to Front로 스퀴지 방향이 변경됨. Edit Stencil ID와 Stencil Count를 수정할 수 있는 Input Production Quantity 창 열기 Delete 현재까지 누적된 스퀴지 Count 초기화 Stencil ID 현재 선택된 Stencil ID를 보여줍니다. Count 현재까지 생산된 PCB 수량 / 설정한 Stencil Count Limit 표시 ※ Input Production Quantity 창에서 Use Alarm에 체크하면, 설정한 Stencil Count Limit 값까지 PCB를 생산합니다. Init. Printing 생산 초기에, Printer 최적화 등을 위해 검사 결과를 저장하지 않고자 할 때 사용하는 옵션"
},
{
"toc_id": "chapter03_heading07_sub03_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "진행 상태 조회 창",
 "title2": "Dual Lane 장비 히스토그램 창에 스텐실 사용 횟수 표시",
 "body": "Dual Lane 장비를 사용하는 경우에도 히스토그램 영역 옆에 스퀴지 방향 및 스텐실 사용횟수를 확인할 수 있습니다. SPIGUI 상단 메뉴 바에서 Histogram 메뉴를 클릭하십시오. 아래와 같이 레인 별 스퀴지 방향 및 스텐실 사용 횟수를 확인할 수 있습니다. Edit 버튼을 클릭하면 Input Production Quantity 창이 나타나고, 여기에서 스텐실 정보를 수정할 수 있습니다."
},
{
"toc_id": "chapter03_heading07_sub04_KOR.html",
 "chapter_i": "3",
 "chapter": "3D Inspector 화면 구조",
 "title": "진행 상태 조회 창",
 "title2": "듀얼 레인 히스토그램 창에 스퀴지 사용 횟수 표시",
 "body": "듀얼 레인의 스퀴지 사용 횟수를 히스토그램 창이 아닌 생산수량 창에서 확인해야 했으나, 듀얼 레인 히스토그램 창에서 스퀴지 사용횟수를 확인할 수 있습니다. ※ 참고: 히스토그램 창에 스퀴지 사용 횟수를 표시하려면, KYConfig &gt; Use Server Squeegee 및 Printer Information Check 항목이 설정되어 있어야 합니다."
},
{
"toc_id": "chapter04_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "",
 "title2": "",
 "body": "이 장에서는 3D Inspector를 사용하여 보드 검사를 위해 설정할 수 있는 설정 항목들에 대해 설명합니다. 검사 설정 사용자 설정 비전 설정 보드 설정"
},
{
"toc_id": "chapter04_heading01_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "검사 설정",
 "title2": "",
 "body": "메인 메뉴 &gt; 설정 &gt; 검사 설정을 클릭하면 아래와 같은 설정 창이 나타납니다."
},
{
"toc_id": "chapter04_heading01_sub01_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "검사 설정",
 "title2": "환경설정 - 검사옵션",
 "body": "No. 항목 설명 1 Inspection Style Default BBT (Bare Board Teaching): Multi Vendor BBT를 사용할 경우 Vendor 인식 에러가 발생한다면 기본 BBT값으로 설정하여 사용 Fov Bridge check: FOV와 FOV 사이에 발생한 Bridge 불량 검사 Use Teaching Mode: Teaching Mode 사용 BBT Type BBT( Bare Board Teaching): 검사한 패드의 평균높이를 이용하여 정확한 체적을 구하는 방법 Limit[um] H: 최대 높이의 제한을 두어 적용(설정 값 이상이면 설정 값으로 조정) - L: 최소 높이의 제한을 두어 검사(설정 값 이하면 설정 값으로 조정) Large Pad No: 해당 기능 사용하지 않음 - Yes: 패드의 크기가 큰 경우에 BBT를 적용하지 않음 X [um]: 패드의 X 방향 적용 제한 값 설정 Y [um]: 패드의 Y 방향 적용 제한 값 설정 - PBBT(Pattern Bare Board Teaching): 패드 주위의 패턴의 높이가 패드 영역보다 높은 형상의 보드이거나 HALS보드이면서 Fine Pitch QFP인 경우 사용 Pattern Max[um]: 패턴의 최고 높이 설정 - GBBT(Geometry Bare Board Teaching): ROI내의 Bare Board의 형상(Geometry) 정보를 저장하고, 검사할 때 이 형상을 고려하여 정확한 체적을 구하는 방법 2 Customized Warning SPC Alarming: SPC Alarming setting 창 활성화 Configurable Stop: Configurable Stop setting 창 활성화 Block Tolerance: Block Tolerance setting 창 활성화 3 Warpage Option Z-Axis Tracking: Z-Axis Tracking 기능 사용 Pad Referencing: Pad Referencing 기능 사용 4 Printer Cleansing PrinterSignal On/Off: 같은 타입의 불량이 설정된 개수 이상 발생 시 Printer로 ‘Cleansing’ 신호를 전송하는 기능 5 Warning Message Warn Job File without Bare Board Data: 베어보드 데이터가 없으면 경고 메시지 띄움 Use Squeegee Direction Warning Message: 스퀴지 방향이 다를 때 경고 메시지 띄움 6 Master Sample Validation 하루 중 특정 시간을 설정하여, 해당 시간이 되면 마스터 샘플을 검사하라는 알람 메시지를 나타내도록 하는 기능 Teaching Mode 'Use Teaching Mode' 항목을 선택하면, 불량이 검출되었을 때 1차적으로 Defect View 에서 NG/PASS를 판정하고, 2차 판정으로 Defect Review 대화상자를 연결하여 더욱 정확한 결과 판정을 할 수 있습니다. PCB 검사 중 불량이 발생하면, Defect View 화면이 나타납니다. 불량 내용을 확인한 후, 1차 판정을 합니다. Defect View 화면에서 NG 버튼을 클릭하면, 2차 판정을 위해 SPC Plus의 Defect Review 화면이 나타납니다. Defect View 화면에서 PASS 버튼을 클릭하면, PCB가 버퍼로 빠지는 것을 확인할 수 있습니다. ※ 참고: Teaching Mode를 사용하기 위해서는, 먼저 KYConfig의 Option 패널에서 'Outside Racks'와 'Timer', 'Defect Queue' 항목을 설정해야 합니다. SPC Alarming SPC Alarming 메뉴는 생산조건에서 전체 PCB 혹은 원하는 특정 부품에 대해 품질변동이 생겨서 이상이 발생했을 경우 경고해 주는 기능을 제공합니다. No. 항목 설명 1 Use SPC Alarm SPC 알람 기능 사용여부 설정 2 Group Name ALL, 혹은 Edit PCB 나 CEditor™ 에서 설정된 그룹 이름 표시 그룹을 설정하면 원하는 패드에 대해서만 SPC Alarming 기능 사용 3 ADD Defect Type에 선택된 관리도 조건을 이용해서 검사항목 추가 4 Defect Type SPC 알람 검사 조건 선택 - x-Rs 관리도: Volume, Height, Offset X, Offset Y에 대해 설정 P 관리도: Volume, Bridging, All Defect 불량에 대해 설정 5 Sample Lot Size 마지막 검사한 결과에서부터 설정 수량만큼을 이용해서 값을 산출 6 Make Alarm for Out of Control 측정값이 LCL, UCL을 벗어나면, 장비 작동을 멈추고 경고음 발생 경고음 발생과 더불어 아래와 같은 경고 대화상자 활성화 7 CLEAR 선택한 그래프의 측정값들을 초기화 ※ 참고: SPC Alarming 기능에서 설정한 정보들은 JOB 파일 단위로 관리되므로, JOB 파일을 변경하면 해당 JOB 파일에 적합하도록 다시 설정해 주십시오. 설정하지 않은 다른 JOB 파일을 로드하면 작업 중이던 설정 데이터는 저장되지 않습니다. ※ X-Rs 관리도 X 관리도와 Rs(인접한 두 측정값의 차) 관리도를 이용하여 공정률 불량 판단의 기준을 설정하는 관리도를 의미합니다. 관련 공식은 아래와 같습니다. - 용어 설명: LCL à 관리하한 (Lower Control Limit), UCL à 관리 상한 (Upper Control Limit) ※ P 관리도 불량 계수형태의 품질 특정치를 사용하여 작성되는 관리도를 의미합니다. 관련 공식은 아래와 같습니다. - 용어 설명: LCL à 관리하한 (Lower Control Limit), UCL à 관리 상한 (Upper Control Limit) Configurable Stop 이 기능은 불량이 발생했을 때 선택된 특정 상황이 아닌 경우에는 장비 작동을 멈추지 않는 조건을 입력하는 기능입니다. Configurable Stop 기능을 사용하려면, Configurable Stop 화면 왼쪽 상단에 Use Configurable Stop 항목에 체크하십시오. Criteria에 속한 항목에 대해서는 다음 표를 참고하십시오. No. 항목 설명 1 Max number of continuous defects 같은 패드에 대해 불량 판정이 연속적으로 설정한 횟수 이상 발생하면, 장비를 멈춤 2 Max number of defects for the last 10 times 현재로부터 마지막 10번의 검사 결과 중 설정한 횟수 이상 불량이 발생하면, 장비를 멈춤 3 Max total number of defects in Last 마지막 검사한 PCB의 불량이 설정한 개수 이상이면, 장비를 멈춤 4 Max number of defect types 마지막 검사한 PCB에 대해 리스트에서 선택한 불량이 설정한 개수 이상 발생하면, 장비를 멈춤 Option에 속한 항목에 대해서는 다음 표를 참고하십시오. No. 항목 설명 1 Use NG 불량 판정이 발생한 PCB를 불량 처리할지 여부를 결정하는 옵션으로 설정이 되어 있는 경우는 조건에 해당이 되지 않더라도 불량 보드인 경우는 불량으로 처리 (NG 버퍼와 사용하는 경우 NG가 발생해도 장비가 멈추지 않으므로 선택된 특정 조건에 대해서 장비를 세우고 싶은 경우 사용할 수 있음) 2 Include Warning Defect Count 시에 불량뿐 만 아니라 Warning Pad에 대해서도 처리 (단, Max number of defect on one part number 와 Max number of defects on one reference Designator 조건에 대해서는 해당되지 않음) 3 Block Defect View Defect View 창 비활성화 Fatal Value 항목에서는 장비를 동작하게 하는 범위를 설정합니다. 이 항목에서 설정한 범위를 벗어나면, 장비가 멈춥니다. Block Tolerance 항목에서는 Volume이나 Height, Offset에 대해 조건을 설정하고, 설정된 값 안에 에러가 난 패드가 포함 되어 있으면 자동 PASS 합니다. Block Tolerance Block Tolerance는 특정 부품에서 불량이 발생하면, Defect View 또는 Defect Review 에서 PASS로 처리하지 못하도록 제한하는 기능입니다. 또한, 불량 유형에 따라 Pad Good 버튼 활성 여부를 설정할 수 있습니다. 이 기능을 사용하려면, Block Tolerance 설정 창 상단의 Block Tolerance 항목에 체크하십시오. 위 작업을 마치면, 해당 component에 불량이 발생했을 때, Defect View 창의 Pass 버튼이 비활성화됩니다. 항목 설명 Per Job Block Tolerance 설정을 JOB 파일에 저장 ※ 이 옵션을 선택하지 않으면, Block Tolerance 기능이 장비 단위로 설정됩니다. Block Tolerance Block Button Target PCB Pass, Pad Good 버튼 비활성화 여부 설정 Master Sample Validation 하루 중 특정 시간을 설정하여, 해당 시간이 되면 마스터 샘플을 검사하라는 알람 메시지를 나타내도록 하는 기능입니다. 장비 상태에 따라, 설정된 알림 메시지가 팝업합니다. Machine Status Messages Idle 즉시 알림 메시지 팝업 Bypass, Run + PCB가 장비 안에 있는 경우 현재 보드 배출 후, 장비를 Idle 상태로 변경하고 알림 메시지 팝업 Bypass, Run + PCB가 장비 안에 없는 경우 즉시 장비를 Idle 상태로 변경하고 알림 메시지 팝업 Idle, Bypass, Run상태가 아닌 경우 장비 상태를 예외 상황(Ex. Error, Stop) 등으로 판단하여 장비가 Idle 상태로 변경되면, 알림 메시지 팝업 사용 방법 SPIGUI &gt; Setting &gt; Inspection Options &gt; Inspection Options로 이동하십시오. Master Sample Validation옵션에 체크하고, 시간 및 알람 메시지 문구를 설정하십시오. 해당 시간이 되면, 설정한 문구대로 Master Sample을 검사하라는 메시지가 팝업합니다."
},
{
"toc_id": "chapter04_heading01_sub02_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "검사 설정",
 "title2": "환경설정–디스플레이",
 "body": "No. 항목 설명 1 UI Graph Display Pad Yield: Yield graph를 패드 기준으로 보여줌 Panel Yield: Yield graph를 패널 기준으로 보여줌 Use OffsetHisto.: 큰 PCB의 경우 Offset Histogram을 사용하지 않음 2 Inspection Result Display Defect View에서 검사 결과에 대한 NG, PASS 버튼 다국어 설정 3 Export Unit um &amp; mm: um &amp; mm 단위 사용 mil &amp; inch: mil &amp; inch 단위 사용 4 Offset Histogram Unit mm &amp; inch: mm &amp; inch 단위 사용 um &amp; mil: um &amp; mil 단위 사용 5 Use FormMsg 경고/에러 메시지를 큰 창으로 보여줌 6 Use Defect pad ‘X’ Mark 불량이 발생한 패드에 ‘X’ 표시 7 Defect Set WFF(Worst First Failure): 이 항목을 선택하면, 동일한 종류의 Defect 를 가진 Pad 중 불량 정도가 가장 심한 Pad를 Defect Viewer (Defect Review) 상에서 먼저 보여 줍니다. 이 항목의 선택 상자 8개를 이용하여 Defect View에서 보여지는 불량 타입 (Insufficient, Excessive, Offset X &amp;Y, Bridge, Height high, Height low, Area large Area small)의 우선 순위를 설정할 수 있습니다. 모든 항목을 “1”로 설정할 경우, 불량 타입과 관계없이 불량 정도가 가장 심한 Pad를 먼저 보여줍니다. Customized User Set Display: Defect View에서 Defect 표시 순서를 사용자가 설정 Auto Defect Display: Defect View에서 Defect가 많이 발생한 순서대로 자동 표시됨"
},
{
"toc_id": "chapter04_heading01_sub03_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "검사 설정",
 "title2": "환경설정–조명옵션",
 "body": "No. 항목 설명 1 FIducial Brightness Fiducial의 Threshold와 밝기 설정 Use 2D&amp; 3D: 2D 조명으로 Fiducial 인식 실패 시, 3D조명을 이용하여 검사 2 Projection Brightness 검사 조명의 밝기 설정 Apply: 모든 조명에 일괄 적용 3 RGB LED RGB 조명의 밝기 설정 4 IR Brightness IR 조명의 밝기 설정 PMCW (PCB Measurement Condition Wizard) 실제 생산되는 PCB는 색과 반사 정도가 다양하여, 검사되는 PCB에 알맞게 조명 밝기 조절이 필요합니다. PMCW(PCB Measurement Condition Wizard)는 해당 PCB에 맞춰 자동으로 밝기를 최적화하는 기능입니다. 이 기능을 사용하려면, 다음 순서대로 작업하십시오. KYConfig의 창에서 'Use PMCW' 항목에 체크하십시오. 검사 시작 전 생산 수량 창이 나타나면 'PCB Brightness Calibration'에 체크하십시오. 검사를 시작하면, 특정 FOV로 이동하여 Brightness Calibration을 시작합니다. 아래와 같은 화면이 나타나면서 Score를 확인할 수 있습니다. 환경설정 메뉴의 조명옵션 메뉴에서 RGB값이 해당 PCB에 맞춰 최적화되었음을 확인하십시오."
},
{
"toc_id": "chapter04_heading01_sub04_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "검사 설정",
 "title2": "환경설정–고급기능",
 "body": "No. 항목 설명 1 ROI Extend Pixel 패드 검사 시, 추가로 검사하는 패드 외 영역의 기준 설정 패드 사이즈가 400um 이상, 이하에 따라 Small, Large로 구분됨 2 Auto Scale per board PCB가 들어올 때마다 모든 Scale factor를 측정 3 Multivendor Gray [5-200] Multi Vendor의 Gray 값을 5에서 200 사이에서 설정 4 Bad Mark Gray [5-200] Bad Mark의 Gray 값을 5에서 200 사이에서 설정 ﻿ Offset Coordinate 옵셋 정도를 측정할 경우, 원점 기준을 패드 중심에서 패드 외곽 라인으로 옮겨야 하는데, 이 때 사용하는 항목입니다. X + Y -: 원점 좌표를 좌측 상단을 기본으로 하여 틀어짐 표시 X + Y +: 원점 좌표를 좌측 하단을 기본으로 하여 틀어짐 표시 X – Y –: 원점 좌표를 우측 상단을 기본으로 하여 틀어짐 표시 X – Y +: 원점 좌표를 우측 하단을 기본으로 하여 틀어짐 표시 Outline Offset: 패드영역과 도포된 납의 외각 끝들을 기준으로 틀어짐 정도를 계산하려면 이 항목을 선택 ﻿ Inspection Style Step Skip: 홀수 FOV step (또는 짝수 FOV step)만을 번갈아가며 검사 Coplanarity Area / Volume: Coplanarity area 검사로 설정되어 있는 경우, Volume 검사로 변경 Coplanarity volume 검사로 설정되어 있는 경우, Area 검사로 변경 3 Bucket: 검사 시, 이미지를 3개만 찍도록 설정"
},
{
"toc_id": "chapter04_heading01_sub05_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "검사 설정",
 "title2": "환경설정–Work Group Setting",
 "body": "No. 항목 설명 1 Work Group Setting 작업그룹 별 수율 설정"
},
{
"toc_id": "chapter04_heading01_sub06_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "검사 설정",
 "title2": "데이터/내보내기 -저장",
 "body": "No. 항목 설명 1 Result data Test mode(No data Saving): 결과 데이터 저장 안함 Auto delete data files per: 일정 기간 경과 후 데이터를 자동 삭제 Auto delete image files per: 일정 기간 경과 후 이미지를 자동 삭제 Data Save Option: 저장 옵션 중 하나를 선택 2 3D Save option Save All Pad: 모든 패드를 3D Image로 저장 (단, 본 기능을 선택하면 하드디스크의 용량이 바로 가득 찰 수 있으므로 하드디스크의 용량을 사전에 확인하기 바랍니다. 이 경우, FOV 단위로 저장하므로 3D 파일은 생성되지 않습니다.) Do Not Save: 3D Image를 저장하지 않음 Save All Failed Pads: 모든 불량에 대해서 3D Image로 저장 Failed Pads Of ( ): PCB당 지정된 개수만큼만 불량 이미지를 저장 Group: 그룹으로 지정한 것을 3D Image로 저장 Group&amp;Fail: 그룹으로 지정한 것과 불량 이미지를 모두 저장 Include Warning: 경고를 포함한 3D Image 저장 Set Point: SPC Plus™의 Real Time 기능에 대한 3D 사용 여부 설정 3 SQL Save SQL 서버에 데이터 저장할 때, 저장 옵션 설정 4 Optimize Condition Make PadSpec: Gage R&amp;R 데이터 출력"
},
{
"toc_id": "chapter04_heading01_sub07_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "검사 설정",
 "title2": "데이터/내보내기- 내보내기",
 "body": "No. 항목 설명 1 Use Auto Export 하나의 PCB 검사가 끝날 때마다, 결과를 txt 형식의 파일로 자동 생성합니다. 2 PCB Information Header: 결과 데이터의 header를 Bad Mark 또는 Summary Info로 설정 Avg&amp;Sig Export: 지정한 폴더에 Average와 Sigma값 저장 3 Filename As Barcode Date Plus Barcode FileName: 파일명을 바코드와 날짜로 생성 Barcode FileName: 파일명을 바코드명과 동일하게 생성 4 Export Format &amp; Item With Header Print: 출력 파일에 header 추가 Text: *.txt 형식으로 파일을 출력 Excel(CSV): *.csv 형식으로 파일을 출력 File Name Format: 내보내는 파일 이름 형식 설정 5 Group Export Use Group Data in Job File: Job 파일에서 선택된 그룹에 대해 Export 기능 제공"
},
{
"toc_id": "chapter04_heading01_sub08_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "검사 설정",
 "title2": "바코드- 바코드",
 "body": "No. 항목 설명 1 Inspection Style Pre Barcode: 바코드가 읽힐 때까지 PCB가 입력단계에서 대기 No Pass Barcode: 바코드를 읽지 못하면, Error 대화상자 활성화 Reset Barcode: Reset를 클릭하면, 바코드 정보 삭제 Use Inline Array Mode: Array PCB에서 각 array별로 바코드가 부착이 되어 있을 경우에 사용 (이러한 경우에는 몇 개의 바코드가 부착이 되어 있는지 숫자 입력) Use Master Barcode for Multi Panel: Array PCB가 한 개의 바코드만 가지고 있을 때, 개개의 array별로 바코드를 할당할 수 있음 Printer Selection: 어떤 프린터의 SMEMA 신호를 인식할지 선택 2 Filtering Option Ignore: 등록된 문자열이 바코드에 포함이 되어 있으면, 그 바코드 자체를 무시 (한 PCB에 읽을 필요 없는 여러 종류의 바코드가 있을 경우 사용 Ex) ACB가 설정이 *되어 있고, 바코드가 12ABC45인 경우, 읽지 않습니다. Cut: 등록된 문자열이 나타날 경우, 그 문자열을 바코드에서 삭제 Ex) ABC가 설정이 되어 있고, 바코드가 12ABC45일 경우, 장비에서는 1245로 받아들입니다. Barcode Filter: 바코드의 필요한 부분만 설정하여 사용 3 Option Barcode: Reverse array: 바코드 인식 순서를 반대로 설정 - ( ) No of Barcode: 한 PCB 당 읽는 바코드 개수 설정 - Check Same Barcode in ( ) days: 설정한 기간 내에 동일한 바코드를 사용하여 검사된 PCB가 있을 경우 알림창 팝업 Barcode – Must have list: 이 리스트에 등록된 특정 글자가 포함된 바코드는 무시 Barcode Filter 기능 Barcode FIlter 버튼을 클릭하면, 아래와 같이 'Barcode Filter' 설정화면이 나타납니다. No. 항목 설명 1 Use barcode filter by job file Barcode Filter에 대한 설정을 JOB 파일에 저장 2 If forward starting position is fixed Barcode 문자열의 첫번째 문자에서 시작하여 Filter 적용 Set Position: 첫번째 문자로 인식할 위치 설정 (왼쪽 끝이 1) Set Length: 인식할 Barcode의 길이 설정 3 If backward starting position is fixed Barcode 문자열의 마지막 문자에서 시작하여 Filter 적용 Set Position: 첫번째 문자로 인식할 위치 설정(오른쪽 끝이 1) Set Length: 인식할 Barcode의 길이 설정 4 If specified starting character is fixed 특정 문자열에서부터 Barcode로 인식할 수 있게 Filter 적용 Set Character: Filter 기능 적용할 특정 문자열 설정 Set Length: 인식할 Barcode의 길이 설정 Set Array Sequence 기능 Array의 바코드에서 들어오는 Inline Barcode 순서를 설정할 수 있는 기능으로, 이 기능을 사용하려면 아래의 순서대로 작업하십시오. KYConfig를 실행하고, 하단의 Barcode 버튼을 클릭하십시오. Basic 탭에서 'Inline Barcode' 항목을 선택한 후 Apply 버튼을 누르십시오. 3D Inspector&gt;Setting&gt;Inpsector&gt;Barcode 탭에서 'Use Inline Array Mode' 항목을 선택하십시오. 바코드가 포함된 Panel의 수를 입력하십시오. 'Set Array Sequence' 항목을 선택하십시오. Set 버튼을 클릭하고, 아래와 같이 바코드 인식 순서를 설정하십시오. 검사가 끝나고 SPC Plus에서 바코드가 설정한 순서대로 변경되었는지 확인할 수 있습니다. Barcode 수량 Increase/Decrease 옵션 Master Barcode를 읽은 후 설정된 수량만큼 바코드를 Increase/Decrease 시키는 기능으로, 이 기능을 사용하려면 아래의 순서대로 작업하십시오. KYConfig의 Barcode 메뉴에서 'Use Display All Array Barcode' 항목을 선택하십시오. 'Master Array Option' 메뉴에서 'Increase' 또는 'Decrease'를 선택하십시오. KYConfig의 Barcode 메뉴 탭에서 'Use Prebarcode Array Mode' 항목을 선택하고 Array 수량 기입하십시오. 'Use Master Barcode for Multi Panel' 항목을 선택하십시오. 검사가 끝난 후 SPC Plus &gt; PCB View&gt; PCB Information에서 바코드 정보를 확인할 수 있습니다."
},
{
"toc_id": "chapter04_heading01_sub09_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "검사 설정",
 "title2": "보안-검사스타일",
 "body": "No. 항목 설명 1 All Good 모든 결과를 Good으로 보여줌 2 Fiducial Skip Fiducial 검사 생략 여부 설정 3 Auto Job Change Inspect End 자동 Job Change 옵션 설정 4 Tab Hold 메인 화면의 Fiducial, Conveyor, Offset 탭 중 마지막으로 선택한 탭 고정 5 PCB Real Color Image PCB Real Color 이미지 기능 사용 6 Use Pre San Image Pre-Scan Image 기능 사용 7 Use FM Viewer 이물 검사 Viewer 사용 여부 8 PZT Average Use Check: PZT의 이상 동작 확인 Init PZT: PZT 강제 초기화 [ ]: PZT 이미지 score 값의 오차 허용 범위 9 Dual Projection Dual Projection 장비일 경우 선택 10 Pad Optimize 마지막 검사 결과를 이용하여 패드 별로 Tolerance 자동 설정 11 Debug Mode SW 엔지니어가 문제점 분석을 위해 로그를 남긴 경우, 디버깅 로그 출력 On/Off를 위한 옵션 12 Image Scan Tool Pre-Scan Image를 위한 도구 열기"
},
{
"toc_id": "chapter04_heading02_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "사용자 설정",
 "title2": "",
 "body": "사용자 권한 생성 및 삭제 등 사용자 권한을 수행하기 위한 사용자 선택 대화상자를 활성화합니다. ※ 참고: 이에 대한 자세한 설명은 사용자 권한 설정 및 변경 섹션을 참고하십시오."
},
{
"toc_id": "chapter04_heading03_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "비젼설정 (Vision Parameter)",
 "title2": "",
 "body": "Vision Parameter 설정 창에서는 정확한 검사를 위해 시험을 통한 여러 결과 값을 영상 매개 변수로 설정하여 검사의 정밀도를 높일 수 있습니다."
},
{
"toc_id": "chapter04_heading03_sub01_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "비젼설정 (Vision Parameter)",
 "title2": "SYSTEM 탭",
 "body": "No. 항목 설명 ① Probe Information Projection: 사용자의 장비에 맞는 광학계 설정을 선택합니다. Single: 3030-F model(초기 모델)일 경우 선택 Dual: Dual Projection 장비일 경우 선택 Rotation: 특수 사양(VAL+ model)이며 Rotation head일 경우 선택 Step: Step Zoom 장비일 경우 선택 Quad: Quad Projection 장비일 경우 선택 ※ 주의: 초기 설정을 변경하지 마십시오. Grating Direction: 장비에 설치된 격자의 각도를 설정할 수 있는 항목입니다. 주사된 격자의 각도 설정, 뒤에 sine 문구가 있을 경우 sine 격자이고, 그렇지 않을 경우 Square 격자입니다. ※ 주의: 초기 설정을 변경하지 마십시오. ② Engineer Setting Result: 검사 결과의 저장 방식에 대해 설정하는 항목입니다. No: GRR Tool에서 사용할 검사 결과를 저장하지 않아도 되는 경우 선택 Result: GRR Tool에서 사용할 검사 결과를 저장해야 하는 경우 선택 저장 파일 이름: Result.txt 저장 경로: C:/Kohyoung/KY-3030/Vision 폴더 Debug: 오류 수정용 파일이 필요할 경우 선택 저장 경로: C:/Kohyoung/KY-3030/Vision/Debug 폴더 ※ 주의: ‘Result.txt’ 파일은 검사 결과가 나올 때마다 파일 내에 내용이 추가가 됩니다. 다른 board의 검사 또는 새롭게 Data를 얻고자 할 때는 해당 파일을 지우고 다시 생성해야 합니다. Process: 검사에 사용할 Projection을 선택 Left: Left Projection 영상을 이용하여 부피나 면적, 높이 등을 계산할 경우 선택 Right: Right Projection 영상을 이용하여 부피나 면적, 높이 등을 계산할 경우 선택 Dual: Left와 Right, 두 개의 Projection 영상을 이용하여 부피나 면적, 높이 등을 계산할 경우 선택 Left2: Left2 Projection 영상을 이용하여 부피나 면적, 높이 등을 계산할 경우 선택 Right2: Right2 Projection 은 영상을 이용하여 부피나 면적, 높이 등을 계산할 경우 선택 Dual2: Left2와 Right2, 두 개의 Projection 영상을 이용하여 부피나 면적, 높이 등을 계산할 경우 선택 Quad: Left, Right, Left2, Right2, 4 개의 Projection 영상을 이용하여 부피나 면적, 높이 등을 계산할 경우 선택 Height Th. for FOV Proc.: 검사 대상의 높이를 측정하기 위한 기준 바닥면(Base plane)의 높이를 설정합니다. 설정한 높이(10, 15, 20, 25, 30, 35, 40, 45, 50, 45, 60um)의 영역을 기준으로 Volume, Height, Area, Offset 등의 측정치를 산출합니다. ※ 주의: 권장하는 기본 설정 값은 40um 이며, 일반적으로 스텐실 높이의 1/3 정도로 설정합니다. 특수한 경우 40um 이외의 값을 사용하며, 설정된 Height Threshold 값에 따라 SPI 에서 측정하는 Height 결과 값이 달라지므로 세심한 주의가 필요합니다. Use acceleration processing: 3D 복원이나 이물검사를 위한 GPU 사용 여부 설정 Full: GPU를 이용하여 FOV 전체를 3D 복원하여 SPI 검사 고속화 Half: GPU를 이용하여 3D 복원에 필요한 일부 데이터를 생성하여 SPI 검사 고속화 ※ 참고: GPU가 사용가능한 경우에만 Full, Half 옵션이 활성화됩니다. [Hidden] Use Region Map: GPU를 이용한 3D 복원을 할 경우에 Pad Mask 정보 사용 [Hidden] No Inspect: SPI 검사를 위한 Image Grab만 수행하고 실제 Solder 검사를 위한 3D 복원이나 데이터 처리는 하지 않음. [Hidden] Span For Del.: C:\\Kohyoung\\KY-3030\\Vision 폴더에 지속적으로 저장되는 처리 데이터나 디버그 로그 등을 설정한 기간을 주기로 삭제 ③ Height Display Height: 대표 높이를 구하는 방법 선택 H=V/A(default): 부피를 면적으로 나누어 납이 도포된 평균 높이를 구하는 방법 Range(%): Height 정보의 신뢰성을 위해, Low/High % 설정 높이 차가 40um 이하일 경우, Low값을 40um 이상이 되도록 자동 조정 Range(%) Detail: 검출된 Solder Area를 기준으로 설정한 범위 내의 평균 높이를 표시 ex) 10%와 50%로 설정한 경우 붉은 색 구간이 평균 높이가 됨 Peak2Peak: 검사영역에서 높이들의 히스토그램을 이용하여 기준영역에서 최고로 많은 높이 부분과 납이 도포된 영역에서 최고로 많은 높이부분간의 거리 차이를 높이로 계산 Display Under Th.: 설정한 Height threshold값 이하의 높이를 계산해 표시하려면 이 항목을 선택 ④ Engineer Save Image: 검사 시 사용되는 이미지의 저장여부를 설정하는 항목 No: 별도의 파일로 저장하지 않을 경우 선택(기본 설정) Defect: 불량이 발생한 FOV의 영상을 저장하고 싶을 경우 선택 (C:\\Kohyoung\\KY-3030\\Vision\\Image 폴더) All: Fiducial 및 검사 Image를 저장하고 싶을 경우 선택 (C:\\Kohyoung\\KY-3030\\Vision\\image 폴더) [Hidden] Check No: 일반 검사 시 선택(Default) PZT: User Manual Inspection 모드에서만 사용되며, focus와 PZT 이송량 등을 화면에 표시하여 광학계 설정과 PZT의 상태 확인할 때 사용 MultiPhase: 다파장 프로브일 경우, 다파장의 적용 상태 (파장, 균일도) 확인 시 사용 [Hidden] Remove Extra Remove: 3D 형상에서 패드 주변의 이웃 solder를 표시하지 않음. Display: 3D 형상에서 패드 주변의 이웃 solder를 모두 표시 Gathering Debug Images: 특정 결함에 대한 디버그 이미지를 “C:\\Kohyoung\\KY-3030\\Vision\\Debug\\OLD\x22에 저장합니다. Use: True로 설정 시 Defect type에 따라 디버그 이미지를 저장하고, False 설정 시에는 저장하지 않음. Defect type - All defects: 모든 불량에 대한 디버그 이미지 저장 Defect type - 그 외: 선택한 불량에 대한 디버그 이미지 저장"
},
{
"toc_id": "chapter04_heading03_sub02_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "비젼설정 (Vision Parameter)",
 "title2": "Condition1 탭",
 "body": "No. 항목 설명 ① Bridge option Method: 브릿지 검출 방법 선택 3D Only: 3D 검사 정보만 이용한 브릿지 검출 2D Only: 2D RGB 검사 정보만 이용한 브릿지 검출 3D and 2D: 3D와 2D RGB 모두에서 발견된 브릿지만 검츨 3D or 2D: 3D와 2D RGB 중 한 곳에서라도 발견된 브릿지 검출 Iter. 2D Alg.: 2D Only 브릿지 검사에서 가성 불량 검출을 개선한 기능 Remove Silk: 설정한 Gray값 이상은 Silk로 간주하여 측정 시 제외 ※ 참고: Method로 3D Only를 선택한 경우 기본 설정 값은 ‘150’이며, 그 외에는 기본 설정 값이 ‘230’입니다. Find Hair Gray: 설정한 Gray값 이하이면, 납으로 간주하여 브릿지로 검출 (머리카락과 같이 어두운 물질의 브릿지 검출할 때 사용). Calc. Solder Dist.: 실제 브릿지 불량이 아니지만 브릿지 가능성이 있는 경우, 두 Solder 간의 거리를 측정 FOV Bridge Ignore Cam. Margin: 이 옵션을 선택 시, FOV Margin을 무시하고 브릿지 검사 수행 Ex) Ignore Cam. Margin옵션을 선택해제 한 경우, 아래 그림의 2번과 3번 사이의 브릿지가 검사되지 않습니다. Ignore Cam. Margin옵션을 선택한 경우에는, 2번과 3번 사이의 Bridge 검사가 진행됩니다. ② Slope ROI 또는 FOV 기준의 기울기 보상을 적용합니다. Compen.: ROI 기준으로, 기울기를 보상할 대상 패드 선택 No: 기울기 보상을 하지 않음 ALL: 모든 패드에 대해 기울기 보상을 함 Over Size: 아래 설정된 크기이상의 패드에 대해서만 기울기 보상 실시 X [um]: 패드의 X 방향 크기 제한 값 설정 Y [um]: 패드의 Y 방향 크기 제한 값 설정 FOV: FOV를 기준으로 기울기 보상 적용 Method: 기울기 보상 방법 선택 (기본값: Non Solder) Outside: ROI 가장자리의 데이터를 이용해 기울기 보상 Height Th.: 설정된 Height TH. 보다 낮은 데이터를 이용해 기울기 보상 Base: ROI 내에서 Base로 찾아진 영역을 이용해 기울기 보상 ROI: 기능 사용 안 함 Whole ROI: Solder를 포함한 ROI 내의 모든 정보 사용하여 기울기 보상 Non Solder: Solder 이외의 영역의 데이터를 이용해 기울기 보상. 기울기 보상 후, 기본 높이도 보상함. Ignore Solder Mask: 이 옵션을 선택 시, Slope 보상에서 Solder Mask를 사용하지 않습니다. Refine Base Height: 이 옵션을 선택 시, Slope 보상을 수행한 후에 Base Alignment를 다시 수행합니다. ※ 참고: Ignore Solder Mask와 Refine Base Height 옵션은, 패널이 심하게 들뜬 경우 Slope 보상은 정상적으로 동작하지만, 3D 영상 전체가 들뜨는 문제가 발생할 때 사용하면 효과적입니다. ③ Polygon ROI Polygon ROI 적용 시, 검사에서 제외되는 Pad 영역의 기준을 설정합니다. Skip: Pad 사각 영역 대비 실제 Pad 영역이 설정 값 이상이면 Polygon ROI 검사 대상에서 제외 ※ 주의: JOB 파일에서 Polygon ROI 검사 설정이 되어 있어야 합니다. Option: Pad Type: Polygon ROI를 적용할 Pad 유형 선택 Extra Pad Remove &amp; Base: CAD 정보를 벗어난 영역의 Volume 처리 방식과 Base Align 방식 선택 Hard: CAD 정보를 벗어난 영역을 강제 삭제. Base는 CAD 주변 정보로 다시 정렬 ※ 주의: Hard 옵션 선택 시, 해당 Pad는 브릿지 검사가 불가능합니다. Normal: CAD 정보를 벗어난 영역 중 패드와 동떨어져 있는 영역의 Volume을 삭제, Base는 CAD 주변 정보로 다시 정렬 Only Remove: CAD 정보를 벗어난 영역 중 패드와 동떨어져 있는 영역의 Volume을 삭제, Base는 기존 유지 ④ Z-Tracking Limit of Offset Dist(um): 가상 높이 측정 위치가 평균 높이 대비 범위를 벗어나면 검사 제외 Select height position on FOV: 각 FOV에서 대표되는 다파장 높이를 Z-Tracking에 사용. CEN: FOV 중앙 높이를 Z-Tracking에 사용, Tracking은 다소 떨어지지만 안정적임 (경사가 급격하지 않은 PCB에 사용) OUT: FOV 외곽 높이를 Z-Tracking에 사용, Tracking은 좋지만 안정성이 다소 떨어짐 (경사가 급격한 PCB에 사용) [Hidden] ROI Realign: Z-Tracking 시, ROI 재정렬 여부 설정 Realign Cal. Reference: Z-Tracking 안정성을 위해, PCB 검사 초기에 Reference Phase 정렬 FOV Valid Region(%): 다파장을 구하는 영역을 줄여 안정적으로 Z-Tracking에 필요한 높이를 구할 때 사용하는 항목으로, Z-Tracking에 이용되는 FOV 영역(Width, Height) 설정 Ex) Width: 80% (2000 pixel일 경우 1600 pixel내에서 구함), Height: 70% (2048 pixel일 경우 1433 pixel 내에서 구함) ﻿ [Hidden] Bridge Inspection Min. Width[um]: 브릿지의 최소 폭이 설정값보다 작으면 브릿지가 아닌 것으로 판단 ROI Width: 두 패드간 설정값 이하인 첫 번째 위치를 브릿지의 시작 위치로 판단 FOV Bridge: Bridge Option에서 Ignore Cam. Margin을 선택한 경우의 상세 옵션 Min. Margin: 브릿지 검사를 수행할 최소한의 FOV Margin 값을 Pixel 단위로 입력 Check Direction: 두 패드 간의 ROI 내에서의 방향성을 기반으로 브릿지 불량을 판단할지 여부 결정 2D Saturation threshold: 브릿지 검사 Method으로 ‘2D’ 사용 시, Saturation Image 로부터 Solder Map을 생성하기 위한 Threshold 값 설정. Threshold 값이 낮을수록, 더 많은 Solder를 찾음. Morphology onto SolderMap: ‘True’로 설정 시, Solder Mask를 축소 후 확장하는 과정을 통해 작은 노이즈들을 제거 (Default: True) Auto Th. For SolderMap to Mask: ‘True’로 설정 시, Solder Mask 생성을 위한 Threshold 값을 Otsu Threshold Method로 자동으로 찾아서 설정 (Default: True) Threshold for SolderMap to Mask: Solder Mask 생성을 위한 Threshold 값을 설정. Auto Th. For SolderMap to Mask를 ‘True’로 설정 한 경우, 이 옵션은 적용되지 않음. (Default: 150) Dilation num: 브릿지 검사 Method로 ‘2D’ 사용시, Solder Mask크기를 확장하는 횟수 설정 Iter. 2D Alg. Initial Threshold: 브릿지 검사 Method으로 ‘Iter. 2D Alg.’ 사용 시, Saturation Image 로부터 Solder의 가시성 향상을 위한 반복 알고리즘에 사용할 초기 Threshold 값 설정. Threshold 값이 낮을수록, 더 많은 Solder를 찾음. (Default: -0.17) Threshold for Solder Mask: 브릿지 검사 Method으로 ‘Iter. 2D Alg.’ 사용 시, 최종적인 Solder Mask 생성을 위한 Threshold 값 설정. Threshold 값이 낮을수록, 더 많은 Solder를 찾음. (Default: 0.43) ※ 참고: 위 두 설정 값은 다양한 종류의 보드들의 실험을 통해 결정된 값으로, Default 값으로 사용하기를 권장합니다. ⑤ ETC ROI Move: ROI Move 기능의 사용 방법 설정 No: 해당 기능 사용하지 않음 ALL: FOV내의 모든 도포된 납의 평균 틀어짐 값으로 도포된 납이 ROI의 중앙에 오도록 ROI 이동 Auto: 검사영역에 도포된 납이 걸쳐있을 경우 중앙에 오게 ROI 이동 Epoxy height method: 패드가 Epoxy Type인 경우에 적용되는 Height 측정 방식 Default: System 탭의 Height Display에 설정된 방식으로 측정 Max: 0~5% 영역의 평균 높이로 측정 Panel Roi Compensation: ‘True’로 설정 시, Panel ROI의 Offset을 측정해서 Panel 내의 모든 Pad ROI 위치 보상 ※ 참고: 이 기능 적용시 Pad Offset 측정 정확성 향상을 기대할 수 있습니다. [Hidden]Hole Ball Inspection: Ball 주위에 있는 Mold를 기준으로 Ball의 높이를 구함 Mold Height[um]: Mold 기준(400[㎛])으로 ball의 top까지의 거리 측정 Ex) Mold의 높이 400[㎛]를 입력: Mold를 기준으로 Hole의 높이 140[㎛] ⑥ Pad Referencing PCB Warp 등으로 인하여 불규칙적(Nonlinear)인 Shrinkage &amp; Expansion 이 발생 시, 주변 Feature들을 이용하여 X, Y Offset 을 보상하는 기능입니다. Compensation Method: 보상하기 위한 방식 선택 Affine: 보상 정도가 다소 약하지만, Feature 수가 적은 경우에도 안정적인 성능 보장 Projective: 보상 정도가 가장 높으나 충분한 Feature가 필요 NO: 보상 기능 사용 안 함. Feature Detection Condition: Feature 선택 조건 설정 Score: Feature 검출 정확도 설정 (Min: 0.8, Max: 1.0) Offset Limit(Pixel): 검출한 Feature 위치가 설정 값 이상 차이 나면 해당 Feature 제외 ⑦ Bad Mark Pad Bad Mark: Pad Bad Mark 사용 시 검출력에 적합한 기본 영상 선택 Select Image: Pad Bad Mark 검출에 사용된 기본 영상 선택 Save Image: Bad Mark 검사 시 사용한 이미지를 'C:\\KohYoung\\KY-3030\\Vision\\Debug\\PadBadMark' 위치에 저장 (디버깅 모드) ﻿ [Hidden] Surface Inspection Solder/Glue 표면 검사에 적용할 옵션들을 설정합니다. RANSAC Iteration Num: RANSAC 알고리즘을 이용한 평면 근사(Plane Fitting) 반복 횟수 Neighborhood threshold: 설정한 값(pixel) 이내의 검색 영역에서 블랍 연결성(Blob Connection) 검출 3D: 높이(Height) 값으로 평명 근사(Plane Fitting) 및 블랍 연결성(Blob Connection) 검출 Ransac Range: RANSAC Plane Fitting시 Inlier 범위 Double threshold parameter: 이진화 Map (Blob Connection 검출에 사용)을 생성하기 위한 Low Threshold와 High Threshold간의 차이 Initial blob removal size threshold: 총 Blob 개수에서 제외하고자 하는 작은 Blob의 최소 크기 설정 2D: RGB 평균 값으로 평명 근사(Plane Fitting) 및 블랍 연결성(Blob Connection) Ransac Range: RANSAC Plane Fitting시 Inlier 범위 Double threshold parameter: 이진화 Map (Blob Connection 검출에 사용)을 생성하기 위한 Low Threshold와 High Threshold간의 차이 Initial blob removal size threshold: 총 Blob 개수에서 제외하고자 하는 작은 Blob의 크기 설정 Flatness Inspection Area Peak inspection target area: Peak Inspection에 사용될 검사 영역 설정 Consider margin: Top Margin을 고려하여 RANSAC 알고리즘으로 찾은 사각형 마스크 Top area: Height Threshold Mask Fitting Rect: RANSAC 알고리즘으로 찾은 사각형 마스크 Hole inspection target area: Hole Inspection에 사용될 검사 영역 설정 Consider margin: Top Margin을 고려하여 RANSAC 알고리즘으로 찾은 사각형 마스크 Top area: Height Threshold Mask Fitting Rect: RANSAC 알고리즘으로 찾은 사각형 마스크 Scratch inspection target area: Scratch Inspection에 사용될 검사 영역 설정 Consider margin: Top Margin을 고려하여 RANSAC 알고리즘으로 찾은 사각형 마스크 Top area: Height Threshold Mask Fitting Rect: RANSAC 알고리즘으로 찾은 사각형 마스크 ⑧ Bare Board Teaching GBBT: ROI 내의 Bare Board형상(Geometry)을 고려하여 정확한 Volume을 구하는 방법입니다. ※ 참고: 휨(Warp) 등으로 인하여 ROI에 오프셋(Offset)이 발생 할 경우, 이 옵션을 사용할 수 없습니다. 이 경우 Pad Referencing/Z Tracking 옵션을 먼저 적용하여 GBBT 적용 가능여부를 판단하십시오. GBBT 옵션을 적용한 후에도 ROI Offset 이 큰 경우에는 GBBT 대신 BBT 옵션을 적용하는 것을 권장합니다. Size of skip sampling: GBBT 적용 시, 설정한 값이 패드 크기보다 작은 경우에만 샘플링(Sampling) 진행 Show Original 3D map: GBBT 적용하여 Solder 3D map을 표현 시 원래 형상으로 보이게 하거나, 바닥의 기하 패턴을 제거한 실제 측정에 사용된 Real solder의 모양을 보일지 결정 ⑨ Co-Planarity 컴포넌트의 Co-planarity 측정 방법을 설정합니다. Value: Co-planarity 사용 여부 및 불량 판단 기준 선택 No: 사용하지 않음 Height: 높이로 co-planarity 판단 Volume: 볼륨으로 co-planarity 판단 Error First: Multi Error 발생 시 Co-planarity 가 불량의 최 우선 순위로 설정 [Hidden]Consider Base Warp: Co-Planarity Value의 표기 방식 설정 True: Base Warp를 고려한 Co-planarity Height의 Offset 값으로 Co-Planarity Value 표기 False: Vision Parameter 설정 기준에 따른 Height 또는 Volume의 실측 값으로 Co-Planarity Value 표기 [Hidden]Group Average Height: Component의 평균값을 기준으로 설정한 범위에서 벗어나면 불량으로 판단 Upper[mil]: Max값 설정 Lower[mil]: Min값 설정 ※ 주의: 이 기능을 사용하기 전에 CEditor를 이용하여 JOB 파일에서 컴포넌트 단위로 Co-planarity Tolerance를 설정해야 합니다. ⑩ Foreign Material Manual Threshold Use: True로 설정 시 사용자가 입력한 Threshold를 적용할 수 있도록 합니다. Value: 사용할 Threshold 값을 입력합니다. ⑪ Offset Measurement Outline Offset Method - Normal: 패드를 벗어난 납의 높이를 기준으로 외곽 Offset 계산 Outline Offset Normal 계산 방식 Method - Boundary Line: 패드를 벗어난 납의 평균 높이를 기준으로 외곽 Offset 계산 ※ 참고: Normal 알고리즘 적용 시 패드를 벗어난 납을 검출하지 못 하는 경우, Boundary Line 알고리즘을 사용하면 효과를 기대할 수 있습니다. Outline Offset Boundary Line 계산 방식 ⑫ Height Measurement Height-TH Offset: 5um 이하의 Height Threshold를 Job 단위로 적용합니다. ※ 참고: Height Threshold는 Pad별 검사속성에서 설정할 수 있으나, 5um 이상의 높이로는 설정할 수 없습니다. 이 기능은 5um 이하의 Height Threshold 설정이 필요한 경우에 사용합니다. ※ 참고: 최종적인 Height Threshold 값은 Pad별 검사 속성의 Threshold 값 + Height-TH Offset 값으로 결정됩니다. ⑬ Shape Inspection Disconnected Solder Shape 검사 관련 옵션을 설정합니다. ※ 주의: 이 기능은 기존 Shape 검사 기능에 추가된 검사속성으로, 적용할 Pad Tolerance에 Shape 검사 속성이 체크되어 있어야 합니다. Blob Dis. [um]: 유효한 솔더 덩어리의 갯수 (blob 갯수) Valid Solder [pix]: 유효한 솔더 덩어리끼리의 거리 (설정 값 이상이면 Defect 판정)"
},
{
"toc_id": "chapter04_heading03_sub03_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "비젼설정 (Vision Parameter)",
 "title2": "Condition2 탭",
 "body": "No. 항목 설명 ① Remove Noise Solder 주변의 Hole 또는 Jig로부터 발생하는 노이즈를 제거하는 기능입니다. VIA Hole: VIA Hole 타입 Pad에 한해 노이즈 제거 Remove from Phase Mod: Modulation 이미지 Top: 2D Top 이미지 Avr: 3D Average 이미지 Vis: Visibility 이미지 Remove from 2D: Phase 분석을 통한 노이즈 제거가 어려운 경우, 2D 이미지에서 추가 노이즈 처리 Base align off: 기존 Base 측정 방법을 유지 Remove Noise Extra Piece: Pad 영역 밖에 있는 Solder가 아닌 3D 형상 제거 Jig or HASL: VIA Hole 타입의 Pad를 제외한 다른 Pad들의 노이즈 제거 Use Phase difference(%): 각 Channel 별 Phase 차가 설정된 % 이상일 경우 노이즈로 인식하여 제거 Remove Noise Phase from: 선택한 데이터 기준으로 위상에서 노이즈 처리 SpreadNoise: 이중 반사 등에 의해 발생하는Phase 번짐 노이즈 제거 DilationNum: Spread Noise Mask 크기를 확장하는 횟수로, 횟수를 증가 시키면 Noise의 주변부까지 확장하여 제거 Small Noise Ignore: True로 설정 시, ROI 내에 3 pixel이하로 존재하는 작은 노이즈 제거 (Default: False) Remove extra solder from outer pad: Pad 영역에 연결된 Solder를 제외한 외곽의 3D 형상 제거 [Hidden]Hard: Height threshold–5를 기준으로 Object가 연결되어 있지 않을 경우 삭제 [Hidden]Normal: Height threshold를 기준으로 Object가 연결되어 있지 않을 경우 삭제 [Hidden]Weak: Height threshold+5를 기준으로 Object가 연결되어 있지 않을 경우 삭제 Remove base noise: 카메라 노이즈로 인해 Base 영역을 잘 못 잡는 경우 사용 (Default: None) None: 옵션 적용 안 함. Peak th.: Solder로 인식된 노이즈가 3개 이상인 경우, Base Phase에서 제외 Min Base: Solder로 인식된 노이즈가 1개 이상인 경우, Base Phase에서 제외 ② Segmentation RGB Height: Segmentation 후 Solder Mask 내에서 측정되는 Solder Height Threshold RGB Base: Segmentation 후 Base Mask 내에서 측정되는 Base Height Threshold Set Extend Offset: RGB Height를 ‘40um’, RGB Base를 ‘0um’으로 설정 ※ 참고: 가성 불량(False Call)이 발생하는 경우, 이 기능을 적용해보는 것을 권장합니다. Set release Default: RGB Height를 ‘18um’, RGB Base를 ‘-5um’으로 설정 (Default) ③ Multi Phase Use Color Mask by RGB: Multi Phase 사용 시, 색상을 사용하여 Base Mask를 생성하고 채널들 간 Base 높이를 정렬합니다. ※ 주의: 검은색 보드를 검사할 때는, 이 기능을 사용하지 마십시오. Threshold: ‘Use Color Mask by RGB’ 사용 시, Base Mask를 생성하기 위한 Threshold 값 설정 Base Depth: 각 채널 별 Base 위치를 정렬할 때, Average Base로부터 설정한 +-Base Depth(um) 를 벗어나는 경우 Base Mask에서 제외함. ④ Base Align [Hidden]Base Ratio: 특수 PCB의 경우 KY SPI 의 측정 범위 (Measurement Range) 를 벗어나 높이가 잘못 표시될 수 있습니다. 이 경우, Base Plane의 높이를 조정하여 KY SPI 의 측정 범위 (Measurement Range)를 이동하고, 도포된 Solder 의 높이를 정상적으로 계산합니다. 0.5(default): -150 ~ 450[um] 0.1: -30 ~ 570[um] 1: -300 ~ 300[um] ※ 주의: 본 기능은 전체 PCB에 일괄 적용 되며, 설정에 따라 측정 값이 달라질 수 있으므로 주의하십시오. [Hidden]Height Offset[um]: 3D Map 전체 영역 평균 높이에 설정된 값을 증감하여 검사 [Hidden]Realign Pads over 2mm: Pad의 너비 또는 높이의 길이가 2mm 이상이면, Base 위치를 다시 계산하여 졍렬 ※ 참고: 너비 또는 높이가 2mm 이상인 패드에서 미납 가성 에러가 반복적으로 발생할 경우, 이 옵션을 사용하십시오. [Hidden]Use Only Valid Area: Visibility가 높은 영역만으로 대표 Base 높이를 측정하여 Base 위치를 정렬 Using the segmental base: True로 설정 시, Height Threshold로 Solder를 제거 후 Base 정렬 [Hidden]Use Pad Mask: Pad Mask를 Solder Mask에 추가하고, Solder Mask를 제외한 영역에서 Base 정렬 FPCB: Flexible PCB일 경우, Base를 구할 때 ROI내에서 휨 보상을 해야 할 경우 사용합니다.(Flexible PCB일 경우 검사 영역 내에서 기울기 보상을 적용) Exclude Neighbor Pad: 인접한 패드 및 솔더 영역을 Base 측정 값에서 제외 ※ 참고: 패드에 대한 캐드 정보가 있는 영역에만 적용할 수 있습니다. ※ 참고: 패드에 대한 솔더가 캐드 영역을 벗어나 넓게 도포된 경우, Base 측정 값에 오차가 발생할 수 있습니다. Set L-Fid. as Base Plane: True로 설정 시, Local Fiducial의 높이를 기준으로 패드의 Base 정렬 ※ 참고: 한 Panel 안에 Multi-Layer가 존재할 경우, Pad Grouping기능을 사용하여 각 Layer 별로 Base를 정렬할 수 있습니다. [Hidden]Slope Check Interval: Stepping Stone 간격을 설정 L. Fid Group: ‘Set L-Fid. as Base Plane’의 하위 옵션 Reference to Another Slope: Multi-Layer인 경우의 기울기(Slope) 보상 방식 설정 False: L2 영역의 기울기 고려없이 Base Plane을 산출 True: L1의 L-Fid.에서 산출된 Slope Data를 L2의 L-Fid.를 기준으로 동일하게 적용하여 기울기 보상 (Default) ⑤ Set Base Plane 사용자가 등록한 바닥면(Base Plane)을 기준으로 Pad의 Base를 정렬합니다. ※ 주의: 이 기능 사용하려면, Job File Edit 메뉴에서 Set Base Plane 옵션에 체크하고 Pad Group에 대한 User Base를 등록해야 합니다. Method No: 이 기능을 사용하지 않음. Plane: 평면의 방정식으로 User Base의 높이를 계산 Average: 평균 값으로 User Base의 높이를 계산 ※ 참고: Set Base Plane 기능 적용 시, BBT는 적용되지 않습니다. Use a Component plane False: Pad별로 User Base를 적용 True: Group별로 User Base를 적용 Z Axis Range of Plane(um): User Base의 최대 높이를 설정 Base Shift: 기존에 설정된 Set Base Plane의 Base ROI 영역의 높이와 Solder Paste 측정을 위한 실제 Base Plane의 높이에 차이가 있는 경우, 그 높이 차이를 입력하여 Base ROI 영역의 Base Plane 높이 값을 보상해주는 기능 ※ 참고: Set Base Plane 기능은 생성한 Base ROI 영역 안의 높이 편차가 적어야만 안정적으로 높이를 측정할 수 있습니다. ※ 참고: Set Base Plane 기능 적용 시, BBT는 적용되지 않습니다. ⑥ Noise Level 노이즈로 처리할 밝기 기준을 설정합니다. Bright noise: 설정값 보다 밝은 부분을 노이즈로 처리 Dark noise: 설정값 보다 어두운 부분을 노이즈로 처리 Visibility noise: 설정값 보다 Visibility 값이 작은 부분을 노이즈로 처리 Diff. Visibility on channels: Dual Projection을 사용하는 경우, 채널 간 Visibility 차이가 설정한 값보다 크면 노이즈로 처리 Check Low. Visibility Channel All: Dual Projection을 사용하는 경우, 두 채널 모두 Low Visibility 이면 노이즈로 처리 Half: Dual Projection을 사용하는 경우, 두 채널 중 한 채널이라도 Low Visibility 이면 노이즈로 처리 Check Saturation: 임의의 픽셀이 Limit 값 이상인 이미지의 개수가 Valid buckets의 설정 개수 이상이면 해당 픽셀은 Noise로 처리 Valid buckets: 유효한 이미지의 숫자 Limit Bright: 해당 숫자 이상이면 유효하지 않은 픽셀로 판단 ⑦ Segmentation [Hidden]Segment Base Method: Pad 별 검사 속성(Change PAD Inspection Condition)에서 Base Align Method로 Segmentation이 선택된 경우의 상세 옵션 입니다. Based on 2D: 2D 이미지로만 Base 영역을 찾음 (Default) Based on 3D: 3D와 2D 이미지로 Base 영역을 찾음 Pad surface: 특정 Pad Surface에서 Base를 정렬한 후, 대상Pad의 Base 정렬에 적용 [Hidden]Pad Surface Target: Segment Base Method로 Pad surface가 선택된 경우 설정하는 옵션입니다. Panel: Panel 내부 Pad Surface에서 Base 정렬 후, Panel에 속한 모든 Pad들의 Base 정렬에 적용 ※ 참고: Pad 주변이 FR4 등으로 인해 Base 정렬이 어려운 경우, 이 기능을 적용하여 Volume 측정의 정확성을 향상시킬 수 있습니다. Measurement Method BBT Information: PLT로 생성한 Solder Map을 활용하여 Volume을 측정 Qvolume: Qvolume을 측정 Texture: K-Means(Texture, Height)으로 생성한 Solder Map을 활용하여 Volume을 측정 [Hidden]TH. Roughness: 3D로 찾은 Base 영역에서 노이즈로 인식하는 Roughness값 [Hidden]Range for Avg. phase: Avg. Phase를 계산하기 위한 범위 [Hidden] Black Level: RGB 이미지로부터 Base Mask 생성 시, Black 보드를 제외하기 위한 기준 값들을 설정 Value: Black 보드로 인식하는 RGB의 Level 값 Standard Deviation: Black 보드로 인식하는 RGB의 표준편차 값 Average: Black 보드로 인식하는 RGB의 평균 값 [Hidden]QVolume: Measurement Method로 Qvolume 선택 시 적용되는 옵션입니다. Dark Gray Threshold: 너무 어두운 영역을 Solder Map에서 제외하기 위한 RGB 평균 값 Brightness Gray Threshold: 너무 밝은 영역(Silk 등) 을 Solder Map에서 제외하기 위한 RGB 평균 값 Saturation Gray Threshold: HSV의 Saturation Image 기준 값으로, 해당 값 이상인 경우 Solder Map에서 제외 Solder Mask Threshold: Solder Mask 생성을 위한 Threshold 값 Height Threshold: 설정한 Height Threshold를 초과하는 경우만 Solder 영역으로 간주 Height Offset: 측정한 Height 값에서 설정한 Height Offset만큼 제외 Bright Ring Area Percentage: Bright Ring을 제외하기 위한 옵션으로, Bright Ring의 Area Percentage 설정 Additional Dark Gray Threshold: Bright Ring을 제외하기 위한 옵션으로, Bright Ring Area Percentage보다 Real Area Percentage가 더 적은 경우, Dark Gray Threshold + Additional Dark Gray Threshold이하의 RGB 평균값을 갖는 영역은 Solder Map에서 제외 Texture: Measurement Method로 Texture 선택 시 적용되는 옵션입니다. [Hidden]Method MeanShift: Cluster의 무게중심을 평균 값으로 재설정 MedianShift: Cluster의 무게중심을 중앙 값으로 재설정 Fuzzy: Cluster의 무게 중심을 평균 값으로 재설정하는 과정에서, 특정 Cluster에 속할 확률을 가중치로 적용 [Hidden]Channel Align No: CBF Map이 밝거나 Pattern의 Edge영역이 Solder의 밝기와 비슷할 때 사용 Use: CBF Map의 밝기가 어두울 때 사용 (Default) [Hidden]Height Normalize No: Stencil 높이로 고정해서 높이 표준화(Nomalize) Use: Pad 내의 최대 높이로 높이 표준화 (Default) [Hidden]Texture Filter Median: CBF Map이 밝거나 Pattern의 Edge가 Solder의 밝기와 비슷할 때 사용 Mean: Default 설정으로 Trimmed Mean Filter 사용으로 Median 보다 더 밝게 Map이 생성됨 Smooth Texture No: 생성된 CBF(Texture) Map이 어두울 경우 선택 Use: 평균 값으로 적용하여 Edge Noise 및 Solder 영역의 밝기가 감소함 (Default) ※ 참고: Pattern의 Edge영역과 Solder의 Texture가 비슷할 경우에는 ‘Use’를 사용하고 그렇지 않는 경우에는 ‘No’를 사용하십시오. [Hidden]Solder Limit Area: Pad 면적을 기준으로 Initial mask 면적이 설정 값(%) 이상일 경우 K-Means clustering이 동작함. (‘0’으로 설정한 경우, 모든 Pad들에서 무조건 동작) Solder Dilation: K-Means Mask에서 설정된 값(Pixel) 으로 Mask를 확장 ※ 참고: Solder 영역을 실제 영역보다 작게 찾아진 경우 사용하면 유용합니다. Saturation Image No: CBF Map, Height로 Segmentation 진행 (Default) Use: CBF Map, Height, Saturation Image로 Segmentation 진행 ※ 참고: Solder 영역이 Base와 구분되는 Saturation Image를 사용하십시오. 이 기능을 사용 시, Tact time에는 영향이 없으나 Processing Time은 증가할 수 있습니다. Solder Probability: Initial Mask를 생성할 때 Solder 영역을 구분 짓는 실험적인 확률(%) 수치 (Default: 80) ※ 참고: Default 값으로 설정하는 것을 권장합니다. 더 적은 양의 Solder도 검사하기 원할 경우에는 80% 이하 값으로 설정하십시오. Image Select: CBF(Texture) Image를 생성할 때 사용할 조명 설정"
},
{
"toc_id": "chapter04_heading03_sub04_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "비젼설정 (Vision Parameter)",
 "title2": "Z_CAL 탭",
 "body": "※ 참고: Z_CAL 탭은 Calibration에 필요한 항목들을 설정하는 메뉴였으나, 현재 SPI는 KYCAL을 통해 Calibration을 진행합니다. 따라서, 현재는 이 탭을 사용하지 않습니다."
},
{
"toc_id": "chapter04_heading04_KOR.html",
 "chapter_i": "4",
 "chapter": "검사 관련 설정",
 "title": "생산 수량 (PCB Qty)",
 "title2": "",
 "body": "Setting 메뉴에서 PCB Qty를 클릭하여 PCB 수량을 설정할 수 있습니다. No. 항목 설명 1 PCB 작업 수량 PCB 작업 수량 입력 2 스텐실 설정 스텐실 추가 또는 삭제 설정된 스텐실 사용 횟수가 되면, 경고가 울림 3 Lot Info Lot 정보 입력 4 Bare Board Inspection Bare Board Inspection 사용 여부 선택"
},
{
"toc_id": "chapter05_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "",
 "title2": "",
 "body": "이 장에서는, 3D Inspector의 실행 절차에 대해 설명합니다. 3D Inspector의 실행 절차는 아래 그림과 같이 7단계로 구성됩니다. 3D Inspector는 CEditor에서 작성한 JOB 파일을 통해 PCB 검사를 수행하며, 검사 결과를 저장하는 것입니다. PCB가 PCB 검사에 불합격되면 PCB 불량의 유형을 분석하여 사용자에게 알려주고, SPC Plus를 통해 검사 결과를 통계화합니다. ※ 참고: 3D Inspector는 사용자 권한 정책에 따라 사용자의 프로그램 기능 접근을 제한합니다. 3D Inspector의 JOB 파일을 편집하거나 Teaching 등의 기능을 수행하기 위해서는 사용자 선택 대화상자를 이용하여 사용자를 Supervisor로 변경해야 합니다."
},
{
"toc_id": "chapter05_heading01_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "사용자 권한 설정 및 변경",
 "title2": "",
 "body": "사용자 권한 설정 및 변경은 3D Inspector 사용의 가장 기본 절차입니다. 이 절차에서 수행할 작업으로는 다음과 같이 3가지가 있습니다. 사용자 변경 사용자 권한 설정 사용자 추가/수정/삭제"
},
{
"toc_id": "chapter05_heading01_sub01_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "사용자 권한 설정 및 변경",
 "title2": "사용자 변경",
 "body": "3D Inspector의 사용자를 변경하려면, 다음 순서대로 작업하십시오. 메인 화면 우측 상단의 User 메뉴를 클릭하십시오. 그러면 로그인한 사용자 정보가 표시됩니다.. Switch User를 클릭하십시오. 로그인 창이 팝업하면, 사용자 계정과 패스워드를 입력한 후 Login 버튼을 클릭하십시오."
},
{
"toc_id": "chapter05_heading01_sub02_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "사용자 권한 설정 및 변경",
 "title2": "사용자 권한 설정",
 "body": "3D Inspector의 사용자 권한을 설정하려면, 다음 순서대로 작업하십시오. Setting 메뉴에서 User Level을 클릭하십시오. 그러면 Account 창이 나타납니다. Your Permission에서 각 기능별 사용 권한을 설정한 후, OK 버튼을 클릭하십시오. Auto Log-off Auto Log-off는 로그인 후 설정한 시간이 지나면 자동으로 해당 사용자를 로그오프하거나, 지정한 사용자로 자동 변경하는 기능입니다. Auto Log-off 기능을 적용하려면, 다음 순서대로 작업하십시오. Account 창 좌측 상단의 'Aut logout after _______minutes of inactivity' 항목에 대기 시간을 설정하십시오. 설정한 시간이 지나면 현재 로그인된 사용자가 자동으로 로그아웃되고, AutoOperator로 자동 로그인됩니다. Auto Log-off by Group Auto Log-off by Group은 그룹별로 수율을 관리하는 경우, 그룹이 변경될 때 현재 사용자 정보가 자동으로 Log-off 하는 기능입니다. Auto Log-off by Group 기능을 적용하려면, 다음 순서대로 작업하십시오. Account 창 좌측 상단의 대화상자 좌측 상단의 'Auto logoug when the work group is changed' 항목을 선택하십시오. Setting &gt; Inspection &gt; Inspection Option &gt;Work Group Setting 에서 설정한 시간이 지나면, 현재 로그인된 사용자가 자동으로 로그아웃되고, AutoOperator로 자동 로그인됩니다. ※ 참고: Work Group Setting에서 그룹이 1개만 설정되어 있는 경우, Auto Log-off By Group 기능을 사용할 수 없습니다."
},
{
"toc_id": "chapter05_heading01_sub03_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "사용자 권한 설정 및 변경",
 "title2": "사용자 추가/수정/삭제",
 "body": "3D Inspector의 사용자를 추가하거나 수정, 삭제할 수 있습니다. 사용자 추가 3D Inspector의 사용자를 추가하려면 다음 순서대로 작업하십시오. 세부 메뉴에서 User 버튼을 클릭하십시오. Switch User를 클릭하여 로그인 창을 활성화하십시오. Supervisor 계정을 선택하고, 패스워드를 입력하십시오. 세부 메뉴에서 User Level 버튼을 클릭하십시오. 좌측 하단의 User Manage 버튼을 클릭하면, User Info 창이 나타납니다. Add User 대화상자에서 추가할 User Name과 Password를 입력하고 Level을 선택한 뒤, OK 버튼을 클릭하십시오. ※ 참고: 사용자를 추가할 때, Password를 입력하지 않으면 사용자 변경 작업을 할 때 Password 없이 사용자 변경이 가능합니다. 사용자 수정 사용자 정보를 수정하려면 다음 순서대로 작업하십시오. ※ 참고: 이 작업을 하려면, Supervisor 계정으로 로그인해야 합니다. User Manage 창에서 수정할 사용자를 선택한 후, Edit 버튼을 클릭하십시오. 그러면 Modify User 창이 나타납니다. 사용자 정보를 수정한 후, OK 버튼을 클릭하십시오. 사용자 삭제 사용자 정보를 삭제하려면 다음 순서대로 작업하십시오. ※ 참고: 이 작업을 하려면, Supervisor 계정으로 로그인해야 합니다. User Manage 창에서 삭제할 사용자를 선택한 후, Delete를 클릭하십시오. 그러면 UserControl 창이 나타납니다. UserControl 창에서 예(Y) 버튼을 클릭하십시오."
},
{
"toc_id": "chapter05_heading02_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "JOB 파일 로드 및 편집",
 "title2": "",
 "body": "이 절에서는 JOB 파일을 로드 및 편집하는 방법에 대해 설명하겠습니다. 3D Inspector가 PCB 검사를 수행하기 위해서는 JOB 파일이 필요합니다."
},
{
"toc_id": "chapter05_heading02_sub01_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "JOB 파일 로드 및 편집",
 "title2": "PCB 생산 수량",
 "body": "3D Inspector를 실행하면 PCB 검사 수량 창이 자동으로 나타납니다. PCB 생산 수량 대화상자에 로드하려는 PCB 관련 정보를 입력한 후 OK 버튼을 클릭하십시오."
},
{
"toc_id": "chapter05_heading02_sub02_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "JOB 파일 로드 및 편집",
 "title2": "JOB 파일 로드",
 "body": "JOB 파일을 로드하려면, Production 메뉴의 Open을 클릭하십시오. Open File 창이 나타나면, JOB 파일을 선택하고 OK 버튼을 클릭하십시오. 항목 설명 최근 파일을 순서대로 보여줌 레이아웃을 List view 모드로 변경 레이아웃을 Preview 모드로 변경 JOB 파일 옵션을 확인하려면, 버튼을 클릭하십시오. 선택된 JOB 파일 정보가 하단에 나타납니다. 파일열기 창에서 JOB 파일을 검색하려면, 다음 순서대로 작업하십시오. 목록 영역을 클릭하고, 키보드로 JOB 파일을 검색하십시오. 그러면 검색결과가 하이라이트되어 표시됩니다. 각 하위 폴더에 속한 JOB 파일들을 확인할 수 있습니다."
},
{
"toc_id": "chapter05_heading02_sub03_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "JOB 파일 로드 및 편집",
 "title2": "JOB 파일 편집",
 "body": "3D Inspector에서는, CEditor와 연동하여 JOB 파일을 편집할 수 있게 설계되어 있으며, 3D Inspector 의 JOB 파일 편집 메뉴를 통해서도 JOB 파일을 편집할 수 있습니다. 먼저, CEditor와 연동하여 JOB 파일을 편집하려면, 메인 메뉴에서 File을 선택한 후 CEditor 메뉴를 클릭하여 CEditor를 실행하십시오. ※ 참고: CEditor에서 JOB 파일을 편집하는데 필요한 상세한 정보는 CEditor 매뉴얼을 참고하십시오. 3D Inspector의 JOB 파일 편집 메뉴를 통해서도 Pad 추가, 삭제, 복사 등의 편집기능을 실행할 수 있습니다. 우선, PCB 뷰 옵션 중 JOB 파일 편집 메뉴를 클릭하여 Job Edit Mode로 들어가십시오. ※ 참고: JOB 파일을 편집 모드는 Supervisor 레벨로 로그인한 경우에만 사용할 수 있습니다. PCB 검사 진행 중에도 Job Edit Mode로 진입하여 JOB 파일을 편집할 수 있으며, Job Edit Mode가 종료된 후에 검사되는 PCB부터 변경 사항이 적용됩니다. Pad 추가하기 Job Edit Mode에서 Pad를 추가하려면, 다음 순서대로 작업하십시오. &lt;Add Pad 버튼 이용&gt; Job Edit Mode의 PCB 뷰 우측 메뉴 중, Add Pad 버튼을 클릭하면 ADD PAD 창이 나타납니다. 추가할 Pad 정보를 입력 후 OK 버튼을 클릭하십시오. &lt;마우스 오른쪽 버튼 이용&gt; 마우스를 사용하여 Pad를 추가하려면, PCB 뷰어 위에서 마우스 오른쪽을 클릭하면 나타나는 팝업메뉴에서 Add Pad를 선택하십시오. 아래와 같은 메시지가 나타나면, Pad를 추가하고자 하는 위치를 마우스로 드레그하여 지정하십시오. 드레그가 끝나면 ADD PAD 창이 나타나고, 지정한 Pad 위치 정보가 자동으로 입력됩니다. OK 버튼을 클릭하면 Pad가 해당 위치에 추가됩니다. Pad 삭제하기 Job Edit Mode에서 Pad를 삭제하려면, 다음 순서대로 작업하십시오. &lt;Delete Pad 버튼 이용&gt; PCB 뷰어에서 삭제할 Pad를 선택한 후, Delete Pad 버튼을 클릭하십시오. 아래와 같이 확인 메세지창이 나타나면, Yes 버튼을 클릭하여 선택한 Pad를 삭제하십시오. ※ 참고: 삭제 확인창이 팝업된 상태에서는 다른 버튼이 클릭되지 않습니다. &lt;마우스 오른쪽 버튼 이용&gt; 마우스를 이용하여 Pad를 삭제하려면, PCB 뷰어에서 삭제할 Pad를 선택한 후 마우스 오른쪽을 클릭하십시오. 화면에 나타나는 팝업메뉴에서 Delete Pad를 선택하십시오. 확인 메세지창에서 Yes 버튼을 클릭하면 선택한 Pad가 삭제됩니다. Pad 복사&amp;붙여넣기 Job Edit Mode에서 Pad를 복사하여 붙여넣기하려면, 다음 순서대로 작업하십시오. &lt;Copy&amp;Paste 버튼 이용&gt; PCB 뷰어에서 복사할 Pad를 선택한 후, Copy&amp;Paste버튼을 클릭하십시오. 복사한 Pad 들이 화면에 표시되면서, 아래와 같이 Copy &amp; Paste Pads 창이 나타납니다. 그러면, Pad를 붙여넣을 위치를 설정하십시오. Paste 버튼을 클릭하면, Pad가 지정한 위치에 복사됩니다. &lt;마우스 오른쪽 버튼 이용&gt; PCB 뷰어에서 복사할 Pad를 선택한 후 마우스 오른쪽 버튼을 클릭하십시오. 화면에 나타나는 팝업메뉴에서 Copy Pads를 선택하십시오. 복사한 Pad를 붙여넣을 위치에서 마우스 오른쪽 버튼을 클릭하고, Paste Pads를 선택하십시오. 마우스로 클릭한 위치에 선택된 Pad들이 복사됩니다. &lt;마우스 드레그&amp;드롭 방법 이용&gt; PCB 뷰어에서 마우스를 이용하여 복사할 Pad를 선택하십시오.. 키보드 ctrl 버튼을 누른 상태에서 선택된 Pad 중 하나를 드레그하십시오. 원하는 위치에서 마우스 버튼을 떼면, 그 위치에 선택된 Pad들이 복사됩니다. Pad 위치 이동하기 Job Edit Mode에서 Pad의 위치를 이동하려면, 다음 순서대로 작업하십시오. &lt;방향키 버튼 이용&gt; PCB 뷰어에서 이동시킬 Pad들을 선택한 후, 화면 우측 하단에서 한번에 이동할 거리를 설정하십시오. 화살표 버튼을 이용하여 선택한 Pad들을 원하는 위치로 이동하십시오. &lt;마우스 오른쪽 버튼 이용&gt; PCB 뷰어에서 이동시킬 Pad들을 선택한 후 마우스 오른쪽 버튼을 클릭하십시오. 화면에 나타나는 팝업메뉴에서 Shift Pads를 선택하십시오. Pad를 붙여넣을 위치에서 마우스 오른쪽 버튼을 클릭하고, Paste Pads를 선택하십시오. 마우스로 클릭한 위치에 선택된 Pad들이 이동합니다. &lt;마우스 드레그&amp;드롭 방법 이용&gt; PCB 뷰어에서 마우스를 이용하여 이동시킬 Pad들을 선택하십시오. 키보드 shift 버튼을 누른 상태에서 선택된 Pad 중 하나를 드레그하십시오. 원하는 위치에서 마우스 버튼을 떼면, 그 위치로 선택된 Pad들이 이동합니다. 변경 사항 확인 Job Edit Mode에서 사용자가 편집한 JOB 파일의 변경 사항이 각 버튼의 좌측에 아래와 같이 표시됩니다. Job Edit Mode에서 Background Image 보기 Job Edit Mode에서 Live 버튼을 클릭하면 Background image를 불러와 표시할 수 있습니다. 단, 해당 PCB의 Background Image가 JOB 파일과 동일한 폴더에 동일한 이름의 *.jpg 파일로 존재할 경우에만 이미지가 나타납니다. Job Edit Mode에서 FOV Optimize 상태 보기 Job Edit Mode에서 FOV 버튼을 클릭하면 현재 FOV Optimize 상태를 표시할 수 있습니다."
},
{
"toc_id": "chapter05_heading02_sub04_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "JOB 파일 로드 및 편집",
 "title2": "Pattern Job",
 "body": "Pattern Job 기능은 동일한 패널이 반복적으로 배치되어 있는 PCB인 경우 반복 정보를 패턴화시켜 Pattern Job 파일을 생성하는 기능입니다. 이 기능을 사용하면 Job 로딩시간이 단축되고 BBT Data 크기를 감소시켜 대용량의 Job 파일을 보다 쉽게 처리할 수 있습니다. Pad의 총 개수가 15만개 이상인 Pattern Job이 로드되었을 경우, PCBViewer가 자동으로 Panel Display Mode로 변경되고 하기 그림과 같이 PCBViewer 좌상단에 표시됩니다. Panel Display Mode 에서는 전체 패드들이 그려지지 않고 각 패널들의 외곽선만이 표시됩니다. Pattern Job 생성 이 장에서는 Pattern Job파일을 생성 및 편집하는 과정에 대해 기술합니다. ePM-SPI 2.2.128 이상 버전에서 Gerber 파일 편집을 완료한 후, 다음과 같이 KYPCB 형식으로 파일을 출력합니다. 이때, 작업 영역으로 지정되어 티칭이 진행된 패널을 1번 패널로 지정해야 합니다. KYPCB 파일 출력 CEditor&gt; File &gt; Load KYPCB file를 선택하여 KYPCB 파일을 선택하고 로드합니다. Pattern Job 편집 다음의 항목이 편집될 경우 모든 패널에서 패널 내 동일 패드들에 대해 다음의 변경사항이 적용됩니다. Component Name, Part Name 항목과 같은 CAD 정보 각도, Size X, Size Y, Area Percent 항목과 같은 Pad의 모양 및 크기에 대한 정보 Position X, Position Y와 같은 Pad의 위치에 대한 정보 Pad의 Unused 여부 Pad 개별 Extend ROI의 사용 여부와 각 방향 별 설정 값 위에서 기술되지 않은 Tolerance와 Vision 검사 속성 등은 모든 패드들에 대해 개별적으로 변경할 수 있습니다. ※ 참고: Pad Edit 화면의 Position X, Position Y의 값은 수정할 수 없으며, 패드 위치 변경이 필요할 경우 Shift Pads 기능을 이용해야 합니다. ※ 참고: Pad의 추가, 삭제 및 병합 기능은 사용할 수 없습니다. Pattern Job 사용시 유의 사항 Pattren Job 파일 사용 시 다음을 유의해 주십시오. Pattern Job 파일은 Pad 개수는 40만개 이하, 패널 개수는 3만개 이하일 경우에만 사용할 수 있습니다. 기존에 사용 중인 Non-Pattern Job 파일은 Pattern Job 파일로 변경할 수 없고, ePM-SPI에서 출력된 KYPCB 파일을 로드하는 방법으로만 Pattern Job 파일을 생성할 수 있습니다. KYConfig에서 설정 값을 변경함으로써 KYPCB 파일을 로드하여 생성되는 Job 파일의Pattern Job / Non-Pattern Job 여부를 지정할 수 있습니다. 새로 생성된 Pattern Job 파일은 Job Version 2.0으로 생성되며, Job Version 1.0으로 변경할 수 없습니다. ※ 참고: Pad 개수가 15만개 이상인 경우, Pattern Job 파일의 사용을 권장합니다. 기존 GUI 버전과의 호환성 Pattren Job 파일 사용 시 고려해야 할 기존 GUI 버전과의 호환성은 다음과 같습니다. 4.10.0.0 이상의 GUI 버전에서 생성된 Pattern Job 파일은 4.10.0.0 미만의 GUI버전에서도 사용할 수 있습니다. Pattern Job파일에서 수정된 내용은 4.10.0.0 미만의 GUI 버전에서도 동일하게 적용됩니다. Pattern Job파일을 티칭 한 BBT Data는 GUI 4.10.0.0 미만에서 사용할 경우 호환되지 않으며, 재티칭을 진행해야 합니다. Pattern Job 불러오기 CEditor&gt; File &gt; Load KYPCB file를 선택하여 KYPCB 파일을 선택하고 로드합니다."
},
{
"toc_id": "chapter05_heading03_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "Teaching",
 "title2": "",
 "body": "이 절에서는 Teaching 작업에 대해 설명합니다. Teaching은 검사 관련 기준값이나 기본 설정값을 입력해 놓는 작업입니다. Teaching 수행 전에는 teaching에 대한 정확한 이해도가 필요합니다. 여기에 포함된 세부 작업은 다음과 같습니다. Bare Board teaching Multi Vendor teaching Bad Mark teaching Fiducial teaching Camera teaching ※ 참고: 이 작업은 Supervisor가 수행해야 합니다. ※ 참고: Teaching은 필수적인 3D Inspector 수행 절차는 아니며, 검사 정확도를 위한 조율 작업 중 하나입니다. 현재 장비를 해당 PCB에 대해 최적화한 상태라면, 다음 수행 절차인 검사 조건 입력 수행 절차를 바로 진행하십시오."
},
{
"toc_id": "chapter05_heading03_sub01_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "Teaching",
 "title2": "Bare Board Teaching",
 "body": "Bare Board teaching은 납이 도포되지 않은 빈 PCB(Bare Board)를 미리 검사하여 해당 높이를 구하고 이를 기준으로 실제 검사 시 납이 도포된 높이만을 도출하는 기능입니다. Bare Board Teaching 마법사는 이 기능을 더 쉽게 사용하도록 하는 도구입니다. 이 기능을 사용하려면 다음 순서대로 작업하십시오. Bare Boared를 Work 컨베이어에 위치시킵니다. Job Creation 메뉴의 BBTW 버튼을 클릭하십시오. 그러면 Bare Board Teaching 창이 나타납니다. Bare Board Teaching 창에서 Bare Board Teaching 버튼을 클릭한 후, Next 버튼을 클릭하십시오. 보드 수량과 Vender name을 입력하고 Next 버튼을 클릭하십시오. Next 버튼을 클릭하여 Bare Board Teaching을 시작합니다. 검사가 완료되면, 아래와 같은 대화상자가 자동으로 나타납니다. Bard Board Teaching을 마치려면, No 버튼을 클릭하십시오."
},
{
"toc_id": "chapter05_heading03_sub02_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "Teaching",
 "title2": "Fiducial Teaching",
 "body": "Fiducial Tool의 Teaching은, 해당 PCB의 피두셜인 패드가 특이한 형상이어서 자동 인식이 불가능할 경우 수행하는 작업입니다. ※ 참고: Fiducial 추가 및 이동 방법은 본 문서의 잡 생성(Job Creation) &gt; 피두셜 부분을 참고하십시오. 항목 설명 Fiducial shape selection Fiducial 패드의 형태 선택 - Normal: 일반적인 원형 - Matching: 특별한 도형 - 3D: 3D 검사를 진행하여 fiducial 형태 검출 Offset X X축 옵셋 위치 입력 Offset Y Y축 옵셋 위치 입력 Acceptable 허용 범위 값 입력 Fiducial teaching을 하려면 다음 순서대로 작업하십시오. Job Creation 메뉴의 Fiducial을 클릭하십시오. 그러면, Fiducial Tool 창이 나타납니다. Teaching 탭을 클릭하십시오. Go to Fiducial 버튼을 클릭하십시오. Matching/Teaching ROI 버튼을 클릭한 후, Fiducial Image에서 teaching할 영역을 마우스로 드래그하십시오. Read info 버튼을 클릭하십시오. 그러면 사각형 테두리 안에 붉은색으로 fiducial과 검은 외곽 영역의 비율이 나타납니다. 이 비율이 1:1 정도가 되게 설정하십시오. Apply 버튼을 클릭하십시오. Teaching Image 버튼을 클릭하십시오. Fiducial 확대 기능 Fiducial 확대 기능은 Step Zoom 장비의 경우 fiducial을 인식할 때 어떤 확대배율로 fiducial을 인식할지 선택하는 기능입니다. Fiducial 확대 기능을 사용하려면 다음 순서대로 작업하십시오. 온라인 상태에서 Fiducial Tool 창의 Fiducial Move 탭의 Step Zoom 항목을 선택하십시오 Step을 선택한 후 OK 버튼을 클릭하십시오. JOB 파일을 저장하십시오. Fiducial Wizard Fiducial Wizard 기능을 사용하려면, 아래의 순서대로 진행하십시오. 먼저, KYConfig를 실행하여, 'Fiducial Wizard' 항목을 선택한 후 OK 버튼을 클릭하십시오. 3D Inspector의 잡 생성(Job Creation) 메뉴에서 Fiducial 클릭하면, Fiducial Wizard 가 실행됩니다. 왼쪽 화면에서 마우스를 이용하여 피두셜 위치 설정 후, Next 버튼을 클릭하여 Fiducial 검사를 실행하십시오. 조명 값을 변경하며 자동으로 Fiducial Teaching 진행 후, 완료 메시지가 나타나면 OK 버튼 클릭하십시오. Fiducial Teaching후 Score가 낮은 경우, ‘Fiducial Upper LED Brightness’ 및 ‘Fiducial threshold’ 슬라이드바를 변경하여 설정 값을 수정하고 Next 버튼을 클릭하십시오. 아래와 같은 화면이 나타나면 마우스로 Fiducial 영역을 클릭하여, Fiducial 정보 추출합니다. 클릭한 영역을 중심으로 자동 계산된 Fiducial 정보가 아래와 같이 화면 오른쪽에 표시됩니다. Fiducial 정보가 제대로 입력되었는지 확인 후, Next 버튼을 클릭하여 티칭을 완료하십시오. Temporary Fiducial 설정 생산 중 오염이나 다른 원인으로 인해 피두셜이 제대로 인식되지 않는 경우, 해당 PCB에 대한 Fiducial Teaching을 별도 진행하여 임시로 설정한 피두셜을 사용할 수 있습니다. 이 기능을 사용하려면, 아래의 순서대로 진행하십시오. KYConfig의 ETC Setup 버튼을 클릭하십시오. 'Use Temporary Fiducial Setup' 항목을 선택 후 OK 버튼을 클릭하여 설정을 완료합니다. 3D Inspector를 실행하여 검사를 진행하는 중 피두셜 인식이 실패하면, 사용자 화면에 Fiducial Teaching wizard 창이 자동으로 팝업합니다. Fiducial Wizard 창 좌측 뷰어에서 사용할 피두셜의 위치를 마우스를 이용하여 선택한 후, Next 버튼을 클릭하십시오. 조명 값을 변경하며 자동으로 피두셜 티칭이 진행된 후, 아래와 같이 완료 메시지가 나타나면 OK 버튼을 클릭하십시오. 피두셜 티칭 후 피두셜 스코어가 낮은 경우, 화면 우측의 'Fiducial Upper LED Brightness', 'Fiducial threshold' 슬라이드바를 조절하여 설정 값을 변경한 후, Next 버튼을 클릭하십시오. 아래와 같은 화면이 나타나면, 좌측 뷰어에서 마우스로 피두셜 영역을 클릭하여 피두셜 정보를 추출하십시오. 클릭한 영역을 중심으로 자동 계산된 피두셜 정보가 화면 우측에 표시됩니다. 피두셜 정보가 제대로 입력되었는지 확인한 후, Next 버튼을 클릭하여 티칭을 완료하십시오. 피두셜 티칭이 완료되면, 사용자가 지정한 위치를 임시 피두셜로 적용하여 해당 PCB 검사를 진행하십시오. 다음 PCB 검사에는 임시 피두셜이 적용되지 않습니다. Click Fiducial 기능 생산 중 오염이나 다른 원인으로 인해 피두셜이 제대로 인식되지 않는 경우, 해당 PCB의 피두셜 위치를 마우스로 지정하여 사용할 수 있습니다. 이 기능을 사용하려면, 아래의 순서대로 진행하십시오. KYConfig의 ETC Setup 버튼을 클릭하십시오. 'Use Temporary Fiducial Setup' 항목을 선택 후 OK 버튼을 클릭하여 설정을 완료합니다. 3D Inspector를 실행하여 검사를 진행하는 중 피두셜 인식이 실패하면, 사용자 화면에 Fiducial Teaching wizard 창이 자동으로 팝업합니다. Fiducial Wizard 창 좌측 뷰어에서 사용할 피두셜의 위치를 마우스로 클릭한 후, Next 버튼을 클릭하십시오. 피두셜 티칭이 완료되면, 사용자가 지정한 위치를 임시 피두셜로 적용하여 해당 PCB 검사를 진행하십시오. 다음 PCB 검사에는 임시 피두셜이 적용되지 않습니다. Fiducial Teaching Tool 2.0 개선된 Fiducial Teaching Tool 2.0 기능의 설정 방법 및 화면 구성은 아래와 같습니다. KY-3030 &gt; Setting &gt; Engineers &gt; Inspection Style에서 Use Basic Teaching Tool V2.0(Fiducial, Cambarcode) 옵션을 선택하면, Fiducial Teaching Tool V2.0을 사용할 수 있습니다. Job Creation 메뉴의 Fiducial 버튼을 클릭하면, Fiducial Teaching Tool V2.0이 실행됩니다. Screen Layout Fiducial Teaching Tool V2.0 화면은 아래와 같이 구성되어 있습니다. Camera Viewer: 현재 카메라 위치의 FOV 영상 표시 Live: 선택한 조명 채널의 FOV 이미지 표시 Color: RGB를 사용한 장비의 경우, FOV 이미지를 Color로 표시 ROI 표시: 현재 FOV에서 Fiducial Teaching을 위한 ROI 표시 카메라 이동: Camera Viewer 상에서 마우스 오른쪽 버튼을 클릭하여 카메라 위치 이동 ROI Move: FOV 가운데의 조명이 Fiducial 검사를 하기에 좋지 않은 경우, FOV 특정 위치에서 Fiducial 검사를 진행하기 위해 ROI Move 사용 PCB Viewer: PCB View를 클릭하여 PCB 상의 특정 위치로 카메라를 이동 Test Result Image: Fiducial 검사 후, 검사한 Image와 Threshold 이미지(이진화 이미지) 및 검사 결과 정보 표시 검사 결과 Image: 검사한 Fiducial의 이미지와 Shape 표시 검사 결과 Threshold Image: 검사한 Fiducial의 Threshold 값으로 이진화된 이미지 표시 검사 결과 정보: 검사 성공 여부, Score, 검사 설정 정보 표시 Fiducial List: Load한 JOB 파일의 Fiducial 정보 표시 Fiducial Settings: Basic 탭과 Advanced 탭으로 구성 Basic 탭: Fiducial Teaching 을 위한 기본적인 설정 항목 설명 Brightness Wizard Brightness Wizard를 선택하면, Shape 이외의 항목은 비활성화됨. Test 버튼 클릭 시 조명 밝기를 1~100까지 변경하며 검사 후, Recommend Score가 가장 높은 값으로 조명 채널, 조명밝기, Threshold 값이 자동 설정됨. Fiducial Shape &amp; Size Fiducial Shape: Fiducial 모양 및 색상 선택 Fiducial Size: Fiducial Size 선택 ROI Size Fiducial의 ROI 정보 선택 Light &amp; Threshold 조명설정: 검사된 조명채널 별 이미지 표시 및 검사 시 사용할 조명채널 선택 Brightness: 검사에 사용할 1~100의 조명 밝기 값 선택 Threshold: 검사에 사용할 1~255의 Threshold 값 선택 Advanced 탭: Fiducial의 속성에 따라 성능 향상을 위해 설정하는 옵션 항목 설명 Acceptable Score(40~100) Fiducial 검사 성공 여부의 기준이 되는 Score 입력 HASL Fiducial HASL Fiducial의 경우, 검사 성능 향상을 위해 사용 Circle Outline Fiducial Shape이 Circle인 경우 Circle의 외관선을 사용하여 Fiducial 검사하는 경우 사용 Use Remove Tail Fiducial의 Shape이 명확하지 않아 꼬리가 붙어있는 형태인 경우, 꼬리를 제거하고 Fiducial 검사하고자 할 때 사용 Pattern Fiducial Pattern Fiducial 기능은 PCB에서 피두셜로 사용할 피처가 없는 경우, 패드 여러 개를 한 개의 피두셜로 등록하여 사용하는 기능으로 Job 2.0 버전이상에서 지원합니다. Pattern Fiducial 등록 CEditor를 실행하고 Job File Ver. 2.0의 잡 파일을 로딩하십시오. CEditor 화면의 좌측 상단 메뉴에서 Pattern Fiducial을 선택하십시오. PCBView에서 Pattern Fiducial로 지정할 Pad 위치로 이동하십시오. Pattern Fiducial로 등록할 영역을 마우스로 드래그하십시오. 등록이 완료되면 아래와 같이 Pattern Fiducial 영역이 노란색으로 표시됩니다. ※ 참고: 드래그한 Pattern Fiducial의 영역이 클 경우 다음과 같은 메시지가 표시됩니다. 등록가능한 최대 Pattern Fiducial 개수 Pattern Fiducial 최대 등록 가능한 피두셜 개수는 다음의 공식에 따라 계산됩니다. 최대 등록 가능한 피두셜 개수 = 배열 수 (array) * Fiducial Count 이때, Fiducial Count는 기존의 피두셜과 Pattern Fiducial 개수를 합산한 수 PCB 설정 ※ 주의: Pattern Fiducial내에 포함되는 Pad는 중복되어 등록될 수 없습니다. 등록가능 등록 불가능 Pattern Fiducial 등록 해제 등록된 Pattern Fiducial 영역을 다시 클릭하면 Disabled Pattern Fiducial 로 변경됩니다. Pattern Fiducial 삭제 먼저 Pattern Fiducial을 등록 해제하십시오. CEditor 화면의 좌측 상단 메뉴에서 Pad 를 선택하십시오. Unselect All 버튼을 클릭하십시오. 삭제할 Pattern Fiducial 을 클릭하십시오. 도구에서 Pad 삭제를 선택하십시오. ※ 주의: 여러 개의 패드가 선택되었을 때는 복수개의 패드가 지워질 수 있으니, 삭제할 패드만 선택되었는지 확인하십시오. 티칭 절차 KY-3030&gt; setting&gt; Engineers&gt; Inspection Style &gt; Use Basic Teaching Tool V2.0(Fiducial, Cambarcode) 에 체크하십시오. Basic Teaching Tool 창으로 이동하여, 우측 Fiducial List에서 Pattern Fiducial 항목을 선택하십시오. ROI Tracker를 사용하여 ROI를 이동하고 사이즈를 수정하십시오. 좌측 하단의 Ref. Image 버튼을 클릭하여 Reference Image를 확인하십시오. ※ 참고: Pattern Fiducial 편집 시 ROI 이동 및 크기 수정이 가능하며, 이때 ROI의 크기는 등록된 Reference Image 사이즈 보다 커야 합니다."
},
{
"toc_id": "chapter05_heading03_sub03_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "Teaching",
 "title2": "Bad Mark Teaching",
 "body": "Bad Mark teaching 기능은, Array 보드의 경우 Marking이 된 array는 검사하지 않도록 하는 용도로 사용합니다. ※ 참고: Array board인 경우, Bad Mark가 포함된 array에 대해서는 PCB 검사를 하지 않습니다. SPI 장비 다음 단계인 마운터(mounter)에서 array board 중 특정한 array는 부품을 장착하지 않는 경우가 있습니다. 따라서, SPI 장비 또한 마운터에서 부품이 장착되지 않은 특정 array에 대해서는 PCB 검사를 할 필요가 없습니다. Bad Mark teaching을 하려면, 다음의 순서대로 작업하십시오. Job Creation 메뉴의 Bad Mark Teaching을 클릭하십시오. 아래와 같이 Bad Mark Wizard가 활성화합니다. Bad Mark Wizard 대화상자에서, board가 Single Array인지 Multi Array인지를 선택한 후, Next 버튼을 클릭하십시오. CEditor에서 설정했던 panel 개수를 입력한 후, Next 버튼을 클릭하십시오. OK 버튼을 클릭하십시오. ※ Bad Mark 검사 원리 Bad Mark가 없는 PCB를 우선 Teaching하며, 만약 Bad Mark가 발견되면 PCB 검사의 ROI 영역과 Bad Mark Teaching 정보의 ROI 영역에 대한 상호 이미지를 Gray 값으로 비교하여 Bark Mark를 구분하게 됩니다. Bad Mark Teaching 확인 기능 Bad Mark Teaching 확인 기능은 Bad Mark teaching이 끝나면 Bad Mark가 있는 PCB를 장비에 넣은 후 Bad Mark가 제대로 인식되는지 테스트하는 기능입니다. Bad Mark Test를 진행하려면, 다음의 순서대로 작업하십시오. Job Creation 메뉴의 Bad Mark Teaching을 클릭하십시오. 아래와 같이 Bad Mark Wizard 창이 활성화되면 Test 탭으로 이동하십시오. ※ 참고: Teaching된 Bad Mark 데이터가 없으면 Test 탭은 활성화되지 않습니다. Bad Mark Wizard 대화상자의 Test 탭에서 Bad Mark를 Test할 Panel을 선택한 후, Go 버튼을 클릭하십시오. ㄴ Head 이동이 완료된 후에 Test 버튼을 클릭하면 현재 설정되어 있는 ROI 위치와 함께 Bad Mark 인식 결과가 표시됩니다. Bad Mark ROI를 변경하려면 Camera 화면에서 마우스로 새로운 ROI를 그린 후, Change Bad Mark ROI &amp; Retest 버튼을 누르십시오. 새로운 ROI를 적용하여 Bad Mark Test가 시행되고, 그에 따른 결과가 표시됩니다."
},
{
"toc_id": "chapter05_heading03_sub04_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "Teaching",
 "title2": "Camera Barcode Teaching",
 "body": "Camera Barcode Teaching은 SPI 시스템의 카메라를 사용하여 PCB 바코드를 인식하는 기능입니다. Camera Barcode Teaching을 진행하려면, 다음의 순서대로 작업하십시오. 잡 생성 메뉴의 카메라 바코드를 클릭하십시오. 아래와 같이 Cam barcode teaching tool 창이 나타납니다. 'Barcode' 항목에 체크한 후, Fiducial Check 버튼을 클릭하여 Fiducial 검사를 진행하십시오 'No of Barcode' 항목에 사용할 바코드 수를 입력하고 SET을 클릭하십시오. Jog 버튼과 'PCB Jog' 항목을 이용하여 PCB 상의 바코드 위치로 이동하십시오. 바코드 검사에 사용할 각 항목들을 설정한 후 Test 버튼을 클릭하십시오 인식된 바코드 정보가 나타나면, 바코드가 제대로 인식되는지 확인하십시오. Long Barcode옵션을 사용하고자 하는 경우, LBarcode 버튼을 클릭하여 Long Barcode 관련 설정을 해주십시오. 바코드가 FOV 사이즈보다 큰 경우, Long Barcode 옵션을 사용합니다. 항목 설명 Use Long Barcode 옵션 사용 여부 Length 검사할 바코드의 길이 입력 Overlap FOV 이미지를 연결하였을 때 겹쳐지는 영역의 범위 Cambarcode Teaching Tool 2.0 개선된 Cambarcode Teaching Tool 2.0 기능의 설정 방법 및 화면 구성은 아래와 같습니다. KY-3030 &gt; Setting &gt; Engineers &gt; Inspection Style에서 Use Basic Teaching Tool V2.0(Fiducial, Cambarcode) 옵션을 선택하면, Cambarcode Teaching Tool V2.0을 사용할 수 있습니다. Job Creation 메뉴의 CAM Barcode 버튼을 클릭하면, Cambarcode Teaching Tool V2.0이 실행됩니다. Screen Layout Cambarcode Teaching Tool V2.0 화면은 아래와 같이 구성되어 있습니다. Camera Viewer: 현재 카메라 위치의 FOV 영상 표시 Live: 선택한 조명 채널의 FOV 이미지 표시 Color: RGB를 사용한 장비의 경우, FOV 이미지를 Color로 표시 ROI 표시: 현재 FOV에서 Cambarcode Teaching을 위한 ROI 표시 카메라 이동: Camera Viewer 상에서 마우스 오른쪽 버튼을 클릭하여 카메라 위치 이동 Long Barcode: Barcode 길이가 FOV에 포함되지 않을 경우, 카메라를 이동시켜 Barcode 위치를 맞추기 위해 사용 PCB Viewer: PCB View를 클릭하여 PCB 상의 특정 위치로 카메라를 이동 tmTest Result Image: Barcode 검사 후, 검사한 Image와 Threshold 이미지(이진화 이미지) 및 검사 결과 정보 표시 검사 결과 Image: 검사한 Barcode 이미지 표시 검사 결과 Threshold Image: 검사한 Barcode의 Threshold 값으로 이진화된 이미지 표시 검사 결과 정보: 검사 성공 여부, Score, 검사 설정 정보 표시 Fiducial List: Load한 JOB 파일의 Barcode 정보 표시 Fiducial Settings: Basic 탭과 Advanced 탭으로 구성 Basic 탭: Cambarcode Teaching 을 위한 기본적인 설정 항목 설명 Brightness Wizard Brightness Wizard를 선택하면, Shape 이외의 항목은 비활성화됨. Test 버튼 클릭 시 조명 밝기를 1~100까지 변경하며 검사 후, Recommend Score가 가장 높은 값으로 조명 채널, 조명밝기, Threshold 값이 자동 설정됨. Barcode Type Barcode의 Type 및 색상 선택 Light &amp; Threshold 조명설정: 검사된 조명채널 별 이미지 표시 및 검사 시 사용할 조명채널 선택 Brightness: 검사에 사용할 1~100의 조명 밝기 값 선택 Threshold: 검사에 사용할 1~255의 Threshold 값 선택 Test Selected Barcode 현재 선택된 Barcode의 검사 진행 Test All Barcode 등록된 모든 Barcode의 검사 진행 Advanced 탭: Barcode의 속성에 따라 성능 향상을 위해 설정하는 옵션 항목 설명 Retry Option Capture Retry Count(0~3): 검사 실패 시, Retry Count 만큼 다시 Capture하여 검사 Vision Algorithm Retry: Retry Off: 모든 Retry 옵션 사용 안 함 Retry with Speed Down: 검사 Speed를 낮춰가며 Retry Retry with Dot or Angle Change: 검사 Dot 또는 Angle 을 변경하며 Retry Retry with Color Change(Default): 검사 Color을 변경하며 Retry Barcode String Filter Options Use Barcode Length Limit: 인식된 문자의 글자수가 허용 범위인 경우에만 성공 처리 Remove unreadable Characters: 특수 문자로 인식된 문자를 제거 Image Filter Options Recognition Speed: 검사 Speed 설정 Dot Space(-6~6): Dot 간격에 대한 설정 Use Distortion (Uneven) Image: Data Matrix Type에서 가로와 세로 비율이 맞지 않는 경우 사용 Use Image Morphology: 이미지에 Morphology Close 알고리즘 적용(Noise 제거 및 작은 Hole 보정효과) Use Image Flip: Barcode Image의 좌우를 변경 캠 바코드의 전경 색상 자동 인식 바코드의 전경 색상이 섞여서 들어오면 바코드를 인식하지 못하는 문제를 해결하기 위해, 바코드 색상을 사전에 정의하지 않고 바코드를 인식할 수 있도록 하는 옵션이 추가되었습니다. Cam Barcode Teaching Tool Ver.1 ForeColor - Any: 바코드 색상을 ‘White’ 또는 ‘Black’으로 정의하지 않도록 하는 설정 Cam Barcode Teaching Tool Ver.2 Barcode Type - Any: 바코드 색상을 ‘White’ 또는 ‘Black’으로 정의하지 않도록 하는 설정 사용 방법 SPIGUI를 실행하고, 검사하고자 하는 JOB 파일을 여십시오. Cam Barcode Teaching 창에서 Barcode 색상을 ‘Any’로 설정합니다. Cam Barcode Teaching 및 자동 검사를 실행합니다."
},
{
"toc_id": "chapter05_heading04_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "검사 조건 변경",
 "title2": "",
 "body": "3D Inspector에서 검사 진행 중에 PCB 검사 조건을 변경하려면 CEditor 또는 3D Inspector의 Job Creation 메뉴에서 CEditor 메뉴를 클릭하여 작업을 수행할 수 있습니다. ※ 참고: 검사 조건 변경에 대한 자세한 내용은 Chapter 3를 참고하십시오. PCB 검사 조건을 변경하려면, 다음 순서대로 작업하십시오. PCB View에서 패드를 선택한 후, 마우스 오른쪽 버튼을 클릭하고 Pad Tolerance을 클릭하십시오. Change Pad Inspection Condition 창이 나타나면, 검사 조건을 변경한 후 확인 버튼을 클릭하십시오. Apply 버튼을 클릭하여, 변경된 JOB 파일을 검사에 적용합니다. PCB View가 ‘Inspection’ 화면으로 돌아갑니다."
},
{
"toc_id": "chapter05_heading05_KOR.html",
 "chapter_i": "5",
 "chapter": "3D Inspector 실행 절차",
 "title": "PCB 검사",
 "title2": "",
 "body": "3D Inspector에서는 다음과 같은 절차를 통해 PCB를 검사합니다. 사용자 계정을 supervisor로 선택하여 로그인 하십시오. 해당 PCB의 JOB 파일을 로드하십시오. 3D Inspector의 Setting 메뉴에서 Inspection을 클릭하십시오. Settings 대화상자의 Inspection Options을 클릭한 후 필요한 기능을 선택하십시오. 해당 PCB의 JOB 파일에 대한 편집 또는 해당 PCB의 teaching 기능이 이미 수행되었다면, 3D Inspector를 운용하기 전에 사용자를 Operator로 변경하십시오. SPI 장비의 Entry Conveyor에 검사 대상 PCB가 존재하는 것을 확인한 후, 검사 수행 도구 바의 Start 버튼을 클릭하십시오. 검사 대상 PCB에 불량 판정이 발생할 경우에는, SPC Plus의 Defect Review 대화상자나 3D Inspector의 Defect View 페이지가 자동으로 나타나 해당 PCB의 defect된 ROI를 이미지 및 defect의 유형 및 정도를 알려 줍니다."
},
{
"toc_id": "chapter06_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "",
 "title2": "",
 "body": ""
},
{
"toc_id": "chapter06_heading01_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "",
 "body": "이물 검사(Foreign Material Inspection)는 Real Color Image 기능을 이용하여 검사 대상 보드 표면에 존재하는 이물을 검사하는 기능입니다. 이물 검사를 진행하려면 아래와 같은 절차를 수행합니다."
},
{
"toc_id": "chapter06_heading01_sub01_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "KYConfig 설정",
 "body": "KYConfig에서 ‘Foreign Material’ 항목 및 ‘Use RGB’, ‘Use IR’ 항목에 체크하십시오. ETC Setup 버튼을 눌러 나타난 Setup 화면에서 'Use Full Scan Fov Optimize' 항목에 체크하십시오."
},
{
"toc_id": "chapter06_heading01_sub02_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "CEditor 설정",
 "body": "CEditor에서 검사하고자 하는 PCB의 JOB 파일을 여십시오. 상단 메뉴의 Tool 메뉴를 선택하고 Optimize FOV를 선택하십시오. 해당 장비의 Camera Resolution을 선택하십시오. 해당 항목이 없을 경우,' Manual Camera' 항목을 선택하고 Resolution을 입력하십시오. Show버튼을 클릭한 후, SET 버튼을 클릭하십시오. Optimize가 PCB 전체영역으로 실행 되는지 확인하십시오."
},
{
"toc_id": "chapter06_heading01_sub03_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "GUI 설정",
 "body": "3D Inspector를 실행하고 설정 메뉴의 검사설정 메뉴를 클릭하십시오. Setting 창이 나타나면, 보안 메뉴의 검사스타일 탭으로 이동하십시오. 'PCB Real Color Image'와 'Use FM Viewer' 항목에 체크하십시오 환경설정 메뉴의 조명 옵션 탭으로 이동하고, 'RGB LED' 및 'IR Brightness' 항목에 체크하십시오."
},
{
"toc_id": "chapter06_heading01_sub04_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "FM Parameter 설정",
 "body": "Foreign Material Teaching Tool &gt; Settings 탭&gt; 우측 상단의 버튼을 클릭합니다. 각 탭에서 설정을 진행합니다. Basic 탭 Parameter Settings -Basic 탭 항목 설명 Use ROI Slope Compensation 이물을 검출 할 때 보드의 기울기를 보상 후 부피 측정 Use High Height Foreign Material Inspection 높이가 높은 이물을 검출 Use GPU 2D FM Inspection 속도 향상을 위하여 GPU를 사용하여 2D 이물 검사 진행 Use Master Height Map 높이 맵을 마스터로 적용하기 위한 옵션 Use Panel Mask 이물 검사를 진행 할 때, Panel 영역을 Mask 처리하도록 설정 Use Pad Mask 이물 검사를 진행 할 때, Pad 영역을 Mask 처리하도록 설정 Background Master Image Save FM Teaching 시 PCB Master 이미지를 저장 할 때, 후면작업(background) 또는 전면작업(Foreground)로 저장 Distance from Pad Edge Pad에서 설정된 거리 안에 이물 검출 시, 해당 Pad는 브릿지 에러로 판정 3D Min. Limit Height Threshold 3D를 측정 할 때, 설정된 높이보다 낮은 부분은 노이즈로 인식하여 Volume 계산에서 제외 Advanced 탭 Parameter Settings –Advanced 탭 항목 설명 Inspect Bright FM 2D Bright FM 검사를 진행 Threshold(Bright FM) 2D Bright 검사에서 Master와 RGB image의 편차가 설정 값보다 큰 편차는 결함으로 검출 Remove small-sized FM automatically 작은 사이즈의 FM 결함을 자동으로 제거 Recognize as Copper (IR Light) IR 조명에서 설정된 값보다 밝은 영역을 Copper로 인식 Inspect Dark FM 2D Dark FM 검사를 진행 Threshold(Dark FM) 색상 이미지의 색상 편차가 설정 값보다 큰 부분을 결함으로 검출 Threshold (RGB Light) 2D Dark 검사에서 Saturation과 색상 이미지에서 편차가 설정 값보다 큰 영역을 결함으로 검출 Color Difference Use Visibility Information Visibility Image를 활용하여 FM 검사 진행 Threshold(Visibility Info.) Visibility Image의 색상 편차가 설정 값보다 큰 부분을 결함으로 검출 IR Mask Dilation No. 모폴로지(Morphology)를 적용하여 Hole로 인식된 영역을 설정 값으로 확대함 IR Hole Mask Threshold IR 이미지가 설정된 값보다 낮으면 Hole로 인식 Edge Mask Thickness Auto Exclusion mask로 검출된 테두리영역을 설정된 값으로 확대함 Select Image for Mask 테두리 검출을 위해 사용하는 이미지 소스 Size for Noise 검출된 테두리 영역이 설정된 값보다 작은 영역을 가지면 노이즈로 인식하여 테두리에서 노이즈를 제거함 Threshold Image 테두리 검출을 위해 사용하는 이미지 소스를 Auto Global Threshold를 적용하여 사용 Dynamic Threshold 테두리 검출을 위해 사용하는 이미지 소스를 Auto Local Threshold를 적용하여 사용 Extended Pad Mask Size 설정된 값으로 Pad를 확장하여 마스크로 사용 Use Solder Mask Pad 표면의 솔더를 인식하여 Exclusion Mask 로 사용 하도록 설정"
},
{
"toc_id": "chapter06_heading01_sub05_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "이물 티칭",
 "body": "※ 참고: 이물 티칭은 Bard board 또는 이물이 없는 깨끗한 PCB를 사용하십시오. 잡 생성 메뉴에서 이물티칭 아이콘을 클릭하십시오. Foreign Material Teaching Tool이 나타나면, Auto Cal 버튼을 클릭하여 IR 조명을 Calibration 합니다. 그런 다음, Start teaching for FM 버튼을 클릭하십시오. Teaching 완료 후, Teaching Tool이 자동으로 실행되면 Mask 이미지를 확인하십시오. 이미지에서 Hole 영역이 mask 처리되지 않은 경우, 'Thresholding' 값을 조절하여 Mask 영역을 설정하십시오. Apply to all FOVs 버튼을 클릭하여 전체 FOV에 적용합니다. 장비 바닥에서 발생하는 난반사나 센서의 빛 때문에 Hole 영역이 Masking 처리 되지 않은 경우, 마우스 왼쪽 버튼을 드레그하여 수동으로 Masking 처리를 할 수 있습니다. ※ 참고: 수동으로 Masking 처리된 영역은 검사 영역에서 제외되며, 한 FOV 내에 10개까지 가능합니다. ※ 참고: 생성된 User Mask는 위치 이동 및 크기 조절이 가능하며, Delete 키로 제거할 수 있습니다. Teaching Tool의 Source Select 메뉴창에서, 티칭된 RGB/IR 이미지를 선택하여 확인할 수 있습니다. Teaching Tool상단 메뉴의 Option 메뉴에서, Masking 관련 설정 값과 표시되는 Mask 색깔을 선택할 수 있습니다. Save 버튼을 클릭하고, 'Master Image'를 생성할지 묻는 메시지가 나타나면, '예'를 선택하십시오."
},
{
"toc_id": "chapter06_heading01_sub06_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "Mask Teaching Tool",
 "body": "이 장에서는 이물검사 기능에서 사용되는 Mask 영역 설정과 검사영역을 제외하거나 추가할 수 Mask Teaching Tool의 사용 방법에 대해 설명합니다. ※ 참고: Mask Teaching Tool을 실행하기 위해서는 SPIGUI에서 이물 검사가 가능한 상태이며, Foreign Material Teaching은 완료가 된 상태여야 합니다. 사용 방법 다음의 두 가지 방법으로 Mask Teaching Tool에 진입합니다. GUI &gt; Foreign Material Teaching Tool&gt; Mask Teaching 버튼을 클릭합니다. Foreign Material Teaching Tool 또는, GUI 메인 화면에서 장비가 Idle 상태일 때, 마우스 우클릭하여 나오는 팝업 메뉴에서 Mask Teaching Tool을 선택합니다. GUI 메인에서 Popup Menu Defect View에서 Defect List에 있는 항목을 선택 후, 마우스 우클릭하여 Add to mask를 선택합니다. GUI Defect View에서 Popup Menu 화면 구성 이 장에서는 Mask Teaching Tool의 화면 구성에 대해 설명합니다. 항목 설명 ① Select / Draw Mode Select: User Mask Move Draw: New/Add/Subtract (Rectangle, Circle) ② Zoom Control 슬라이드 바를 통한 확대/축소 ③ PCB Area Board Image 표시 검사영역/Mask 영역 표시(Pad, Panel, User Mask) ③-1: 복사 기능 (임의 위치 복사 / Panel 영역 복사) ④ Pattern Mask Tool 실행 이물 최적 검사를 위한 파타미터를 시뮬레이션 함 ⑤ Mask List Pad/Panel/User Mask 사용 유무 설정 Display Mask Color 설정 User Mask Delete 기능 Real Pad Mask Real Pad Mask는 Gerber Pad 영역이 아닌, 이물 티칭 중에 생성한 Pad 영역을 Pad Mask로 생성하는 기능입니다. 이 Real Pad Mask 기능을 사용하여 Pad Mask 영역을 생성하였으나 사용자가 원하는 영역과 맞지 않을 경우, 다시 Gerber Pad 영역으로 되돌려서 Mask를 편집할 수 있습니다. ※ 참고: Real Pad Mask Edit 기능에서는, Mask 영역을 삭제하는 기능은 제공하지 않습니다. Real Pad Mask 생성하기 Foreign Material Teaching Tool에서 Find Real Pad Area에 체크하고, 티칭을 시작하십시오. 티칭이 완료되면 Settings 탭에서 ‘Inspection Based on Real Pad ROI’를 선택하십시오. ※ 참고: Foreign Material Setting 창에서도 ‘Inspection Based on Real Pad ROI’ 옵션을 설정할 수 있습니다. 메인 화면에서 마우스 오른쪽 버튼을 클릭한 후, 아래와 같은 팝업 메뉴가 나타나면 Mask Teaching Tool을 실행하십시오. Gerber Pad Mask 영역으로 되돌리기 Real Pad Mask 영역에서 Gerber Pad Mask 영역으로 되돌리려면, Mask Teaching Tool 우측 상단의 설정 버튼을 클릭하십시오. Pad Mask Setting 메뉴가 나타나면, Change To Gerber Pad 버튼을 클릭하십시오. Real Pad Mask 편집 후 Panel 복사하기 Pad를 선택하고, Mask를 편집하십시오. 마우스 오른쪽 버튼을 클릭하면 나타나는 팝업 메뉴를 통해 선택한 Pad를 복사하십시오. Panel Pad Mask를 모두 복사하려면, 복사하고자 하는 Panel을 선택하십시오. 마우스 오른쪽 버튼을 클릭하면 나타나는 팝업 메뉴를 통해 Panel을 복사하십시오. Panel Mask 실제 PCB의 끝단(Edge)까지 이물 검사를 할 수 있도록, Pad 정보로 계산된 Panel 크기보다 조금 더 넓은 영역을 Panel 크기로 설정하여, 이물 검사 영역을 확장할 수 있습니다. ※ Panel Mask: Panel 안쪽은 검사 영역, 바깥쪽 영역은 검사 제외 영역으로 설정하는 기능 제약 사항 이물을 검사해야 하는 Panel의 크기가 변경되더라도 FOV Optimize는 진행하지 않습니다. FOV 검사를 하는 영역은 변경되지 않고, Panel Mask 영역이 변경됩니다. Extend Panel 영역 설정 시, FOV 검사 영역 바깥 부분을 설정하더라도 이물 검사를 하지 않습니다. 단, ‘Full Scan FOV Optimization’ 옵션을 사용하여 전체 PCB의 이물 검사가 가능합니다. Panel 영역을 조절 할 수 있는 범위는 0~20mm 입니다. 사용 방법 Mask Teaching Tool을 열고, Panel Mask 설정 버튼을 클릭하십시오. Panel Mask Setting 화면이 나타나면, ‘Use Extend Panel Size (Unit: mm)’ 항목에 체크한 후 확장하고자 하는 영역의 크기를 입력하십시오. 항목 설명 Use Extend Panel Size Panel 확장 기능 사용 여부 설정 수치 입력 확장하고자 하는 영역 크기 (단위: mm) Show FOV 현재 JOB 파일에 최적화된 FOV 영역 표시 Apply 입력한 수치를 적용 (확장 영역이 적용된 Panel 영역을 화면에 표시) Close 설정 화면 닫기"
},
{
"toc_id": "chapter06_heading01_sub07_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "이물 검사 설정",
 "body": "3D Inspector의 검사설정 메뉴를 클릭하십시오. 환경설정 메뉴의 검사옵션 탭에서 이물검사 설정을 할 수 있습니다. Use Foreign Material 패널의 안쪽에서 마우스 왼쪽 버튼을 더블 클릭하면, 우측에 'Inspect Method' 가 나타납니다. 항목 Default 설명 Use Foreign Material Unchecked 이물검사 사용여부 설정 Head to Use Dual1 Projection 방식 설정 Threshold 100 um 3D 이물의 최소 높이 Min Size (%, 1~100) 50 이물의 최소 면적 Min Length 1000 um 이물의 최소 길이 Min Distance 1000 um 두 이물 간의 거리가 설정값 이내 일 경우, 하나의 이물로 처리 PCB Margin 500 PCB 외곽 마진 : Top과 Bottom은 Height Guide를 고려하여 더 넓게 설정 Inspect Method 2D&amp;3D 이물 검출 방법 설정 2D ﻿ RGB 2D 검사로 검출 3D ﻿ 3D Height 검사로 검출 2D+3D ﻿ RGB 또는 3D에서 검출된 결과 모두 이물결함 처리 2D&amp;3D ﻿ RGB 및 3D에서 모두 검출된 결과만 이물결함 처리"
},
{
"toc_id": "chapter06_heading01_sub08_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "User Preset",
 "body": "User Preset 은 설정된 최적의 파라미터를 다른 JOB 및 장비에서 사용할 수 있도록 미리 Preset으로 등록할 수 있는 기능입니다. User Preset 기능을 사용하면 등록된 Preset을 로딩하면 해당 JOB에 적용할 수 있고, 적용된 파라미터는 개별 JOB에 저장됩니다. 설정 다음의 두 가지 방법을 통해 User Preset 기능을 설정합니다. Foreign Material Teaching Tool &gt; Settings 탭&gt; 우측상단의 아이콘을 클릭합니다. Foreign Material Teaching Tool 에서 Preset 설정 또는 Foreign Material Setting 창의 좌측 하단의 Preset Item Edit 버튼을 클릭합니다. Foreign Material Setting 창 Preset Item Settings 창이 팝업되면, Preset Item List, Preset Item Name, Paramater Settings 를 편집하고 Apply 버튼을 클릭합니다. User Preset 화면 No. 항목 설명 1 Preset item List 현재까지 생성된 Preset List를 보여주며, 최대 15개까지 생성 가능 2 추가/삭제(,) 추가/삭제 버튼을 통해 Preset Item을 추가/삭제 3 Preset Item Name 변경 생성된 Preset Item의 이름을 변경 4 Parameter Settings 편집 Preset Item별로 FM 설정을 저장 가능 5 Apply 현재 선택된 Preset Item을 Foreign Material Setting 창에 적용 - FM Setting에서 최종 적용을 하면 Foreign Material Setting 창에는 User Define으로 저장됨"
},
{
"toc_id": "chapter06_heading01_sub09_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "이물검사 실행",
 "body": "3D Inspector 상단 메뉴의 'FM' 버튼을 클릭하여 이물검사 기능을 켜십시오. 이물검사를 위한 설정을 한 후, 시작 버튼을 클릭하십시오. 이물검사가 실시되고, 이물 결함이 발생하면 FM Defect View가 나타납니다."
},
{
"toc_id": "chapter06_heading01_sub10_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "Pad FM 검사",
 "body": "이 장에서는 Pad FM을 설정 방법에 대해 기술합니다. ※ 참고: Pad FM 검사는 이물검사의 Teaching Data를 활용하여 검사를 진행하기 때문에 반드시 이물검사 데이터가 로딩된 상태이어야 합니다. 만약 이물검사를 적용 할 수 없는 상태이면 Pad FM 검사 결과는 모두 Good으로 판정됩니다. 설정 CEditor&gt; Pad 선택&gt; Edit 클릭합니다. GUI 또는 CEditor&gt; Inspection Condition&gt; Inspection Object 에서 ‘Pad FM’을 선택하고 확인을 클릭합니다. Pad FM Type 설정 Tolerance Setting 에서 Volume(3D)검사와 Area(2D) 검사를 설정합니다. 결함 확인 검출된 Defect error type은 Shape Error로 Defect View 에 표시됩니다. PCB Real Color image"
},
{
"toc_id": "chapter06_heading01_sub11_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "이물검사 에러 메시지",
 "body": "ErrCode 내용 해결 방법 3242 이물티칭 정보가 없거나 티칭 정보가 맞지 않을 경우 이물티칭 재실행 3243 그래픽카드가 이물검사를 지원하지 않거나 그래픽카드 버전이 잘못된 경우 NVIDA Quadro K2000 또는 K600인지 확인하고, 그래픽카드 드라이버를 최신으로 설치"
},
{
"toc_id": "chapter06_heading01_sub12_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "이물 검사",
 "title2": "이물 Defect 판정",
 "body": "보드 단위의 FMI Defect를 패널 단위로 변경하여, FMI Defect 검출 시 Defect View와 Defect Review에서 판정할 수 있습니다. 기존 Defect 결과와 FMI 판정한 패널의 결과를 MES 서버로 전송하며, Auto Export 파일 출력 시 결과를 확인할 수 있습니다. 사용 방법 KYConfig에서 ‘Foregin Material’과 ‘FMI Verify’ 옵션에 체크하십시오. FMI Defect 검출 시, Defect View와 Defect Review에서 FMI를 판정 할 수 있습니다. Defect View Defect Review"
},
{
"toc_id": "chapter06_heading02_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "KSMART Warp",
 "title2": "",
 "body": "KSMART Warp은 PCB에 휨(warpage)이나 수축(shrinkage) 등의 왜곡이 발생되었을 경우, 검사 위치를 보정하여 정확한 측정 및 검사를 가능하게 합니다. KSMART Warp은 Z축 방향 처짐을 보상하는 Z-tracking, XY offset을 보상하는 Pad Referencing과 Warpage Solution으로 구성됩니다."
},
{
"toc_id": "chapter06_heading02_sub01_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "KSMART Warp",
 "title2": "KSMART Warp 사용 장점",
 "body": "보드 휨 보상 (Z-tracking) 보드 휨이 발생한 경우, 다음 FO50V (Field of View)의 휨을 자동으로 계산합니다. 계산된 값을 기준으로 Z축을 움직여서 휨을 보상합니다. X,Y,θ Alignment 보상 (Pad Referencing) 보드 수축 현상이 보드 전체에 균일하게 발생한 경우(①), 피두셜로 X, Y ,θ 보상이 가능합니다. 하지만, 보드 수축 현상이 부분적으로 발생한 경우(②), 피두셜을 이용하여 X, Y, θ 보상이 불가능합니다. 이러한 문제점을 해결하기 위해서 PCB의 원형 또는 모서리의 동박 정보를 이용하여 부분적으로 발생한 수축 현상을 보상합니다."
},
{
"toc_id": "chapter06_heading02_sub02_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "KSMART Warp",
 "title2": "Z-tracking 사용 방법",
 "body": "기능 적용 및 적용변수 설정: 기능 설정 방법 및 적용변수 설정 설명 결과 확인: 기능이 올바르게 적용되었는지 확인 Z-Tracking 적용 GUI Main화면의 Z-Tracking 옵션을 클릭하십시오. Yes를 클릭하십시오. Z-Tracking 옵션이 녹색으로 바뀌면 기능 사용이 가능합니다. 결과 확인 측정된 PCB의 2D &amp; 3D의 이미지를 비교하여 Z-tracking 결과를 확인하십시오. Z-tracking 옵션 적용 후에 활성화되는 Warpage Viewer를 통해서 PCB 전체에 대한 휨 정도를 확인하십시오. Warpage Viewer는 GUI의 메인 화면의 Production 탭을 클릭하여 실행하십시오."
},
{
"toc_id": "chapter06_heading02_sub03_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "KSMART Warp",
 "title2": "Pad Referencing 사용 방법 (Smart Teaching)",
 "body": "JOB 파일 설정: 사용할 JOB 파일을 Pad Referencing용으로 설정 Pad Ref. Wizard: IR RGB 이미지를 획득 Teaching Tool: Smart Teaching 사용 방법 적용 방법 및 조건 설정: Pad Referencing 적용 방법 JOB 파일 설정 KSMART Teaching을 사용하기 위해서는 CEditor에서 JOB에 대한 설정이 선행되어야 합니다. 항목 설명 KSMART Warp Use KSMART Warp: GUI에서 Teaching에 필요한 Panel 및 Component 영역을 출력 Compensate Localize Warp: FPCB 보드일 경우에 체크하여 Teaching 을 할 수 있도록 설정 변경 Pad Referencing Wizard Pad Referencing Teaching에 필요한 IR &amp; RGB 이미지를 획득하기 위해 Wizard ()를 실행하십시오. 항목 설명 With Capturing Pad Referencing 실행 전 캡쳐 기능 사용 여부를 선택. KYPCB를 사용하지 않는 경우, PCB의 이미지 파일을 획득하기 위해서는 해당 기능을 선택해야 합니다. With current JOB file Pad Referencing 실행 시, 현재 JOB 파일을 자동으로 불러옴. Teaching bare board for PR Teaching 방법을 선택. 박스에 체크하면, Smart Teaching이 실행되고, 체크하지 않으면 KYPCB Teaching이 실행됨. Starting teaching for PR 체크박스에서 선택된 옵션을 실행함. Pad Referencing Teaching Tool을 자동 실행. Verification Start Teaching 완료 후, Pad Referencing JOB 파일을 불러오면 검증 작업을 진행 함. Test 현재 설정된 조명 값을 확인. Auto Cal IR조명 자동 Calibration을 진행 Pad Referencing을 진행할 Bare Board를 넣습니다. 현재 조명 설정 값을 확인하기 위해서 Test 버튼을 클릭하십시오. Pad Referencing을 진행할 PCB의 최적 밝기 값을 설정하기 위해서 Auto Cal 버튼을 클릭하십시오. Pad Referencing Teaching Tool을 자동실행하기 위해서 Start teaching for PR 버튼을 클릭하십시오. With Capturing을 선택했다면, 이미지 캡처를 자동으로 진행한 후, SPI Pad Referencing Teaching Tool이 실행됩니다. Pad Referencing Teaching Tool 화면 설명 항목 설명 Mask(Ideal) Image View Window 캡처된 PCB Mask 이미지 표시 Auto Teaching Teaching 시작 버튼 FOV Result List FOV 기준 Teaching된 결과 표시 Setup Teaching 조건 설정 사용 방법 Setup 버튼을 눌러 Teaching 조건을 설정하십시오. 항목 설명 Light Channel R, G, B, IR 조명 중 Teaching에 적합한 조명을 선택. Smart Teaching을 사용하는 경우에는 IR 조명을 선택하십시오. GOOD Pad Referencing 적용에 적합한 PCB인지를 판단할 FOV 성공 비율 FAIL Pad Referencing 적용에 부적합한 PCB이지를 판단할 FOV 성공 비율 Use Smart ‘Smart Teaching’ 진행 시 반드시 선택되어야 함 FPCB Board FPCB 보드사용 시 체크하십시오. Use Top Image Teaching중에 Pad를 검출하기 위해 Top Image 사용여부 선택. IR 이미지를 확인하여 Pad 부분이 난반사 문제가 없다면 체크하십시오. Use Ref. Data 여러 개의 패널로 구성된 보드의 패널 Reference 데이터를 생성하여 모든 패널에 복사하는 기능을 사용할 경우 Pad Referencing 품질이 더 좋아집니다. 1개의 패널로 구성된 일반 보드는 기존과 동일함. Use Localized FPCB 보드일 경우에만 활성화되며, 컴포넌트 별 또는 지역적으로 Feature 좌표를 보상해 주는 알고리즘임. ※ 참고: Setup의 기본 설정 값을 사용하는 것을 권장합니다. Auto Teaching 버튼을 눌러 Pad Referencing Teaching을 시작하십시오. Pad Referencing Teaching 진행 중 PCB 탭은 각 FOV 기준 Teaching된 결과를 표시하고, FOV 탭은 해당 FOV의 자세한 feature 정보를 표시합니다. 탭 항목 설명 PCB 탭 FOV FOV 정보를 표시 Result FOV Teaching 결과 Good, Warning, Fail 중 한 개의 결과를 표시 Count Feature로 설정된 개수 Uniformity Pad영역을 Feature가 보상한 정도를 표시 Max 설정된 Feature 중 가장 높은 Score Min 설정된 Feature 중 가장 낮은 Score FOV 탭 Score Feature의 Ideal과 Real의 검출 정확도 Type Feature의 속성을 표시. Corner, Circle로 구성 Offset X Feature의 Ideal과 Real의 X 좌표 차이 값 표시 Offset Y Feature의 Ideal과 Real의 Y 좌표 차이 값 표시 Pad Referencing Teaching이 끝나면 다음과 같은 결과 값 창이 팝업합니다. ※ 참고: 현재 Smart Teaching 방법은 KYPCB(거버) 파일을 사용하지 않습니다. 찾은 Feature의 좌표를 정확하게 등록하기 위해서 JOB 파일의 Ideal Pad와 실제 Pad의 상관관계를 확인하여 보상을 진행합니다. 보상된 Feature는 CAD data와 이론적으로는 같으며, 보상을 실패한 Feature 데이터는 현재 보드의 상태에 따라 CAD data와 비슷할 수도 있고 다를 수도 있습니다. ※ 참고: 위와 같이 보상이 실패한 Feature가 존재할 경우 아래와 같은 메시지 박스가 나타납니다. 실패한 Feature를 그대로 사용할 경우 Warpage 및 Shrinkage가 없는 보드로 Teaching을 진행하며 보드 상태를 확인한 후 사용자가 Teaching을 다시 진행할지 결정해야 합니다. Teaching 결과가 Warning 이상이고 Teaching Score가 100%이면 Pad Referencing을 사용하기에 적합한 보드입니다. ‘OK’ 버튼을 누르십시오. 모든 FOV에 Pad Referencing을 적용할지 선택한 후 Teaching을 종료하십시오. Pad Referencing 적용 방법 및 조건 설정 JOB 파일을 다시 Load하여 Pad Referencing Teaching 데이터를 불러오십시오. 메인 화면의 Pad Referencing 옵션을 클릭하십시오. Yes 버튼을 클릭하십시오. Pad Referencing 옵션이 녹색으로 바뀌면 기능이 가능합니다."
},
{
"toc_id": "chapter06_heading02_sub04_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "KSMART Warp",
 "title2": "Warpage Solution Tool 사용 방법",
 "body": "Warpage Solution 기능은 고영테크놀러지 SPI 시스템의 Offset 보정을 통해 검사 정밀도를 높이는 기능입니다. Warpage Solution 기능 사용을 사용하려면, 아래의 순서대로 설정해주십시오. CEditor를 실행하십시오. Tools &gt; Convert Job File Version 메뉴를 선택하십시오. ※ 참고: Warpage Solution 기능은 Job 2.0 버전에서만 지원합니다. KY-3030을 실행하십시오. Setting &gt; Engineers &gt; Inspection Style &gt; Use Warpage Solution 옵션을 체크하십시오. Screen Layout Warpage Solution Teaching Tool은 기본적으로 아래 4 가지 메인 탭으로 구성됩니다. Feature List 탭 Group List 탭 PCB Data 탭 Verification 탭 Feature List 탭 Feature List 탭은 Warpage Solution Teaching Tool을 실행하면 가장 먼저 나타나는 화면으로 아래와 같이 구성되어 있습니다. 항목 설명 Feature List Feature의 정보 List Feature Parameter Feature 검사를 위한 Parameter Image Feature의 검사 결과 이미지 Test Feature 수동 검사(Feature, Selected FOV, All FOV) FOV Optimize FOV Optimize 진행(Normal, Panel Optimize, 한방향 Panel Optimize) Apply 변경된 Feature parameter를 저장(Selected Feature, All feature) Group List 탭 Group List 탭은 아래와 같이 구성되어 있습니다. 항목 설명 Group List 설정된 Group의 List 정보 Group Data 설정된 Group 정보 PCB Data 탭 PCB Data 탭은 아래와 같이 구성되어 있습니다. 항목 설명 Quick Setting Quick setting의 설정에 따라 Compensation 파라미터 정보가 자동으로 설정 PCB Data FOV: 총 FOV 수 Panel: 총 Panel 수 Group: 설정된 Group 수 Feature: 총 Feature 수 User Defined Feature: 총 임의 Feature 수 Compensation Method Offset Compensation: Solder 측정 후 Offset 보정 ROI Compensation: Solder 측정 전 ROI 보정 Waiting Max FOV count: ROI 보정을 위해 Matrix 모델을 만들 때 까지 대기하는 FOV의 수 Enhance Model: 정밀도가 높은 보상 모델로 보정하는 옵션 Parameter Model: 측정 위치 보상 모델 종류(Similarities, Affine, Projective) Minimum feature count: 모델 생성을 위한 최소 Feature 개수 Grouping way: 모델 적용을 위한 Group Offset limit: Feature를 검출할 수 있는 최대 Offset Use translation Model: Offset 보정 Model Verification 탭 Verification 탭은 아래와 같이 구성되어 있습니다. 항목 설명 Verification 정보 List Verification이 진행된 후 Pad와 Feature의 정보 리스트 Information Pad에 대한 보상 정보 리스트 Featue Information Featue의 검사 정보 리스트 Image 검사 결과 이미지 Warpage Solution Tool 사용 순서 Warpage Solution 기능을 사용하는 순서는 아래와 같습니다. Back Ground Image 생성(선택사항) Feature 등록 Feature 등록(Local Fid) User Defined feature 등록을 위한 Pad Matching(선택사항) User Defined feature 등록(선택사항) 등록된 Feature의 검사 설정 변경 보상 그룹 설정(선택사항) Verification Back Ground Image 생성 3D Inspector를 실행하십시오. Job Creation &gt; Local Fiducial 메뉴를 선택하십시오. Image Scan 대화상자에서 Start Scan 버튼을 클릭하십시오. PCB 전체를 캡쳐하여 실사 이미지를 표시합니다. Image Scan 창을 닫으면 ‘Warpage Solution Teaching’ 도구가 표시됩니다. Feature 등록 Feature List 탭을 클릭하십시오. Warpage Solution Tool이 실행되면 ‘View Mode’가 ‘Expected Compensation Level’로 표시되며 보상강도에 따라 색상으로 PCBview에 표현됩니다. 표시된 보상강도를 참고하여 Feature 등록을 진행하십시오. Feature로 변경할 Pad를 마우스 오른쪽 버튼으로 클릭한 후 Pad &gt; Feature 메뉴를 선택하십시오. &lt;User Defined Feature 등록&gt; 임의 Feature를 등록할 위치에서 마우스 오른쪽 버튼을 클릭한 후 User Defined feature 메뉴를 선택하십시오. 'Light Source' 항목에서 조명을 변경하여 Pad가 확연히 구분되는 조명을 선택하십시오. 실제 이미지와 Pad의 좌표가 다를 경우에는 Pad를 클릭한 후 드래그하여 실제 이미지로 이동하십시오. 등록을 하려는 Feature의 모양, 색상, 검사 방법에 따라 'Shape, Color, Method' 항목을 설정하십시오. ADD 버튼을 클릭하여 'User Defined Feature'를 등록하십시오. Apply 버튼을 클릭하여 등록한 ‘User Defined feature’를 저장하십시오. Corner Feature 검출 알고리즘 추가 ‘User Defined Feature’에서 기존의 Rect/Circle/Pattern Matching으로는 정확한 오프셋 보정이 되지 않는 경우, PCB의 Corner(90 degree)를 Feature로 설정할 수 있도록 Corner 형상이 추가되었습니다. User Feature Teaching Tool이 나타나면, Shape 항목을 ‘Corner’로 선택하십시오. 아래와 같이 90도의 Corner Point가 ROI의 중앙에 오도록 하여, ROI를 정사각형모양으로 그리십시오. 가로선이 0°10°를 벗어나거나 세로선이 90°10°를 벗어나면 Feature를 검출하지 못하며, 티칭 후 Feature Test를 진행할 때 아래와 같이 Corner가 유지될 수 있도록 Threshold를 조정하십시오. Feature Test 시, 아래와 같이 빨간색 십자가가 정확히 코너에 표시되면, 올바르게 인식된 것입니다. &lt;다른 Panel의 동일 위치 Pad를 Feature로 등록&gt; Copy feature Selected Pad To other Panel를 선택하십시오. 선택된 Feature를 다른 Panel에 복사할 수 있습니다. Copy feature Selected Panel To other Panel를 선택하십시오. 선택된 Panel의 모든 Feature를 다른 Panel에 복사할 수 있습니다. 등록된 Feature의 Teaching Test(All FOV) 버튼을 클릭하여 PCB 전체의 'Feature'에 대해 검사를 진행하십시오. Score가 낮은 항목에 대하여 검사 조건을 변경해가며 최적화를 진행합니다. 보상 그룹 설정 Group List 탭을 클릭하십시오. 그룹 내 보상이 필요한 영역을 드래그한 후 마우스 오른쪽 버튼을 클릭하여 Add Warpage Solution 메뉴를 선택하십시오. Verification Warpage Solution Teaching 창에서 Verification 버튼을 클릭하십시오. Start 버튼을 클릭하여 'Verification' 검사를 완료한 후에 실제 보상된 PAD의 정보와 검사된 Feature 정보를 확인하십시오. ※ 참고: 검사 결과에 대한 보상 강도 Trend는 KY-3030의 메인 화면과 SPCPlus &gt; PCBView에서도 확인이 가능합니다. &lt;KY-3030에서의 보상강도 Trend&gt; &lt;SPCPlus에서의 보상강도 Trend&gt;"
},
{
"toc_id": "chapter06_heading03_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Not Populated Components",
 "title2": "",
 "body": "Not Populated Components 기능은 Defect 발생 시, 마운터에서 부품이 실장되지 않는 패드들에 대해서 부품이 실장되는 패드들과 구별하여 판정할 수 있도록 도와주는 역할을 합니다. 이 기능을 사용하면, 불량 발생 시 부품이 실장되지 않는 Pad 들에는 별도 아이콘으로 표시해 주거나, 불량 발생 시 미리 설정한 불량 항목에 해당하지 않는 불량인 경우 자동으로 Pad의 검사결과를 GOOD으로 변경할 수 있습니다 . ※ 참고: BOM에 등록되지 않은 패드는 마운터에서 부품이 실장되지 않으므로 엄격하게 관리할 필요가 없습니다. ※ 참고: BOM 목록은 부품 이름 정보를 포함하고 있어야 합니다."
},
{
"toc_id": "chapter06_heading03_sub01_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Not Populated Components",
 "title2": "CEditor 설정",
 "body": "CEditor를 실행하고, JOB 파일을 로드하십시오. Tool &gt; Not Populated Components 메뉴를 선택하십시오. Not Populated Components 창이 나타나면, Separator 옵션에서 BOM 파일에서 사용하는 구분자를 설정하십시오. Open 버튼을 클릭 후, BOM 파일을 선택하여 로드합니다. Apply Type 항목에서 적용 타입을 선택하고, Inspection Item 항목을 설정합니다. Display Only: 부품이 실장되지 않는 Pad 에서 불량이 발생할 경우 아이콘으로 표시만 합니다. Change Result: 부품이 실장되지 않는 Pad 에서 불량이 발생할 경우 ‘Inspection Item’ 에서 설정되지 않은 불량이 발생할 경우 검사 결과를 GOOD 으로 자동으로 변경합니다. Display &amp; Change Result: 부품이 실장되지 않는 Pad 에서 불량이 발생할 경우 아이콘으로 표시도 해주고 ‘Inspection Item’에서 설정되지 않은 불량이 발생할 경우 검사 결과를 GOOD으로 자동으로 변경합니다. Component Info 항목에서 Component 개수가 아래와 같이 표시됩니다. Component Count of Job: JOB 파일 상에 저장되어 있는 Component 개수 Component Count of BOM: BOM 파일에 존재하는 실장되는 Component 개수 현재 로드한 BOM 파일 정보를 추가하려면, Add 버튼을 클릭하여 추가합니다. 기존에 사용하던 BOM 파일을 삭제하려면, 삭제할 BOM 파일을 선택한 후 Delete 버튼을 클릭하여 삭제합니다. Inspection item 항목 변경 후 Edit 버튼을 클릭하면 현재 설정되어 있는 Inspection Item 항목 정보가 갱신되며, Change Result 옵션 사용시에 선택되어 있는 Inspection Item 에 해당하는 불량 발생시 DefectView 에서 불량정보를 출력합니다. Inspection Item 에 체크되지 않은 불량이 발생하면, Defect View 에 표시되지 않으며 Pad 검사결과도 ‘GOOD’ 으로 변경됩니다. BOM List에서 마우스 오른쪽 버튼을 클릭하면 나타나는 팝업 메뉴를 이용하여, 컬럼 유형을 변경할 수 있습니다. Apply 버튼을 클릭하여 설정한 정보가 JOB 파일에 저장하십시오. BOM 추가가 완료되면, GUI에서 JOB 파일을 다시 로드하십시오."
},
{
"toc_id": "chapter06_heading03_sub02_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Not Populated Components",
 "title2": "기능 사용",
 "body": "3D Inspector의 Setting &gt; Inspection 메뉴를 선택하면 Setting 창이 나타납니다. Setting 창에서 Inspection Options &gt; Functions 탭에 있는 Use Not Populated Component 항목을 선택하십시오. JOB 파일 선택 창에서, 검사를 진행할 JOB 파일을 선택합니다. 이 때, CEditor에서 Not Populated Component 리스트를 저장한 JOB 파일을 선택하십시오. JOB 파일 선택 후 나타나는 Input Production Quantity 창에서, BOM 목록과 Apply Type을 선택하십시오. 검사 진행 중, BOM 상에 존재하는 Component에서 불량이 발생한 경우 Apply Type에서 설정한 옵션에 따라 불량 정보가 표시됩니다."
},
{
"toc_id": "chapter06_heading04_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "User Defined Base 기능",
 "title2": "",
 "body": "User Defined Base 기능은 도포된 납의 높이 측정에 있어 기준이 되는 바닥면을 사용자가 설정할수 있도록 하여, 검사 정확도를 향상시키고자 하는 기능입니다. 이 기능을 적용하려면 아래와 같은 절차가 필요합니다. Step1(ePM, CEditor): Job 생성 및 변경 Step2(CEditor): 검사 옵션 변경 Step3(3D Inspector): User Defined Base 적용"
},
{
"toc_id": "chapter06_heading04_sub01_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "User Defined Base 기능",
 "title2": "Job 생성 및 변경",
 "body": "Gerber 파일의 위치와 크기는 실제와 다른 경우가 있습니다. 특히, Dot 형태의 Epoxy의 경우에는 실제 위치와 많이 다르므로 ePM-SPI를 이용한 수정이 필요합니다. Gerber Shape을 변경하려면, 아래의 절차대로 수행하십시오. ePM-SPI를 실행한 후, 상단의 Table 메뉴에서 Aperture를 선택하십시오. Apeture List에서 해당 변경하고자 하는 Circle을 선택한 후, Edit 버튼을 클릭하십시오. Edit Gerber Object 창이 팝업하면, Shape 또는 크기를 변경할 수 있습니다. Gerber의 위치를 변경하려면, 아래의 절차대로 수행하십시오. ePM-SPI를 실행한 후, 상단의 Edit메뉴에서 Move를 선택하십시오. 화면 우측 패널에서 Options 탭을 선택한 후, 이동하고자 하는 항목을 선택하십시오. 우측 패널 중간에 있는 조그버튼을 이용하여, 원하는 방향으로 선택한 항목을 이동할 수 있습니다."
},
{
"toc_id": "chapter06_heading04_sub02_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "User Defined Base 기능",
 "title2": "검사 옵션 변경",
 "body": "보드는 크게 3부분 (Solder, Epoxy Rect, Epoxy Dot)의 측정 대상물로 이루어지며, 각 대상별로 특성에 맞는 검사 속성을 설정해야 합니다. Epoxy Dot: 높이가 600um 정도로 다파장을 적용해야 측정이 가능 Expoxy Rect: 투명성으로 인해 검사 신뢰지표인 Visibility 수치가 매우 낮음 Solder: ROI가 너무 크면 주변 사출물들이 들어와 과납의 우려가 있음 ※ 참고: 각 Pad 별 검사 속성 기능은 Job Version 2.0에서 가능합니다. 각 측정 대상물의 특성에 맞게 검사 옵션을 변경하려면, 아래와 같이 수행하십시오. CEditor를 실행하고, 대상물을 선택한 후 Edit 버튼을 클릭하십시오. Change PAD Inspection Conditions 창이 나타나면, 각 대상물의 특성에 맞게 아래 항목들을 설정하십시오."
},
{
"toc_id": "chapter06_heading04_sub03_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "User Defined Base 기능",
 "title2": "User Defined Base 적용",
 "body": "Panel 확인 및 설정 Panel 단위로 나뉘어져 있을 경우에는 한 Panel에 적용한 후 다른 Panel에 User Base를 동일하게 복사 할 수 있습니다. CEditor에서 Panel를 선택하십시오. PAD Inspection Condition 창에서 'Panel Number'를 설정하십시오. User Defined Base 설정 3D Inspector에서 검사를 실행하여 Real Color Background를 생성하십시오. 적용 시키려는 Panel로 Zoom in 하십시오. User Base를 설정하고자 하는 Pad들을 선택하십시오. 선택된 Pad는 파란색으로 highlight 되어있습니다. Pad 선택 후 마우스 오른쪽 버튼을 클릭하여 Add Pad Base 옵션을 선택하십시오. ※ 참고: Add Pad Base를 선택하려면 선택 영역이 유지되어야 합니다. Panel 안의 User Base를 모두 설정하십시오. 생성되는 Base는 기준 평면으로 최대한 안정적인 영역을 선택합니다. Apply Pad Base to All Array를 선택하면 작업된 사항을 모든 Panel에 적용할 수 있습니다. ※ 참고: 작업 후 반드시 Pad Base Mode Release를 클릭해야 다른 기능들이 활성화 됩니다. 아래 부분에도 동일한 작업을 반복해서 실시하십시오. Panel 세분화 CEditor에서 Panel를 선택하여 보상이 되는 기준 단위를 선택하십시오. Pad Inspection Condition 창을 열고 'Panel Number'를 지정하여 8개의 Panel을 16개로 나누십시오. Vision Parameter 설정 설정 사항이 적용 될 수 있도록, 3D Inspector에서 JOB 파일을 다시 로드하십시오. Vision Parameter &gt; Condition2 탭 &gt; User Defined Base 검사 옵션을 설정하십시오. 각 설정항목에 대한 설명은 아래와 같습니다. 항목 설명 Method No: User Defined Base 미적용 Plane: 기준 평면으로 Base 정렬 Average: User Base의 평균 값으로 정렬 Use a Component plane 동일 Panel에 속한 User Base를 이용하여 대표되는 기준 평면을 만들고 이 Panel에 속한 모든 Pad들의 Base 정렬에 이용 Z Axis Range of Plane 기준 평면을 생성할 때 최적의 값을 선택하기 위한 조건으로 보상되는 영역의 Maximum Warpage 값을 의미"
},
{
"toc_id": "chapter06_heading04_sub04_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "User Defined Base 기능",
 "title2": "User Defined Base 보상 효과",
 "body": "반복성 향상 User Define Base 기능을 적용하면 반복성의 평균 및 Max 값을 향상할 수 있습니다. 정확도 향상 단일 ROI의 Base를 사용하였을 때는 Pad의 Base 위치 보상이 잘못되는 경우가 생길 수 있지만 User Base 적용 후에는 이러한 현상이 사라집니다."
},
{
"toc_id": "chapter06_heading05_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Barcode Label 출력 기능",
 "title2": "",
 "body": "이 기능은 SPI 시스템과 라벨 프린터를 연결하여 NG나 PASS 결과를 추적할 수 있도록 Barcode Label을 출력하여 해당 보드에 부착할 수 있는 기능입니다."
},
{
"toc_id": "chapter06_heading05_sub01_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Barcode Label 출력 기능",
 "title2": "Barcode Label 설정",
 "body": "KYConfig 에서 Code Input '2000' 입력 하십시오. Zebra Printer Setup 창이 나타나면, Use Printer 항목을 선택하십시오. 장비에 라벨 프린터와의 연결을 위한 시리얼 Comm을 설정하십시오. Label Printer를 하기 위한 기본적인 셋팅(원점, 위치, 크기, 수량) 값을 입력하십시오. Test 버튼을 클릭하여 실제 라벨 프린터에 바코드가 출력 되는지 확인하십시오. 장비의 Line 번호를 입력하십시오. 라벨 프린터 하기 위한 Output Type을 설정하십시오."
},
{
"toc_id": "chapter06_heading05_sub02_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Barcode Label 출력 기능",
 "title2": "Barcode Label 실행",
 "body": "검사를 실시하십시오. Defect View에서 NG 또는 PASS를 판정하십시오. Output Type 설정에 따라 NG 나 PASS일 때 라벨 프린터기로 바코드를 출력하십시오. 바코드 출력 파일 14 자리는 아래의 규칙을 따르십시오. 'Digit 1 = Line No. 'Digit 2 = Device No. Ex) SPI = 1 , AOI = 2 'Digit 3+4 = Year [YY] Ex) 2014 = 14 'Digit 5+6 = Month [MM] 'Digit 7+8 = Day [DD] 'Digit 9+10 = Hour [HH] 'Digit 11+12 = Minutes [MM] 'Digit 13+14 = Seconds [SS]"
},
{
"toc_id": "chapter06_heading06_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "KSMART Printer Optimizer(KPO)",
 "title2": "",
 "body": "KSMART Printer Optimizer(KPO)기능은 프린터 파라미터 변경 시점을 기준으로 솔더 측정 값의 변화를 시각적으로 보여주어 신규 모델 생산 시 프린터를 초기 설정 할 때 효율적으로 설정을 도와주는 기능입니다. 이 기능은 Printer Guidance Tool 창에서 사용할 수 있으며, 해당 창은 Printer Optimizer와 Printer Optimizer History 탭으로 구분됩니다. 각 탭에 대한 설명은 다음을 참조해 주십시오."
},
{
"toc_id": "chapter06_heading06_sub01_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "KSMART Printer Optimizer(KPO)",
 "title2": "Printer Optimizer 탭",
 "body": "Printer Optimizer 탭은 다시 Settings, Interest Group Result, PCB Result의 하위 탭으로 나뉩니다. Settings 탭 Settings 탭에서는 관심그룹 설명 및 프린터의 파라미터를 입력할 수 있으며, 항목별 상세 설명은 다음과 같습니다. 항목 설명 1 PCB에 저장되어 있는 그룹 및 부품(component)정보 표시 Add to I.Group 버튼: 선택한 그룹 혹은 부품이 속한 Pad 전체를 맨 하단 의 KPO Group 으로 설정 2 + 버튼: PCB View 에서 현재 선택되어 있는 패드를 KPO Group 으로 설정 버튼: 아래의 KPO Group 리스트 중 선택된 그룹을 제거 Set to I.Group 버튼: 아래의 KPO Group 에서 관심 그룹으로 설정하려는 그룹을 체크한 후 버튼 클릭 시 관심 그룹으로 설정 (최대 4개까지 가능) 3 Save Group Data 버튼: 현재 설정되어 있는 KPO Group 및 관심 그룹 정보를 JOB 파일에 저장 4 검사를 진행할 PCB 개수 입력 (단축키: F2) 5 현재 프린터의 각 파라미터 입력란 + 버튼을 눌러 현재 값을 템플릿으로 저장 가능 파라미터 변경 시 변경 이유를 입력/저장 6 GUI 검사 시작 버튼 (단축키: F3) Interest Group Result 탭 Interest Group Result 탭에서는 Settings 탭에서 설정한 관심그룹의 검사 결과를 차트로 볼 수 있으며, 각 PCB의 검사 시작 전 변경된 프린터 파라미터의 현재 설정내역도 확인할 수 있습니다. 항목 설명 1 PCB 검사 시작 전 사용자가 변경한 프린터 파라미터가 표시 아이콘을 누르면, 변경 시 입력한 메모를 확인할 수 있음 2 사용자가 설정한 관심 그룹에 속한 패드들의 검사 결과를 보여주는 차트 Volume, Height, Area, Offset 을 확인할 수 있음 3 선택한 관심 그룹에 속한 패드들의 검사 결과 평균값을 표시함 4 현재 설정된 프린터 파라미터를 표시함 사용자가 프린터에서 변경한 파라미터 값을 직접 입력 가능 검사가 진행되고 있는 도중에는 파라미터를 변경할 수 없음 PCB Result 탭 PCB Result 탭에서는 PCB의 전체 검사 결과, 검사 값들의 Cp, Cpk 값, 검사 시작 전 변경된 프린터 파라미터의 변경 내역등을 확인 할 수 있습니다. 항목 설명 1 PCB의 휨정도(Warpage)를 히스토그램으로 표시 2 PCB 검사 결과를 히스토그램으로 표시 3 PCB 를 영역 별로 나눠 PCB의 평균 검사 값이 설정 값 이상으로 차이가 나는 영역을 시각적으로 표시 4 PCB 전체의 오프셋값을 표시"
},
{
"toc_id": "chapter06_heading06_sub02_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "KSMART Printer Optimizer(KPO)",
 "title2": "Printer Optimizer History 탭",
 "body": "Printer Optimizer History 탭에서는 Printer Optimizer 탭에서 변경한 프린터 파라미터의 변경사항을 확인하고, 변경 시점을 기준으로 변경 전,후의 검사 결과값을 차트 형식으로 볼 수 있습니다. 항목 설명 1 프린터 파라미터의 변경 내역을 검색할 기간 설정 2 검색된 파라미터의 변경 항목을 붉은 색으로 표시 변경 항목을 더블클릭하면 스크린 하단에 설정된 보드 수에 다라 검사 결과가 표시 3 페이지 상단(②)에 표시되는 파라미터 변경 항목을 더블클릭하면 표시됨 우측 상단의 Search Count 를 변경하여 PCB 매수를 설정 가능 변경 전/후의 차트 색을 다르게 표시하여 프린터 파라미터 변경에 따른 검사 결과의 변화를 쉽게 파악할 수 있음 PCB 영역 분할 및 UCL/LCL 설정 Printer Optimizer Hisotry 화면의 좌측 하단의 Settings 버튼을 클릭하면, PCB 영역 분할(Board Trend Setting) 및 UCL/LCL 설정을 변경할 수 있습니다. 각 설정에 대한 자세한 설명은 다음과 같습니다. Board Trend Setting (PCB 영역 분할) PCB를 여러 영역으로 나누어 어느 영역에서 프린터에 문제가 발생하는지 확인할 수 있도록 설정 (4x4, 6x6, 8x8 옵션) 각 영역 간 결과 차이의 제한 값(Limit for Value Diff.)을 설정하면, 다른 영역과 비교했을 때 차이가 제한치를 넘는 경우 시각적으로 트렌드뷰에 표시 UCL/LCL Setting 전체 PCB와 각 관심 그룹 별 검사 결과의 UCL, LCL, USL, LSL 값을 설정"
},
{
"toc_id": "chapter06_heading06_sub03_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "KSMART Printer Optimizer(KPO)",
 "title2": "설정방법",
 "body": "KYConfig&gt; ETC&gt; 우측 하단의 Use KPO 체크박스를 선택하십시오. 3D Inspector 메인 화면&gt; Job Creation 탭&gt; KPO 버튼을 클릭해 KPO Window로 진입합니다."
},
{
"toc_id": "chapter06_heading07_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Auto Verification",
 "title2": "",
 "body": "Auto Verification 기능은 장비 상태(2D/3D조명, PZT이송량, Reference체크, Height/Offset체크)를 주기적으로 자동 검증하여 사용자에게 장비의 상태를 알려주고 적절한 조치를 취할 수 있도록하여 장비가 정상 상태에서 검사를 수행할 수 있도록 도와주는 기능입니다."
},
{
"toc_id": "chapter06_heading07_sub01_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Auto Verification",
 "title2": "설정 방법",
 "body": "KYConfig를 실행하고, 우측 하단의 Auto Verification Target Exist 옵션에 체크합니다. ※ 참고: 사용자 레벨에 따라 위 옵션은 숨김처리 될 수 있습니다. 이 옵션을 사용하려면, 고영 담당자에게 문의하십시오. GUI&gt; Setting&gt; Inspection&gt; Engineers&gt; Auto Verification 으로 이동합니다. 항목 설명 Setting 기능 동작 관련 설정 값 변경 버튼 Excute Auto Verification 기능 시작 버튼(수동 동작) History Verification 결과를 차트로 보여주는 버튼"
},
{
"toc_id": "chapter06_heading07_sub02_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Auto Verification",
 "title2": "Setting 버튼 ",
 "body": "Setting 버튼을 클릭하여 팝업되는 Auto Verification Setting 창에서는 기능 동작관련 설정 값을 변경할 수 있습니다. 항목 설명 Use Auto Verification 체크박스 기능 동작 On/Off 항목별 탭 Scheduling, Bright Setting, PZT and Height Setting, Target 탭에서는 각 항목별 설정 값을 변경 Show Message after Job Loading 체크 시, Job Loading 이 끝난 후 기능 실행 여부를 묻는 창이 나타남 Show Result after Verification Success 체크 시, 기능 동작 완료 후 결과가 Good 일 경우에도 결과 창이 팝업 됨 각 항목별 탭에 대한 설명은 다음과 같습니다. Scheduling 탭 Scheduling 탭에서는 Step 1, Step 2, Step 3을 통해 기능 동작 주기를 설정할 수 있습니다. Bright Setting 탭 Bright Setting 탭에서는 조명 밝기 값을 설정할 수 있습니다. 항목 설명 Use Bright Verification 조명 밝기 Verification On/Off 3D/2D Lights 각 조명 별 기준 Gray 값 Bright Acceptance Range 각 조명 별 기준 Gray 값을 기준으로 Warning / Error 범위를 +/- 로 설정 Import from KYCal Recipe KYCal의 레서피 파일을 선택하여 해당 파일의 설정 값을 가져올 수 있음 PZT and Height Setting 탭 PZT and Height Setting 탭에서는 PZT 이송량과 높이 값을 설정할 수 있습니다. 항목 설명 Use Height Verification FOV 영역 별 Height Verification On/Off Offset 탭 Offset 탭에서는 FOV 영역 별 Offset Verification 기능과 Offset값을 설정할 수 있습니다. 항목 설명 Use Offset Verification FOV 영역 별 Offset Verification On/Off Initial Offset Verification Target 의 원점 설정 후 측정한 FOV Center의 Offset Error Limit 측정된 Offset 값의 에러 제한값 (X, Y 공통) Warning Limit 측정된 Offset 값의 경고 제한값 (X, Y 공통)"
},
{
"toc_id": "chapter06_heading07_sub03_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Auto Verification",
 "title2": "Execute 버튼",
 "body": "기본적으로 Auto Verification 기능은 스케줄 설정을 통해 자동 검증이 수행되지만, 수동 동작도 가능합니다. 해당 기능의 수동 동작은 하기 화면의 Execute 버튼을 클릭하면 수동으로 기능이 동작합니다. ※ 참고: 장비에 PCB가 감지되고 있을 때는 해당 기능은 동작되지 않습니다. Auto Verification의 수동 동작이 완료되면 장비는 정지 상태로 변경되며, 설정된 옵션 및 작동 결과에 따라 하기의 결과 표시창이 팝업됩니다."
},
{
"toc_id": "chapter06_heading07_sub04_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Auto Verification",
 "title2": "History 버튼",
 "body": "Auto Verification 기능의 작동 내역은 History 버튼을 클릭해 확인 할 수 있습니다. History 결과창은 다음과 같습니다. &lt;검사 결과 History 창&gt; 항목 설명 Select and View Latest 박스에 숫자를 입력한 후, Select and View 버튼을 클릭하면 입력한 숫자에 해당하는 최근 결과 내역이 차트로 표시됨 View 왼쪽의 리스트에서 Control 혹은 Shift 키를 이용하여 원하는 항목을 선택 후 View 버튼을 누르면 선택된 항목들에 대한 동작이력이 아래와 같은 차트로 표시됨 붉은색 선: 에러 제한값 주황색 선: 경고 제한값 파란색 선: 기준값 (파란색 선에 가까울수록 좋은 결과) 위 화면에서 우측 상단에 표시되는 리스트의 각 칼럼명을 클릭하면, 클릭된 항목만 차트에 표시됨"
},
{
"toc_id": "chapter06_heading08_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Library Manager@KSMART",
 "title2": "",
 "body": "이 장에서는 고영테크놀러지의 모든 시스템에서 사용되는 JOB 파일과 검사속성 Policy, 사용자 권한 등을 관리할 수 있는 Library Manager와 SPIGUI 프로그램의 연동에 대해 설명합니다. SPIGUI 프로그램에서 Library Manager 서버로 업로드 및 공유하는 파일은 다음과 같습니다. JOB 파일 Policy 파일(CEditor의 library 와 동일한 개념) Part Policy Size Policy Default Policy 이미지 파일 티칭 데이터 BBT BBT with Segmentation GBBT Foreign Material ※ 참고: Library Manager에 대한 자세한 설명은 Library Manager SPI 매뉴얼을 참조하십시오."
},
{
"toc_id": "chapter06_heading08_sub01_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Library Manager@KSMART",
 "title2": "설정 방법 ",
 "body": "이 장에서는 SPI 프로그램에서 Library Manager 기능을 사용하기 위한 설정방법을 설명합니다. KSMART Agent를 설치합니다. Web Manager 로그인 화면 하단에 있는 Agent Download를 클릭하십시오. 장비 타입에 알맞은 Agent 설치 파일의 링크를 클릭하여, 파일을 다운로드 하십시오. 다운로드한 Agent 설치파일을 실행하면, KSMART Agent 설치가 시작됩니다. KSMART Agent를 설치화면이 나타나면, 설치가 완료될 때까지 Next 버튼을 클릭하여 설치를 완료하십시오. ※ 참고: KSMART Agent가 정상적으로 설치되면, 윈도우 작업표시줄에 KSMART Agent 트레이 아이콘이 표시됩니다. KSMART Library Manager 에서 계정을 생성합니다. (LM 서버에서 @KSMART V1.1버전 이상) KYConfig&gt; Code input&gt; “6701” 입력&gt; Use library manager 선택 Default Job path를 설정합니다. Save 버튼을 클릭합니다. Library Manager 창 항목 설명 Use Library manager LM 전체의 사용 여부 설정 LM user login LM 사용자 로그인 기능 사용 여부 설정 LM Save/Load job file LM 잡파일 관리 기능 사용 여부 설정 LM Policy control LM 검사 속성 관리 기능 사용 여부 설정 LM Real time monitoring LM 실시간 장비 상태 관리 기능 사용 여부 설정 LM Common scale factor LM Save/Load Job file의 하위 기능으로 고정 Scale factor값을 사용할 지 설정 ※ 참고: LM SPC 기능은 특정 사이트에서만 사용 가능합니다."
},
{
"toc_id": "chapter06_heading08_sub02_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Library Manager@KSMART",
 "title2": "User login 창 ",
 "body": "Library Manager 설정 화면에서 Use Library Manager를 선택하고 LM User login 을 선택하면, 차후 프로그램 실행 시 아래의 사용자 로그인 창(Remote Log In)이 팝업됩니다. User Log In 창 아이디의 추가/삭제는 LM 서버에서 가능 (장비에서 직접 아이디 추가/삭제를 원하는 경우, 인터넷탐색창을 통해 LM 서버로 접속 후 아이디 추가/삭제 가능) 아이디와 암호는 각 장비 별로 설정하지 않고, Library Manager서버에서 설정한 아이디와 암호를 사용"
},
{
"toc_id": "chapter06_heading08_sub03_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Library Manager@KSMART",
 "title2": "Open Job 창",
 "body": "Open Job창에서는 원하는 JOB파일을 선택할 수 있습니다. Open Job 창(싱글 레인) JOB 파일 저장 및 티칭 시, 잡파일과 티칭 데이터는 LM 서버로 업로드 됨 Job 파일의 삭제 및 배포(deploy)는 LM 서버에서 가능 항목 설명 Preview 화면 우측의 PCB의 그림을 보일 것인지 보이지 않을 것인지 설정하는 버튼 입력란(Input Box) 입력란에 글자를 입력하면, 해당 글자가 포함된 잡파일이 화면에 표시됨 Upload 로컬 PC에 있는 잡파일을 서버로 업로드 Delete 표에서 선택된 잡파일 1개를 서버에서 삭제 Open 표에서 선택된 잡파일을 로드 ※ 참고: Library Server에 등록된 JOB 파일이 없는 경우, Library server 옆에 Offline 탭이 생성이 됩니다."
},
{
"toc_id": "chapter06_heading08_sub04_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Library Manager@KSMART",
 "title2": "Real-Time Monitoring(RTM)",
 "body": "LM 인터넷 서버로 접속 시(예: 10.10.0.115:8080), Real-Time Monitoring 창을 통해 장비의 실시간 상태 및 상세 정보를 차트 형태로 확인할 수 있습니다. Real time monitoring 옵션을 사용하기 위해서는 Library manager 창에서 LM User login과 LM Real time monitoring을 선택해야 합니다. LM 인터넷 서버로 접속 후 우측 상단에서 SPI와 Real-Time Monitoring을 선택하면 아래의 그림과 같이 실시간 차트가 표시됩니다. LM 서버 화면"
},
{
"toc_id": "chapter06_heading09_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "DCB(Direct Copper Bonding) 검사",
 "title2": "",
 "body": "DCB(Direct copper Bonding) 검사는 SPI 장비에서 납 표면의 결함을 검사할 수 있는 기능입니다."
},
{
"toc_id": "chapter06_heading09_sub01_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "DCB(Direct Copper Bonding) 검사",
 "title2": "설정 방법",
 "body": "KYConfig &gt; Use DCB Inspection을 선택합니다. CEditor&gt; Tolerance Setting&gt; Surface Setting탭에서 필요한 검사 항목을 선택하고 관련 허용치를 설정하십시오. 항목 설명 Height 평면의 높이 검사 Upper Height: 납 평균 높이의 상한값 Lower Height: 납 평균 높이의 하한값 Planarity 평면의 기울어진 각도 검사 X-axis: X축 기울기의 상한값 Y-axis: Y축 기울기의 하한값 Flatness Peak: 평면의 Peak 검사 Average Height: 납 평균 높이보다 입력값 만큼 높은 상한값 Area: Peak에 해당하는 높이를 가지고 있는 영역의 상한값 Hole: 평면의 Hole 검사 Average Height: 납 평균 높이보다 입렵값 만큼 낮은 하한값 Area: Hole에 해당하는 높이를 가지고 있는 영역의 상한값 Scratch 평면의 스크래치 검사 Average Brightness: ROI내 스크래치를 제외한 영역의 평균 Gray Level 값과 스크래치 영역과의 차이 상한 값 Area: Scratch에 해당하는 Gray Lavel을 가지고 있는 영역의 상한값 Inspection Area ROI영역에서 검사 영역을 지정하기 위한 여백 값"
},
{
"toc_id": "chapter06_heading09_sub02_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "DCB(Direct Copper Bonding) 검사",
 "title2": "검사 결과 확인",
 "body": "이 절에서는 Defect View와 Defect Review에서 DCB 검사 결과를 확인하는 방법을 설명합니다. Defect View 항목 설명 1 Flatness(Peak, Hole, Scratch) 결함의 경우 결함 영역 표시 2 Error 타이틀을 클릭 시, Surface 관련 검사 정보가 Condition/Result Info 창에 표시 Scratch 결함인 경우, Condition/Result Info 창에 아이콘이 활성화 됨 3 Defect List 영역의 Surface 검사 정보 표시 Defect Review Defect View 화면에서 NG 버튼을 클릭하면, 2차 판정을 위해 다음과 같이 Defect Review 화면이 나타납니다. 항목 설명 1 Flatness(Peak, Hole, Scratch) 결함의 경우, 결함에 해당되는 영역 표시 (주황색 박스 영역) 2 Surface 검사 정보 표시 3 Scratch 결함의 Gray Level 확인(아래그림) - Scratch 결함인 경우 Show Gray Level 버튼 활성화 ※ 참고: Use DCB Inspection 옵션이 켜져 있는 경우, SPC Plus에서도 Show Gray Level 버튼이 활성화 됩니다. ※ 참고: 3DViewer에서 마우스 오른쪽 버튼을 클릭하여 Cross Section 메뉴를 선택하면 아래 그림과 같이 선택 영역의 높이차 값과 각도가 함께 표시됩니다."
},
{
"toc_id": "chapter06_heading10_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Solder Segmentation Teaching Tool",
 "title2": "",
 "body": "Solder Segmentation Teaching Tool은 보드 위 솔더의 색상 정보를 티칭하여, 실제로 검사할 때 솔더가 검출되는 영역을 확인할 수 있는 기능입니다."
},
{
"toc_id": "chapter06_heading10_sub01_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Solder Segmentation Teaching Tool",
 "title2": "설정 방법",
 "body": "SPI Inspection Condition &gt; Measurement &gt; Method에서, Select 항목을 ‘Segmentation’로 설정합니다. ※ 참고: 이 기능은 Measurement Method 옵션이 ‘Segmentation’으로 적용된 패드에만 적용됩니다. Vision Parameter &gt; Condition2 탭 &gt; Segmentation &gt; Measurement Method 항목을 ‘Model Based’로 설정하십시오. Condition2 탭 &gt; Segmentation 하위 옵션 중, RGB Height 항목과 RGB Base 항목을 모두 ‘0’ 으로 설정하십시오."
},
{
"toc_id": "chapter06_heading10_sub02_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Solder Segmentation Teaching Tool",
 "title2": "제약 사항",
 "body": "티칭할 Solder PCB는 아래 조건을 충족해야 합니다. Good Board 솔더 인쇄 상태: 이물 없이 깨끗해야 함 오프셋: 솔더가 오프셋 없이 CAD 상의 패드 위에 도포되어 있어야 함 이미지 저장 옵션 및 경로가 아래와 같이 설정되어 있어야 합니다. Vision Parameter &gt; SYSTEM &gt; Engineer &gt; Save Image: ‘All’ 로 설정 저장 경로: C:\\Kohyoung\\KY-3030\\Vision\\Image ※ 참고: 양산 적용 시에는 Save Image 옵션 설정을 반드시 'No'로 변경해야 합니다"
},
{
"toc_id": "chapter06_heading10_sub03_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Solder Segmentation Teaching Tool",
 "title2": "사용 방법",
 "body": "Vision Parameter &gt; Condition1 탭의 Teaching Tool 버튼을 클릭하십시오. Teaching Tool 화면이 나타나면, 티칭을 진행할 패드를 선택하십시오. ※ 참고 - 솔더와 바닥면이 명확하게 구분되는 패드를 선택하십시오. - 아래 경로에 Raw 이미지가 없으면 FOV를 선택해도 패드 정보가 표시되지 않습니다. Raw 이미지 경로: C:\\Kohyoung\\KY-3030\\Vision\\Image Image Plane 하단의 ‘Auto’ 옵션에 체크하면, 자동으로 R, G, B, H, S, V 영상면 중 티칭이 유효한 영상면이 선택됩니다. 'R, G, B, H, S, V' 중 하나를 선택하면, 해당 영상면을 아래 창에서 확인할 수 있습니다. ※ 참고: 'Auto' 기능으로 자동으로 선택된 영상면이라도 해당 영상면을 확인했을 때 솔더가 명확히 구분되지 않는 경우, 해당 영상면을 수동으로 선택해제 할 수 있습니다. 현재 선택한 패드의 이미지를 보고, 확인할 수 있는 색상 그룹의 수를 Cluster No.에서 선택하십시오. 2개의 색상 그룹(솔더&amp;바닥면)을 가진 경우: ‘2’로 설정 3개의 색상 그룹(솔더&amp;바닥면&amp;Copper)을 가진 경우: ‘3’으로 설정 Teaching Start를 클릭하십시오. Verification을 클릭하면, 현재 선택된 패드에서 티칭한 정보를 이용하여 솔더 영역을 찾습니다. Result Mask에서 추출된 솔더 영역을 확인하십시오. ※ 참고: 하단의 슬라이드 바를 움직여서 Solder Mask의 투명도를 조절할 수 있습니다. 이는, Verification 결과를 사용자가 이해하기 쉽도록 돕는 기능일 뿐, 티칭 결과에는 영향을 미치지 않습니다. 다른 FOV의 다른 패드도 솔더 영역을 잘 검출하는지 위와 동일한 방법으로 검증하십시오. 검출한 솔더 영역이 실제 솔더 영역과 크기 차이가 있는 경우, Sigma 값을 조절하여 면적을 조절할 수 있습니다. Sigma: ‘2’ Sigma: ‘2.5’ (면적이 커짐) ※ 참고: Sigma 값은 티칭 결과에 저장되며, Sigma 값이 클수록 솔더 영역을 오인식할 수 있으므로 Area, Volume 측정 값에 영향을 미칠 수 있습니다. Apply를 클릭하여 티칭 정보를 저장합니다. ※ 참고 &#x9f; 현재의 Solder Segmentation Teaching 정보는 임시로 아래 경로에 저장됩니다. - 저장 경로: C:\\Kohyoung\\KY-3030\\Vision\\PCBInfo\\ - 파일명: JOB 파일명 맨 뒤에 '_2DSeg.json'을 붙인 이름으로 생성됩니다 예시) JOB 파일명: SRWH-5304243-60.mdb Teaching Data: SRWH-5304243-60_2DSeg.json &#x9f; BBT 정보와는 달리 JOB 파일 내에 저장되지 않기 때문에 다른 장비에서 해당 JOB 파일의 티칭 정보를 이용하려면, 생성한 Teaching Data 파일을 수동으로 ‘C:\\Kohyoung\\KY-3030\\Vision\\PCBInfo\\’ 경로에 복사해야 합니다. &#x9f; 추후, 이 티칭 정보도 JOB 파일에 포함될 예정입니다."
},
{
"toc_id": "chapter06_heading10_sub04_KOR.html",
 "chapter_i": "6",
 "chapter": "추가 기능",
 "title": "Solder Segmentation Teaching Tool",
 "title2": "추가 기능",
 "body": "주변 패드 확인 Margin 입력창에 설정한 픽셀(pixel) 수만큼 ROI를 확장하여, 현재 선택한 패드 주변의 패드들도함께 검증할 수 있습니다. ※ 참고: 설정한 Margin 값은 티칭 결과에 저장되지 않습니다. 아래와 같이 Bridge 2D Algorithm 사용 시 Margin 값을 크게 설정하여 주변 패드를 확인할 수 있습니다. Margin: ‘0’ Margin: 30 Bridge Inspection - Margin 기능 활용 방법 브릿지 검사에서 Margin 옵션을 활용하는 방법은 아래와 같습니다. Vision Parameter &gt; Condition1 탭 &gt; Bridge option에서 Use Bridge Insp. Method 항목을 선택 해제합니다. Vision Parameter &gt; Condition2 탭 &gt; Segmentation 하단의 Measurement Method를 ‘Model Based’로 설정하십시오. 자동 검사 진행 시, Teaching Tool의 Margin 값을 조정하여 브릿지를 판정할 Solder Mask를 테스트합니다. PAD 8055 - 오른쪽 패드와 Solder Mask가 연결되어 있어 브릿지 불량 발생 ※ 참고: Margin의 기본 설정 값은 ‘0’ 입니다."
},
{
"toc_id": "Info.html",
 "chapter_i": "7",
 "chapter": "문서 정보",
 "title": "",
 "title2": "",
 "body": "User Guide 3D Inspector GUI Ver.5.0.0.0 Copyright © 2022 Koh Young Technology Inc. All Rights Reserved."
},
{
"toc_id": "chapter00_heading01_KOR.html",
 "chapter_i": "7",
 "chapter": "문서 정보",
 "title": "저작권 및 면책조항",
 "title2": "",
 "body": "이 매뉴얼은 ㈜고영테크놀러지의 서면 승인 없이는 전체 또는 일부를 복사, 복제, 번역 또는 그 어떠한 전자매체나 기계가 읽을 수 있는 형태로 출판될 수 없습니다. 이 매뉴얼은 ㈜고영테크놀러지의 통제 하에 있지 않는 기타 업체로의 웹사이트 링크를 포함하고 있을 수도 있으며, ㈜고영테크놀러지는 링크된 그 어떠한 사이트에 대해서도 책임을 지지 않습니다. 또한, 출처를 미처 밝히지 못한 인용 자료들의 저작권은 원작자에게 있음을 밝힙니다. 혹시라도 있을 수 있는 오류나 누락에 대해 ㈜고영테크놀러지는 일체의 책임을 지지 않습니다. 제품의 버전이나 실행되는 형태에 따라 사진이 다를 수도 있습니다. 사양이나 사진은 매뉴얼 제작 시점의 최신 자료에 기초하고 있으나, 예고 없이 변경될 수도 있습니다."
},
{
"toc_id": "chapter00_heading02_KOR.html",
 "chapter_i": "7",
 "chapter": "문서 정보",
 "title": "개정 이력",
 "title2": "",
 "body": "개정 번호 날짜 설명 1.0 2022-10-01 문서 템플릿 변경 및 내용 업데이트 ﻿ ﻿ ﻿"
},
{
"toc_id": "chapter00_heading03_KOR.html",
 "chapter_i": "7",
 "chapter": "문서 정보",
 "title": "문서의 목적",
 "title2": "",
 "body": "본 문서는 ㈜고영테크놀러지 SPI 시스템의 메인 소프트웨어인 3D Inspector의 기본 사용 방법 및 JOB 프로그래밍 절차를 설명하는 사용자 가이드입니다. GUI Version: SPIGUI 5.0.0.0 Vision Version: SPIVIsion 1.9.6.0 사용자 등급: Programmer 레벨 이상"
},
{
"toc_id": "chapter00_heading04_KOR.html",
 "chapter_i": "7",
 "chapter": "문서 정보",
 "title": "용어/약어 설명",
 "title2": "",
 "body": "용어/약어 설명 ﻿ ﻿ ﻿ ﻿"
}
]