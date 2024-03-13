var search=[
{
"toc_id": "chapter01_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "",
 "title2": "",
 "body": ""
},
{
"toc_id": "chapter01_heading01_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "Coplanarity - Polygon ROI 추가",
 "title2": "",
 "body": "Coplanarity 검사에서 전체 영역의 휨을 검사할 수 있도록 Polygon ROI를 설정하는 기능이 추가되었습니다. Polygon ROI를 사용하면 하나의 ROI 만으로 검사 조건을 관리할 수 있고, 원하는 모양으로 ROI를 설정할 수 있습니다."
},
{
"toc_id": "chapter01_heading01_sub01_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "Coplanarity - Polygon ROI 추가",
 "title2": "사용 방법",
 "body": "Body &gt; Coplanarity 검사 조건 설정창으로 이동하십시오. Inspection Mode &gt; Mode &gt; Warpage 항목을 선택하십시오. ROI &gt; ROI Edit Mode에서 ‘By Mouse’를 선택하십시오. Extention ROI 항목은 ‘On(Extention)’로 설정하십시오. PCBView 상단에 생성된 ROI 도구바를 이용하여 ROI를 편집하십시오. : ROI 선택 모드 : 검사영역 지정 : 모든 ROI 초기화 ROI 형상 편집 방법 사각형 추가: 사각형 ()버튼 선택 후, 마우스 드래그로 영역 지정 원형 추가: 원형 () 버튼 선택 후, 마우스 드래그로 영역 지정 다각형 추가: 다각형() 버튼 선택 후, 마우스 왼쪽 버튼 클릭으로 꼭지점 추가. 꼭지점 개수가 3개 이상인 경우, 마우스 오른쪽 버튼 클릭으로 다각형 루프 생성 ROI 수정 ROI를 더블 클릭하여 선택하십시오. ROI의 Tracker를 이용하여 사이즈 조정 및 좌표를 이동할 수 있습니다."
},
{
"toc_id": "chapter01_heading02_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "Coplanarity - 방열제품(Heat sink) 평탄도 측정 알고리즘 개발",
 "title2": "",
 "body": "방열제품(Heat sink)의 평탄도를 측정하여 휨 불량을 검출할 수 있는 알고리즘이 개발되었습니다. 이 기능을 사용하면, 최대 높이와 최소 높이 편차의 기준 값을 설정하고 최대-최소 높이 편차가 기준 값 이하이면 Good으로 처리합니다."
},
{
"toc_id": "chapter01_heading02_sub01_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "Coplanarity - 방열제품(Heat sink) 평탄도 측정 알고리즘 개발",
 "title2": "사용 방법",
 "body": "Body &gt; Coplanarity &gt; Inspection Mode에서 Mode를 ‘Warpage’로 설정하십시오. ROI 설정 후 부품 검사를 진행하십시오. 아래와 같이 검사 결과를 확인할 수 있습니다. 주황색 사각형: 최소 높이 위치 표시, 청록색 사각형: 최대 높이 위치 표시 Min Height: 최소 높이 값 Max Height: 최대 높이 값 Max-Min Height: 최소-최대 높이 차이 값 Average Height: 평균 높이 Std. Height. 높이의 표준 편차 ※ 참고: Mask Edit Mode에서 ‘----------‘로 표시되는 모드는 사용하지 마십시오. 나머지 3개(Not Use, By Keyboard, Occlusion Component) 모드 중 하나를 선택하여 적용하시기 바랍니다."
},
{
"toc_id": "chapter01_heading03_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "Pad Overhang - LED 부품의 Y 방향 오프셋 검사 옵션 추가",
 "title2": "",
 "body": "LED Bar의 동일한 어레이 내에 포함된 LED 부품과 PCB 끝단부터 길이를 측정한 후 최대-최소 오프셋의 차이가 설정 값을 초과하면 NG로 판정하는 기능이 추가되었습니다."
},
{
"toc_id": "chapter01_heading03_sub01_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "Pad Overhang - LED 부품의 Y 방향 오프셋 검사 옵션 추가",
 "title2": "예시",
 "body": "거리 측정 결과, LED1(Min) 값과 LED2(Max) 값의 차이가 ‘100’인 경우 Min-Max Spec을 ‘60’으로 설정하면 NG로 판정 설정 값을 초과한 LED가 무엇인지 Defect Viewer에서 NG로 표시"
},
{
"toc_id": "chapter01_heading03_sub02_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "Pad Overhang - LED 부품의 Y 방향 오프셋 검사 옵션 추가",
 "title2": "설정 방법",
 "body": "AOISetup.ini 파일을 열고 CustomerNumber 항목에 ‘4164’를 입력하십시오. PCB Setting &amp; Info 창에서 아래 두 항목을 선택하십시오. Use BodyToBody Use Array Grade"
},
{
"toc_id": "chapter01_heading03_sub03_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "Pad Overhang - LED 부품의 Y 방향 오프셋 검사 옵션 추가",
 "title2": "사용 방법",
 "body": "Body &gt; Pad Overhang 메뉴로 이동하십시오. Tolerance &gt; Edge Y Offset Unit &gt; Difference to Min Offset(um)에 허용치를 입력하십시오. Parameter &gt; Reference Extract Mode를 ‘Edge’로 설정한 후, PCB Edge 추출을 위한 파라미터들을 설정하십시오. 검사를 진행한 후 아래와 같이 결과를 확인할 수 있습니다. 자동 검사 결과: GOOD 자동 검사 결과: NG 수동 검사 결과: GOOD ※ 참고: 수동 검사에서는 Edge Y Offset 검사 결과 판정을 하지 않고 측정값만 표시합니다."
},
{
"toc_id": "chapter01_heading04_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "FMI - 이형 부품의 이물 검사 개선",
 "title2": "",
 "body": "사각형이나 원형이 아닌 이형 부품에 대한 이물 검사 시, 측정된 Body Rectangle 영역 내에서 유효한 검사 영역을 설정할 수 있도록 개선되었습니다."
},
{
"toc_id": "chapter01_heading04_sub01_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "FMI - 이형 부품의 이물 검사 개선",
 "title2": "설정 방법",
 "body": "Body &gt; FM 검사 조건 설정 창 &gt; 각 Image Plane 별 하위 검사 옵션 중 Feature 항목을 ‘Saliency’ 모드로 설정하십시오. Inspection Area 항목을 ‘Valid Area’로 설정하고, Margin(um)을 입력하십시오. Margin(um): 유효한 검사 영역의 외곽을 기준으로 검사 영역을 축소 또는 확장할 정도를 설정 (+: 확장, -: 축소) ※ 참고 - 이 기능은 Saliency 모드에서만 적용됩니다. - Saliency 모드로 검사 시 Reference Map이 티칭되어 있어야 합니다."
},
{
"toc_id": "chapter01_heading05_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "FMI - Individual 모드에서 NG 조건 조합 기능 추가",
 "title2": "",
 "body": "이물 검사의 Individual 모드에서 각 조건 별 NG 조건을 조합할 수 있는 기능이 추가되었습니다. Body &gt; Foreign Material &gt; Inspection Mode를 ‘User-defined for Image’로 선택하십시오. 결과 판정을 위한 계산 조건이 표시됩니다. 예시: (#1 &gt; 1500) or (#2 &gt; 3500) or (#3 &gt;10 ) 각 이미지 별 불량 판정 모드를 설정하십시오. 검사 진행 후, 아래와 같이 결과를 확인할 수 있습니다."
},
{
"toc_id": "chapter01_heading06_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "FMI – Pad Area 여백 기능 추가",
 "title2": "",
 "body": "검사 제외 영역을 확장하기 위하여 Pad Area 모드에 여백 값을 적용할 수 있는 기능이 추가되었습니다."
},
{
"toc_id": "chapter01_heading06_sub01_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "FMI – Pad Area 여백 기능 추가",
 "title2": "사용 방법",
 "body": "Body &gt; Foreign Material &gt; Pad Area 항목을 ‘Use’로 설정하십시오. Margin of Pad Area에 여백 값을 입력하십시오. 수동 검사를 진행하면, 확장된 Pad Area 부분이 노란색으로 표시됩니다."
},
{
"toc_id": "chapter01_heading07_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "FMI – 주변 부품 자동 마스킹",
 "title2": "",
 "body": "Body의 이물 검사 영역이 Margin이 적용되어 확장되면 근처의 일부 부품이 포함되어 이물로 감지되는 어려움이 있었습니다. 이를 개선하기 위하여, 주변의 부품을 자동으로 검사 영역에서 제외시키는 기능이 추가되었습니다. 개선 전 개선 후"
},
{
"toc_id": "chapter01_heading07_sub01_KOR.html",
 "chapter_i": "1",
 "chapter": "Standard Inspection Conditions (Body)",
 "title": "FMI – 주변 부품 자동 마스킹",
 "title2": "사용 방법",
 "body": "Body &gt; Foreign Material 에서 검사 조건을 설정하십시오. 수동 검사를 진행한 후, 결과 이미지를 확인하십시오. ※ 참고: 이 기능은 별도의 설정 없이 자동으로 적용됩니다."
},
{
"toc_id": "chapter02_KOR.html",
 "chapter_i": "2",
 "chapter": "Standard Inspection Conditions (Lead)",
 "title": "",
 "title2": "",
 "body": ""
},
{
"toc_id": "chapter02_heading01_KOR.html",
 "chapter_i": "2",
 "chapter": "Standard Inspection Conditions (Lead)",
 "title": "Cold Solder Score Check - 냉납 검사 항목 추가",
 "title2": "",
 "body": "냉납을 검사할 수 있는 검사 항목을 추가하여, 기존의 복잡했던 검사 항목 설정의 어려움을 개선하였습니다. Two Terminal Chip 부품에 한하여 냉납 검사 가능 Solder Joint 3D Mode 및 기존 검사 항목들을 조합하여 냉납 확률 검사"
},
{
"toc_id": "chapter02_heading01_sub01_KOR.html",
 "chapter_i": "2",
 "chapter": "Standard Inspection Conditions (Lead)",
 "title": "Cold Solder Score Check - 냉납 검사 항목 추가",
 "title2": "설정 방법",
 "body": "Lead &gt; Solder Fillet &gt; Cold Solder Score Check 항목을 ‘On(Cold Solder)’으로 설정하십시오. 하위 활성화된 항목들을 설정하십시오. Decision Logic for NG - and, or: Solder Fillet 검사의 결과 처리 로직 Cold Solder Score for NG(%): 냉납 분류를 위한 허용치 (Default: 50%) ROI Edit Mode - Auto, User-define: 검사 ROI 설정, 기존 Solder Fillet 알고리즘과 동일하게 Auto, Manual Mode로 분류 ROI Limit - No limit Pad, Limit Pad Only: ROI가 패드 영역을 벗어나는 것에 대한 허용 여부 설정"
},
{
"toc_id": "chapter02_heading01_sub02_KOR.html",
 "chapter_i": "2",
 "chapter": "Standard Inspection Conditions (Lead)",
 "title": "Cold Solder Score Check - 냉납 검사 항목 추가",
 "title2": "검사 조건 ",
 "body": "냉납 검사 항목을 사용하기 위해 설정해야 하는 검사 조건은 아래와 같습니다. 필수: Solder Joint 3D Mode 선택: Joint Slope, Lead Coplanarity, Body Coplanarity, Body Pad Overhang(Offset Angle) ※ 참고 - 2D Feature는 냉납 검사의 필수 조건이며, 냉납 검사 알고리즘 내부적으로 수행하므로 별도 검사 조건 설정이 필요 없습니다. - 냉납 검사에 사용할 수 있는 선택 조건들은 우선 순위대로 나열하였으며, 최대한 많은 검사 조건을 활성화하여 사용하는 것을 추천합니다. Solder Joint 3D Mode: Advanced Lead &gt; Presetting &gt; Solder Joint 3D Mode 항목을 ‘Advanced’ 로 설정하십시오. 냉납 검사를 위한 필수 조건으로, 이 설정을 통해 AI Classifier를 동작시킵니다. Joint Slope Mode: Multi Point Body &gt; Solder Fillet &gt; Solder Feature Check &gt; Joint Slope Mode 항목을 'Multi Point'로 설정하십시오. 오프셋 원점 위치를 'Lead Tip'으로 설정하십시오. 1st, 2nd 측정 지점은 부품 크기 및 패드 크기에 따라 솔더 필렛 전체 영역이 검사 가능하도록 설정하십시오. ※ 참고: 원점 위치(Offset Origin Position) 설정 시, 조인트 기울기 검사 ROI에 리드가 포함되지 않도록 Lead Tip으로부터 떨어진 위치로 설정해야 합니다. Lead Coplanarity: Absolute Height Difference Body Rotation, Joint Slope 둘 중 1개 이상의 검사가 수행될 경우에만 적용됩니다. Body &gt; Solder Fillet &gt; Parameter &gt; Coplanarity Inspection Option 항목을 'Absolute Height Difference' 로 설정하십시오. Body Coplanarity: Cross Pkg. Type이 Capacitor, Resistor인 경우에만 적용되는 항목입니다. Lead Coplanarity 검사가 정상적으로 수행되었을 경우에만 적용됩니다. Body Rotation, Joint Slope 둘 중 1개 이상의 검사가 수행될 경우에만 적용됩니다. Body &gt; Coplanarity &gt; Inspection Mode를 ‘Cross’ 로 설정하십시오. Body Pad Overhang: Center XY Pkg. Type이 Capacitor, Resistor인 경우에만 적용되는 항목입니다. Body &gt; Pad Overhang &gt; Inspection Mode를 ‘Center XY’로 설정하십시오."
},
{
"toc_id": "chapter02_heading01_sub03_KOR.html",
 "chapter_i": "2",
 "chapter": "Standard Inspection Conditions (Lead)",
 "title": "Cold Solder Score Check - 냉납 검사 항목 추가",
 "title2": "검사 결과",
 "body": "Solder Joint 3D Mode(Advanced) 와 2D Feature는 필수 검사조건으로, 이 두 가지 검사만 포함되어도 냉납 검사는 동작하며, 이 때, 적용되지 않은 검사 옵션들은 아래와 같이 'Unused Factor' 로 표시됩니다."
},
{
"toc_id": "chapter02_heading02_KOR.html",
 "chapter_i": "2",
 "chapter": "Standard Inspection Conditions (Lead)",
 "title": "THT - 솔더 필렛 검사 개선",
 "title2": "",
 "body": "기존 일반 부품의 솔더 필렛 검사 기능 중, 특정 영역의 Volume, Area를 측정하여 불량을 판정하는 Pad End Height 기능을 THT에서도 사용할 수 있습니다."
},
{
"toc_id": "chapter02_heading02_sub01_KOR.html",
 "chapter_i": "2",
 "chapter": "Standard Inspection Conditions (Lead)",
 "title": "THT - 솔더 필렛 검사 개선",
 "title2": "사용 방법",
 "body": "Package Type을 ‘THT’로 설정하십시오. THT &gt; 솔더 필렛 검사 조건 창에서[Pad End Height]항목을 ‘On’으로 설정하십시오. Diameter (%) 항목에는 검사 영역을 설정하십시오. Inspection Point 항목을 ‘Inner’ 또는 ‘Outer’ 중에서 설정합니다. Area, Volume 검사 모드를 선택하여 진행할 수 있습니다."
},
{
"toc_id": "chapter02_heading03_KOR.html",
 "chapter_i": "2",
 "chapter": "Standard Inspection Conditions (Lead)",
 "title": "THT - 패드 외곽을 벗어난 THT 솔더 검출",
 "title2": "",
 "body": "2D 검사로 THT 패드 영역을 벗어난 솔더가 있을 경우 불량으로 검출할 수 있는 기능이 추가되었습니다. 패드 영역을 벗어난 영역: 초록색 새롭게 추가된 THT &gt; Solder Fillet &gt; [Ext. Area] 옵션의 상세 항목은 아래와 같습니다. Item Value Description [Ext. Area] On (Ext. Area) Off 기능 사용 여부 설정 [Ext. Area] Extended ROI Metric (um) Percent (%) 확장된 ROI (외부 원) 측정 단위 선택 -Diameter (um/%) ﻿ 확장된 ROI의 직경(외부 원 ROI) 측정 단위가 퍼센트(%)인 경우 패드에 대한 비율이 값이 됩니다. [Ext. Area] ROI Edit Mode [Ext. Area] User-defined [Ext. Area] Full Pad 내부 원 ROI 모드 선택 -Unit Metric (um) Percent (%) 내부 원 ROI의 측정 단위 선택 -Inspection Margin (um/%) ﻿ 내부 원 ROI의 직경 측정 단위가 퍼센트(%)인 경우 패드에 대한 비율이 값이 됩니다. [Ext. Area] Threshold[%] ﻿ 임계값 설정 [Ext. Area] Joint Image 3D + 2D No Flat 3D + 2D Steep 2D Steep 2D No Flat Joint Image 모드 선택 [Ext. Area] Min. Height ﻿ Joint Image 최소 높이(um)"
},
{
"toc_id": "chapter02_heading04_KOR.html",
 "chapter_i": "2",
 "chapter": "Standard Inspection Conditions (Lead)",
 "title": "THT - 미장착 검사 개선",
 "title2": "",
 "body": "THT 미장착(Missing) 검사 기능이 아래와 같이 개선되었습니다. THT &gt; Presetting &gt; 3D Base Parameter &gt; Base Slope Compensation Mode 추가 THT의 Base에 기울기가 발생할 경우, ‘Iterative Plane Fit’을 사용하여 기울기 보상 THT &gt; Missing &gt; Inspection Mode &gt; Inspect Area 옵션 추가 Inspect Area를 ‘Auto’가 아닌 ‘Pad’로 설정하면 패드 안에서 THT 높이 검사 수행"
},
{
"toc_id": "chapter03_KOR.html",
 "chapter_i": "3",
 "chapter": "KAP 1.6",
 "title": "",
 "title2": "",
 "body": ""
},
{
"toc_id": "chapter03_heading01_KOR.html",
 "chapter_i": "3",
 "chapter": "KAP 1.6",
 "title": "Koh Young Auto Programming (KAP) 개선",
 "title2": "",
 "body": "Koh Young Auto Programming (이하 ‘KAP’)는 사용자 라이브러리 또는 고영에서 제공한 라이브러리의 패키지 정보와 검사조건을 이용하여 자동으로 프로그래밍하는 기능입니다. 새로운 AOI 버전에서는 KAP 기능을 더욱 용이하게 사용할 수 있도록 아래 항목들을 개선하였습니다. KAP 수행 완료 후, KAP Target Part 목록에 표시되는 결과 데이터에 Result 필터 추가 KAP Target Part 목록의 너비 조정 가능 KAP Target Part 목록에서 키보드 상/하 방향키로 항목 선택 &gt; PCB Viewer에 선택한 항목 표시 Package Programming 탭 &gt; Update to Library 버튼 &gt; Update to Library 창 KAP Library 하위에 선택된 항목들이 All 다음으로 표시됨. KAP Library 하위의 항목들이 이름 순으로 정렬되어 표시됨. Koh Young Auto Programming 패널의 Result 정보에 표시되는 명칭 변경 변경 전: Fail 변경 후: Unmapped 결과 목록에서 Confidence가 ‘High’인 열의 Library 필드를 ‘KAP Model’로 표시 Option &gt; Language 설정을 Korean으로 변경 시, 한국어로 언어 변경 AOIGUI &gt; Settings &gt; KSMART &gt; KAP 탭 KAP Engine이 KSMART 서버에 적용되면 Use KAP(Koh Young Auto Programming) 옵션이 자동 활성화되어 설정되어 있도록 개선 자동 프로그래밍에 실패한 경우, KAP Target Part 목록에서 CRD 필드를 클릭하여 KAP 수행에 적절한 CRD로 변경 가능 Koh Young Auto Programming 패널의 Start 버튼을 클릭하여 자동 검사 수행 중, Cancel 클릭 시 표시되는 팝업 메시지 내용 수정"
},
{
"toc_id": "chapter04_KOR.html",
 "chapter_i": "4",
 "chapter": "Side Camera Inspection",
 "title": "",
 "title2": "",
 "body": ""
},
{
"toc_id": "chapter04_heading01_KOR.html",
 "chapter_i": "4",
 "chapter": "Side Camera Inspection",
 "title": "Side Camera - Standard 검사 항목 추가",
 "title2": "",
 "body": "기존에는 프로그래밍 탭의 기본 검사 조건 설정 창에서 설정 가능한 Side Camera 전용 검사 조건으로 Bridge, Lead Tip Finding, Pad Overhang – Tip width offset 검사가 있었으나, 새로운 AOI 버전에서는 Side Camera의 기본 검사 조건 설정이 아래와 같이 확대 적용되었습니다. Item ﻿ AOI 2.7.6.0 AOI 2.8.0.0 Pad Overhang Tip width offset O O IPC - O Coplanarity - O Solder Fillet Average Volume(3D) - O Pad Steep Area(3D+2D) - O Bare Copper - O Free Image - O Bridge O O ※ 참고: 지원하지 않는 검사 모드에 적용한 경우, 아래와 같은 문구가 표시됩니다. IPC Inspection Mode UI Coplanarity Inspection Mode UI SolderFillet - Average Volume(3D) Inspection Mode UI SolderFillet - Pad Steep Area(3D+2D) Inspection Mode UI Bare Copper Inspection Mode UI Free Image Inspection Mode UI"
},
{
"toc_id": "chapter05_KOR.html",
 "chapter_i": "5",
 "chapter": "Fiducial Teaching &amp; Grab Image",
 "title": "",
 "title2": "",
 "body": ""
},
{
"toc_id": "chapter05_heading01_KOR.html",
 "chapter_i": "5",
 "chapter": "Fiducial Teaching &amp; Grab Image",
 "title": "패턴 피두셜 설정 개선",
 "title2": "",
 "body": "새로운 AOI 버전에서는 피두셜 인식률을 향상시키기 위해 패턴 피두셜을 적용할 수 있게 되었습니다. 보드에 있는 원 형상의 패드들을 대상으로, 피두셜 ROI 안에 패턴 ROI가 존재하는지 확인할 수 있습니다. Pattern ROI: ‘FID_*’ 부품이 포함된 ROI 영역 FID_*: 기존 등록된 컴포넌트 (CAD) Fiducial ROI: Fiducial Teaching 창에서 사용자가 지정한 ROI 영역 ※ 참고 - 이 기능은 Global Fiducial 및 Local Fiducial에 적용됩니다. - 현재는 원 모양의 패드(BGA 타입)에만 적용됩니다."
},
{
"toc_id": "chapter05_heading01_sub01_KOR.html",
 "chapter_i": "5",
 "chapter": "Fiducial Teaching &amp; Grab Image",
 "title": "패턴 피두셜 설정 개선",
 "title2": "사용 방법",
 "body": "FID_* 부품을 포함한 영역의 중심 위치에 글로벌 피두셜 또는 로컬 피두셜을 추가한 후 Use Pattern Matching 옵션을 선택하십시오. FID_* 부품의 크기에 맞춰 Reference Fid를 선택하십시오. 해당 어레이의 FID_* 부품이 표시됩니다. Fiducial Teaching 창에서 Use Pattern Matching 옵션을 다시 선택하십시오. 그러면, ROI 영역이 Pattern FID로 축소됩니다. 패턴이 잘 맞지 않을 경우 Fiducial ROI 영역을 재조정하거나 조건을 변경하십시오. ※ 참고: Use Pattern Matching 옵션을 선택 해제한 후 JOB 파일을 다시 불러오면, ‘FID_*’ 부품은 화면에 표시되지 않습니다."
},
{
"toc_id": "chapter05_heading01_sub02_KOR.html",
 "chapter_i": "5",
 "chapter": "Fiducial Teaching &amp; Grab Image",
 "title": "패턴 피두셜 설정 개선",
 "title2": "유의 사항",
 "body": "CAD 데이터에 ‘FID_*’라는 이름으로 시작하는 부품이 존재해야 합니다. (예시: FID_1_1, FID_1_2, FID_2_1, 등) 이름이 ‘FID_*’인 부품은 어레이 1번에만 존재하며 피두셜을 새로 생성할 때 표시됩니다. 사용자가 해당 어레이 선택 시 Reference Array가 자동으로 표시됩니다. 해당 ‘FID_*’ 부품의 크기와 맞는 Reference Fid를 선택해야만 정확한 티칭 결과를 확인할 수 있습니다."
},
{
"toc_id": "chapter05_heading02_KOR.html",
 "chapter_i": "5",
 "chapter": "Fiducial Teaching &amp; Grab Image",
 "title": "패드 피두셜 - Cross Fiducial의 폭 설정 기능",
 "title2": "",
 "body": "WLP 검사 중 틀어짐 오차를 최소화하기 위하여 패드 피두셜 사용 시, 패드 피두셜의 크기가 너무 작은 경우 어레이 외곽 Cross 형상의 간격을 피두셜로 설정할 수 있게 되었습니다. 기존 버전에서는 이 Cross 형상의 X, Y 크기만을 설정할 수 있었으나, 새로운 버전에서는 Cross 형상의 폭을 설정하는 기능이 추가되어 인식률이 향상되었습니다. 또한, 일반 Cross Fiducial 라인에 끝이 없이 이어져 있는 형상이므로, 인식률 향상을 위해 GUI 상에서 끝 라인을 확인할 수 없는 피두셜의 경우 선택할 수 있는 Infinity Size 옵션이 추가되었습니다."
},
{
"toc_id": "chapter05_heading02_sub01_KOR.html",
 "chapter_i": "5",
 "chapter": "Fiducial Teaching &amp; Grab Image",
 "title": "패드 피두셜 - Cross Fiducial의 폭 설정 기능",
 "title2": "사용 방법",
 "body": "Package Programming 탭 &gt; Edit Package 탭 &gt; Edit &gt; Add 버튼 &gt; Fiducial 탭으로 이동하십시오. Shape 항목에서 CROSS를 선택하면 폭 입력창이 활성화됩니다. Cross 형상의 폭 정보를 입력하십시오. w1, a1 활성화, w2, a2 비활성화 Angle 항목 숨김처리 Default value: 0.0 GUI 상에서 피두셜의 크기가 FOV 범위를 벗어나는 경우 Infinity Size 옵션을 선택하십시오. ※ 참고: w1, a1 값이 0 인 상태에서 Create을 클릭하면, 먼저 정보를 입력하라는 메시지가 나타납니다. Fiducial 탭에서 Matching Rate Test를 진행 후 Score를 확인하십시오. ※ 주의: Fiducial 탭 &gt; Lighting &gt; ‘Fiducial LED’ 항목을 선택한 후, 선택한 조명의 Matching Rate를 평가하여 적절한 조명을 선택하십시오."
},
{
"toc_id": "chapter05_heading03_KOR.html",
 "chapter_i": "5",
 "chapter": "Fiducial Teaching &amp; Grab Image",
 "title": "보드 그랩 이미지의 저장 시간 단축",
 "title2": "",
 "body": "기존에는 크기가 큰 보드의 경우 보드 이미지 그랩에 시간이 오래 걸렸으나, 새로운 버전에서는 ‘Grab for Whole Image Planes’ 옵션을 선택적으로 사용하도록 개선하여 이미지 그랩에 소요되는 시간을 단축하였습니다."
},
{
"toc_id": "chapter05_heading03_sub01_KOR.html",
 "chapter_i": "5",
 "chapter": "Fiducial Teaching &amp; Grab Image",
 "title": "보드 그랩 이미지의 저장 시간 단축",
 "title2": "사용 방법",
 "body": "보드를 로드하고, Board Grab 버튼을 클릭하십시오. ※ 참고: 현재 설정된 사용자권한에 따라 Board Grab 권한이 없을 수 있습니다. Grab Process 창이 나타나면 ‘Grab for Whole Image Plane’ 옵션을 선택 해제하십시오. ※ 참고: 기본적으로 ‘Grab for Whole Image Planes' 옵션은 선택되어 있습니다. OK를 클릭하여 그랩을 수행하십시오. 그랩 이미지들이 저장되는 경로(JOB 경로)에 ‘WholeBoard_OCC_XXX.BMP’ 형태의 파일들이 생성되지 않습니다. ※ 주의: 이 옵션을 선택 해제하여 전체 Image Plane을 그랩하지 않은 경우, BAT, WFMI 및 Occlusion에서 Board Base Color를 추출하는 작업이 정상적으로 수행되지 않습니다."
},
{
"toc_id": "chapter06_KOR.html",
 "chapter_i": "6",
 "chapter": "Odd Shape",
 "title": "",
 "title2": "",
 "body": ""
},
{
"toc_id": "chapter06_heading01_KOR.html",
 "chapter_i": "6",
 "chapter": "Odd Shape",
 "title": "Odd Shape - 사용성 개선",
 "title2": "",
 "body": "이형 부품(Odd Shape) 검사 기능의 사용성이 아래와 같이 개선되었습니다. Odd Shape 창을 열면, CAD 정보를 표시하는 메뉴가 기본적으로 선택되도록 개선되었습니다. 각각 속성 값 변경 시 또는 Apply 버튼 클릭 시, 스크롤 바가 화면 상단으로 이동하지 않도록 개선하였습니다. 설정 버튼 클릭 시 또는 영상면(Image Plane) 변경 시에도 스크롤 바는 움직이지 않습니다. Group Item 중 Height Difference1, Height Difference2, Coplanarity1, Coplanarity2 등과 같은 항목 추가 직후 3D 영상면을 자동으로 생성합니다. Distance 항목 추가 시 1개의 Edge 대신에 2개의 Edge가 자동으로 생성됩니다. Height_Difference 그룹 사용 시, 2개의 ROI 위치를 변경할 수 있습니다. 아래 이미지와 같이 ROI 1개는 부품 윗면에 있고 나머지 ROI는 부품 바닥면에 있는 경우, 부품 바디 형상에 따라 2개의 ROI를 별도로 배치할 수 있습니다. 변경 전 변경 후"
},
{
"toc_id": "chapter06_heading02_KOR.html",
 "chapter_i": "6",
 "chapter": "Odd Shape",
 "title": "Odd Shape- Edge to Edge Distance 모드 개선",
 "title2": "",
 "body": "Edge to Edge Distance를 측정할 때, Edge의 중앙 위치로부터 반대편 Edge까지의 거리를 계산하는 Use Center Distance 모드가 추가되었습니다."
},
{
"toc_id": "chapter06_heading02_sub01_KOR.html",
 "chapter_i": "6",
 "chapter": "Odd Shape",
 "title": "Odd Shape- Edge to Edge Distance 모드 개선",
 "title2": "사용 방법",
 "body": "Odd Shape 티칭 창에서 Distance Group을 추가합니다. 사이 거리를 측정하기 위한 Edge 2개를 설정하십시오. Distance Group 검사 조건 중, Use Edge Center 항목을 ‘Yes(Center)’로 변경하십시오. (Default: No) No(Default): Edge 간 최소거리 계산 Yes(Center): Edge의 Center와 반대편 Edge간 거리 계산 부품 검사를 진행 후 측정 결과를 확인하십시오."
},
{
"toc_id": "chapter07_KOR.html",
 "chapter_i": "7",
 "chapter": "WFMI",
 "title": "",
 "title2": "",
 "body": ""
},
{
"toc_id": "chapter07_heading01_KOR.html",
 "chapter_i": "7",
 "chapter": "WFMI",
 "title": "WFMI – AI 알고리즘 개발로 신규 검사 옵션 추가",
 "title2": "",
 "body": "다양한 크기, 색상 및 질감의 이물질을 감지하고 분류할 수 있는 WFMI 신규 알고리즘이 개발되었습니다."
},
{
"toc_id": "chapter07_heading01_sub01_KOR.html",
 "chapter_i": "7",
 "chapter": "WFMI",
 "title": "WFMI – AI 알고리즘 개발로 신규 검사 옵션 추가",
 "title2": "사용 방법",
 "body": "AOIConfig에서 Use GPU Accelerate 옵션을 활성화하십시오. 검사 조건 설정 창의 Inspection Algorithm Tolerance 우측 콤보 박스에서 이물검사에 사용할 알고리즘으로 ‘Anomaly’를 선택하십시오. Min. Brightness: 2D 기준 이물로 정의할 마스터 이미지 대비 최소 밝기 차이 Min. Color: 2D 기준 이물로 정의할 마스터 이미지 대비 최소 색상 차이 ※ 참고: 둘 중 하나의 알고리즘을 반드시 사용해야 하며, 두 알고리즘을 함께 사용할 수도 있습니다. Apply를 클릭하여 설정을 저장하십시오. ※ 참고: Apply를 클릭하면 현재 선택한 알고리즘 뿐만 아니라 이전에 설정했던 모든 알고리즘의 허용치가 저장됩니다."
},
{
"toc_id": "chapter07_heading02_KOR.html",
 "chapter_i": "7",
 "chapter": "WFMI",
 "title": "WFMI – White Mask 추가",
 "title2": "",
 "body": "WFMI 적용 시, 방열판 영역의 편차 등으로 인해 가성 불량이 발생하는 어려움이 있었습니다. 새로운 AOI 버전에서는 방열판 영역의 마스크를 추가하여, Color/Saturation 이물 검출 시 해당 마스크 영역을 제외하고 이물을 검출하도록 개선되었습니다."
},
{
"toc_id": "chapter07_heading02_sub01_KOR.html",
 "chapter_i": "7",
 "chapter": "WFMI",
 "title": "WFMI – White Mask 추가",
 "title2": "사용 방법",
 "body": "AOIConfig에서 Use GPU Accelerate 옵션을 활성화하십시오. AOGUI &gt; FM Inspection 탭 &gt; Mask List에서 White Mask 항목을 선택하고, Grab을 클릭하십시오. 그러면 White Mask가 생성됩니다. Mask Visible () 버튼을 클릭하면, PCB 뷰에서 생성된 마스크를 확인할 수 있습니다. Inspection Condition 탭에서는 White Mask에 대한 파라미터들을 설정할 수 있습니다. Extend Range: 각 마스크 영역에서 추가로 확장할 크기를 설정 Noise Size: 홀(Hole) 및 가장자리(Edge) 검출 시 노이즈를 제거하기 위한 옵션 Apply를 클릭하여 조정한 파라미터를 적용한 후, Re-Grab을 수행해야만 Mask Image가 새로 생성됩니다."
},
{
"toc_id": "chapter07_heading03_KOR.html",
 "chapter_i": "7",
 "chapter": "WFMI",
 "title": "WFMI - Unused 부품 영역의 마스킹 해제 기능",
 "title2": "",
 "body": "기존에는 WFMI에서 Unused 부품 영역에도 Mask 기능이 적용되어 검사에서 제외되던 문제가 있었으나, 이를 개선하고자 Unused 부품은 마스크 처리에서 제외할 수 있는 옵션이 추가되었습니다."
},
{
"toc_id": "chapter07_heading03_sub01_KOR.html",
 "chapter_i": "7",
 "chapter": "WFMI",
 "title": "WFMI - Unused 부품 영역의 마스킹 해제 기능",
 "title2": "사용 방법",
 "body": "Board Programming 탭 &gt; FM Inspec 탭으로 이동하십시오. Mask List에서 Component Mask &gt; Exclude Unused Components 옵션을 선택하십시오. JOB 파일을 저장하십시오. Board Programming 탭으로 이동하여 자동검사를 수행하면, 검사를 시작하기 전에 Component Mask가 업데이트됩니다. 아래와 같이 Unused 된 컴포넌트가 마스크 처리에서 제외된 것을 확인할 수 있습니다. 이물 검사를 수행할 때 마스크 처리가 제외된 영역에 부품이 존재하는 경우, 아래와 같이 이물로 감지합니다."
},
{
"toc_id": "chapter07_heading04_KOR.html",
 "chapter_i": "7",
 "chapter": "WFMI",
 "title": "WFMI - Anomaly Detector 적용",
 "title2": "",
 "body": "단순한 Threshold 조합이 아닌 다양한 특성과 주변 데이터를 활용하여 이물을 판단하기 위하여, Anomaly Detector 알고리즘을 적용할 수 있습니다. 기본 설정은 Basic Detector 알고리즘이며, 보드에 패턴들이 많거나 주변 노이즈가 심한 경우에는 Anomaly Detector 알고리즘을 사용하여 보다 강화된 이물 검사를 수행할 수 있습니다. ※ 참고: 이 기능을 사용하려면 CUDA 및 하기 버전의 AI Engine을 사용해야 합니다. - AI Engine 버전: AOI_AI_Engine_INSTALLER_4.0.0.0_CU11.2_CudaAl"
},
{
"toc_id": "chapter07_heading04_sub01_KOR.html",
 "chapter_i": "7",
 "chapter": "WFMI",
 "title": "WFMI - Anomaly Detector 적용",
 "title2": "설정 방법",
 "body": "FM 2D Inspection &gt; 설정() 버튼을 클릭하십시오. WFMI Image Plane Setting Dialog에서 Inspection Algorithm (must select one or more)를 ‘Anomaly Detector’로 선택하십시오. Basic Detector: 기존 사용하던 기본 알고리즘 (Default) Anomaly Detector: Anomaly Detector를 사용하여 Pattern, Edge Noise에 강화된 알고리즘 Algorithm Merge Logic: Basic Detector와 Anomaly Detector를 동시에 사용할 경우, 두 결과를 조합할 로직 선택 (AND/OR) ※ 참고: 기본 설정은 Basic Detector 알고리즘이며, 보드에 패턴들이 많거나 주변 노이즈가 심한 경우에는 Anomaly Detector 알고리즘을 사용하는 것이 좋습니다. 나머지 세부 옵션도 설정할 수 있습니다. Use edge reflection mask: Anomaly Detector의 Edge 노이즈 개선 Use stability mask: Anomaly Detector의 주변 노이즈 개선 Inspection Algorithm Tolerance 설정 메뉴 우측에 추가된 옵션 선택창에서 Anomaly를 선택하고, 허용치를 설정하십시오."
},
{
"toc_id": "chapter08_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "",
 "title2": "",
 "body": ""
},
{
"toc_id": "chapter08_heading01_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "바디 틀어짐 알고리즘 개선",
 "title2": "",
 "body": "Pad Overhang 검사에서 새롭게 개선된 검사 알고리즘을 사용하여 다각형의 좌표를 편집하고 검사할 수 있게 되었습니다."
},
{
"toc_id": "chapter08_heading01_sub01_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "바디 틀어짐 알고리즘 개선",
 "title2": "사용 방법",
 "body": "패키지 프로그래밍 탭 &gt; 검사 조건 탭으로 이동하십시오. Body &gt; Pad Overhang &gt; Inspection Mode &gt; Mode를 ‘Center XY(4Direction)’으로 설정하십시오. Inspection Valid Area 옵션을 ‘On’으로 선택하십시오. Extension ROI의 입력란을 클릭하면, 검사 유효 영역을 설정하는 창이 팝업합니다. Load Polygon File 버튼을 클릭하여 Polygon 파일을 불러오십시오. ※ PolygonCoordInfo.txt 파일 생성 방법 1. Index, 좌표 X, 좌표 Y의 순서로 다각형의 각 꼭지점 좌표 정보를 기록합니다. (ROI Center 기준 좌표) 2. Notepad를 이용하여 Index와 좌표를 기록한 후, *.text 확장자로 파일을 저장하십시오. 불러온 좌표를 확인 후 Apply를 클릭하십시오. PCB View에서 생성된 다각형 좌표를 확인할 수 있습니다. 검사를 진행 후, Defect View에서 결과를 확인하십시오."
},
{
"toc_id": "chapter08_heading02_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "페어링 검사 – Pairing 4 직선 거리 측정 옵션 추가",
 "title2": "",
 "body": "Pairing 4 검사는 First Object와 Second Object의 중심점을 연결하는 직선 상에서 Third Object의 중심점을 직각으로 잇는 거리와 Third Object의 CAD 기준 중심점과 측정 기준 중심점 간의 거리를 측정하는 검사 항목입니다. 새로운 AOI 버전에서는 Pairing 4 검사에서 직선 거리를 측정하는 선택 옵션(Radius, Diameter)이 추가되었습니다. 반경(Radius) 측정 방식의 결과는 이전과 동일하지만, 직경 (Diameter) 측정 방식에서의 측정 결과는 2배가 됩니다."
},
{
"toc_id": "chapter08_heading02_sub01_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "페어링 검사 – Pairing 4 직선 거리 측정 옵션 추가",
 "title2": "사용 방법 ",
 "body": "측정 방식 - 반경 Add Pairing Inspection 툴 바에서 Pairing 4 검사 항목을 클릭하고, Use 3 Objects 또는 Use 4 Objects 모드를 선택하십시오. Measurement 옵션은 Radius를 선택하십시오. PCB 뷰어에서 오브젝트를 선택하여 추가한 후, Apply를 클릭하십시오. 새로운 Pairing 4 검사 항목이 Pairing Inspection Items 목록에 추가됩니다. Inspection Conditions 메뉴에 직선 거리 정보가 Straight-line Distance (Radius)로 표시됩니다. 측정 방식 - 직경 Add Pairing Inspection 툴 바에서 Pairing 4 검사 항목을 클릭하고, Use 3 Objects 또는 Use 4 Objects 모드를 선택하십시오. Measurement 옵션은Diameter를 선택하십시오. PCB 뷰어에서 오브젝트를 선택하여 추가한 후, Apply를 클릭하십시오. 새로운 Pairing 4 검사 항목이 Pairing Inspection Items 목록에 추가됩니다. Inspection Conditions 메뉴에 직선 거리 정보가 Straight-line Distance (Diameter)로 표시됩니다."
},
{
"toc_id": "chapter08_heading02_sub02_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "페어링 검사 – Pairing 4 직선 거리 측정 옵션 추가",
 "title2": "결과 확인",
 "body": "Pairing 4 검사에서 Radius 또는 Diameter 모드를 선택하고 수동 검사를 진행하십시오. 검사가 끝나면, Defect View에 Pairing 4 검사 결과가 표시되며, 선택한 모드에 따라 반경(Radius) 또는 직경(Diameter) 거리 값을 확인할 수 있습니다."
},
{
"toc_id": "chapter08_heading03_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "부품의 각도에 따른 ROI 재정렬",
 "title2": "",
 "body": "기존에는 부품의 방향성을 고려하지 않고 절대 위치로만 Base ROI를 확장하여 사용했기 때문에 미러링된 배열에 포함된 부품은 Base ROI의 방향성이 따라 가지 않는 문제가 있었습니다. 이를 해결하기 위해, Base ROI가 부품의 방향성을 고려하여 재정렬하는 기능이 추가되었습니다."
},
{
"toc_id": "chapter08_heading03_sub01_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "부품의 각도에 따른 ROI 재정렬",
 "title2": "제약 사항",
 "body": "Base ROI Expansion Mode - By keyboard인 경우에만 적용됩니다. Base ROI는 0도(Zero Rotation)기준으로 설정해야 합니다. 반시계방향(CCW)을 기준으로 Rotation을 보상합니다."
},
{
"toc_id": "chapter08_heading03_sub02_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "부품의 각도에 따른 ROI 재정렬",
 "title2": "설정 방법",
 "body": "Body &gt; Presetting &gt; 3D Base Parameter &gt; Base ROI Expansion Mode를 ‘By Keyboard’로 설정하십시오. 하위에 생성된 Use Zero Rotation Alignment를 ‘Use(Zero Rot. Align)’로 설정하십시오. 수동 검사 후, 미장착(Missing) 검사 결과를 확인하여 Base ROI 재설정하십시오. Defect Viewer - Missing 검사 결과에 표시된 Base ROI 방향 확인 (0도 기준 Base ROI 방향) Base ROI 방향을 확인한 후 Base ROI 방향(Left/Top/Right/Bottom) 재설정 수동 검사를 다시 진행하여 Base ROI가 재정렬되었는지 확인하십시오."
},
{
"toc_id": "chapter08_heading04_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "Cavity 내측 영역 및 오프셋 측정 기능",
 "title2": "",
 "body": "Cavity 내측의 영역을 구별하고 Cavity 영역 내에 실장 되어 있는 실리콘 Capacitor(SC)의 오프셋을 측정할 수 있도록 기능이 개선되었습니다."
},
{
"toc_id": "chapter08_heading04_sub01_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "Cavity 내측 영역 및 오프셋 측정 기능",
 "title2": "설정 방법",
 "body": "Body &gt; Presetting &gt; Body Finding &gt; Body Location Mode &gt; Sub Inspection Mode에서 ‘2D Feature’를 선택하십시오. Use Double Location 옵션을 ‘On (Cavity)’으로 설정하십시오. Cavity Mode에서 ‘Inner’, ‘Outer’, ‘Both’ 중 영역을 선택하고, 각 하위 파라미터들을 설정하십시오. Image Plane: Outer 영역의 외곽이 잘 표현된 영역과, 부품과 Inner cavity 영역 사이가 검정색으로 잘 표현된 영상면을 선택 Margin from Body(um): 부품 영역의 경계로부터 설정한 값만큼 Inner 영역 탐색 범위로 지정. 하기 이미지에서 Inner 영역인 검정색 영역이 포함되도록 설정 값을 조절해야 탐색 성능을 높일 수 있음. Morphology Size: Outer 영역 탐색을 위한 Morphology 연산의 크기. 해당 값이 클수록 Outer 영역을 넓게 잡을 수 있음."
},
{
"toc_id": "chapter08_heading05_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "Plate &amp; Bid 검사 조건 추가",
 "title2": "",
 "body": "ICB 부품 검사 요구에 대응하여 Plate와 Bid를 추출할 수 있는 신규 검사 조건이 새롭게 추가되었습니다. 검사 요구 AOI 검사 항목 Bid Offset 검사 Pad Overhang Bid 외관 검사 Lead Foreign Material Plate &amp; Bid Location Double Body Location Plate &amp; Bid 치수 검사 Dimension 검사"
},
{
"toc_id": "chapter08_heading05_sub01_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "Plate &amp; Bid 검사 조건 추가",
 "title2": "설정 방법",
 "body": "Body &gt; Presetting &gt; Body Finding &gt; Body Location Mode를 ‘Others’로 설정하십시오. Sub Inspection Mode를 ‘2D Feature Finding’으로 설정하고, Plate 추출을 위한 검사 조건을 입력하십시오. Double Location &gt; Use Double Location 옵션을 ‘On(ICB Double)’로 설정한 후, Bid 추출을 위한 검사 조건을 입력하십시오. 검사 진행 후, 입력한 검사 조건에 따른 검사 결과를 아래와 같이 확인할 수 있습니다. Missing Dimension Pad Overhang Coplanarity"
},
{
"toc_id": "chapter08_heading06_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "부품 바디 회전에 따라 ROI가 회전되도록 개선",
 "title2": "",
 "body": "Upside Down, Coplanarity, Polarity, OCVR 등의 바디 검사에서 부품의 바디가 회전된 경우, 검사 ROI도 부품의 각도만큼 회전되도록 설정할 수 있습니다."
},
{
"toc_id": "chapter08_heading06_sub01_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "부품 바디 회전에 따라 ROI가 회전되도록 개선",
 "title2": "사용 방법",
 "body": "Body &gt; Polarity/Coplanarity/Upside Down &gt; Parameter 에서 Body Offset 옵션을 ‘Use’로 설정하십시오. Body &gt; OCVR &gt; Parameter 에서 Body Offset during Inspection옵션을 ‘Use’로 설정하십시오. 수동 검사를 진행한 후, 아래와 같이 결과를 확인할 수 있습니다."
},
{
"toc_id": "chapter08_heading07_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "페어링 검사 – Pairing 8 검사 항목 추가",
 "title2": "",
 "body": "2개 Line의 교차점(Reference Point)에서 부품 또는 특징점의 중심점(Target Point)까지의 X, Y 거리를 측정하는 Pairing 8 검사 항목이 추가되었습니다."
},
{
"toc_id": "chapter08_heading07_sub01_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "페어링 검사 – Pairing 8 검사 항목 추가",
 "title2": "사용 방법",
 "body": "Board Programming 탭으로 이동한 후, Pairing Inspection 탭에 체크하십시오. Add Pairing Inspection 툴바에서 Pairing 8 검사 항목을 클릭하십시오. 우측 Reference Items의 Add 버튼을 클릭하고, Reference Line 1과 Reference Line 2로 설정할 오브젝트를 선택하십시오. 오브젝트 설정이 끝나면 Apply를 클릭하여 검사 항목을 추가합니다. Inspection Conditions에서 X, Y 거리 Tolerance를 입력한 후 Apply를 클릭하십시오. 수동 검사를 진행하여 검사 결과를 확인하십시오."
},
{
"toc_id": "chapter08_heading08_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "바코드 – Grinding Pattern 제거 알고리즘 적용",
 "title2": "",
 "body": "경면 부품 위의 Grinding Pattern 방식의 바코드를 인식 시 노이즈로 인한 바코드 검사 성능이 저하되는 문제가 있었습니다. 새로운 AOI 버전에서는 Machine Learning 기반으로 Grinding Pattern을 제거하고 필터를 사용하여 바코드 영역과 배경 영역을 분리하여 바코드 인식 성능을 개선하였습니다. 적용 전 적용 후 ※ 참고: 이 기능을 사용하려면 AI Engine 및 AOI AI Model 최신 버전을 사용해야 합니다. ※ 참고 - VisionConfig.ini 파일에서 하기 항목이 최소 ‘1’ 이상으로 설정되어 있어야 합니다. CamBarcode_Deraining_Deivide_View=1 - 패턴을 제거할 때 입력 영상을 몇 개로 나누어 진행할 지 설정하는 것으로, 값이 커질수록 속도가 저하될 수 있습니다."
},
{
"toc_id": "chapter08_heading09_KOR.html",
 "chapter_i": "8",
 "chapter": "Other Improvements",
 "title": "경면 부품 검사 성능 향상",
 "title2": "",
 "body": "Die 부품 특성상, 부품 높이 및 외곽 측정 값에 편차가 크게 발생하는 어려움이 있었습니다. 새로운 AOI 버전에서는 추가적인 검사 조건 설정 없이 Die 설정 유무와 Embedded Component의 자동 분류 및 노이즈 제거 등 개선된 알고리즘을 적용하여 경면 부품의 높이 및 외곽 측정 성능을 강화하였습니다. 개선 전 개선 후 ※ 참고 - 이 알고리즘을 적용하지 않으려면, VisionConfig.ini 파일에서 Remove_Mirror_Saturation_Bucket 값을 ‘0’으로 변경하십시오. (Default: On (1)) - VisionConfig의 Embedded_Comp_Thresh를 조정하여, Embedded Component 판정 기준을 조정할 수 있습니다. (Default: 50um)"
},
{
"toc_id": "chapter09_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "",
 "title2": "",
 "body": ""
},
{
"toc_id": "chapter09_heading01_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "[Halcon Free] Fastred SW 개발",
 "title2": "",
 "body": "기존의 Halcon 라이브러리를 대체할 수 있도록 opencv를 이용하여 자체 개발한 Fastred 버전이 추가되었습니다. ※ 참고: Fastred SW 버전의 설치 방법 및 상세 안내 사항은 추후 별도의 문서로 배포될 예정입니다."
},
{
"toc_id": "chapter09_heading02_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "[Zenith T] AOI SW(GUI) 개발",
 "title2": "",
 "body": "탁상형 AOI인 Zenith T 모델용 GUI가 개발되었습니다."
},
{
"toc_id": "chapter09_heading03_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "Pad Overhang - 리드 팁 기반의 Center XY 측정 모드 추가",
 "title2": "",
 "body": "측정된 리드 팁의 위치를 기준으로 부품 바디의 길이, 너비 및 회전 오프셋을 계산하는 새로운 Pad Overhang 검사 모드가 추가되었습니다."
},
{
"toc_id": "chapter09_heading03_sub01_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "Pad Overhang - 리드 팁 기반의 Center XY 측정 모드 추가",
 "title2": "사용 방법",
 "body": "Body &gt; Pad Overhang &gt; Inspection Mode &gt; Mode에서 ‘Lead Tip Based Center XY’를 선택하십시오. 부품 검사를 진행 후, 결과를 확인하십시오."
},
{
"toc_id": "chapter09_heading04_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "LED Straightness 및 Tilt 측정 알고리즘",
 "title2": "",
 "body": "기존에는 LED Straightness(직선성) 및 Tilt(기울기)를 측정하려면 Odd Shape 알고리즘을 적용해야 하는 불편함이 있었습니다. 신규 버전에서는 LED 부품에 적용할 수 있는 알고리즘이 추가되었습니다. ※ 참고: LED Straightness(B2B) 검사는 Package Type이 LED 인 경우에만 적용할 수 있습니다."
},
{
"toc_id": "chapter09_heading04_sub01_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "LED Straightness 및 Tilt 측정 알고리즘",
 "title2": "설정 방법",
 "body": "AOISetup.ini 파일을 열고 CustomerNumber 항목에 ‘4164’를 입력하십시오. PCB Setting &amp; Info 창에서 아래 두 항목을 선택하십시오. Use BodyToBody Use Array Grade"
},
{
"toc_id": "chapter09_heading04_sub02_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "LED Straightness 및 Tilt 측정 알고리즘",
 "title2": "사용 방법",
 "body": "LED Straightness 측정(B2B) Body &gt; Pad Overhang 메뉴로 이동하십시오. Parameter &gt; Center XY &gt; Extra Offset Check by Group을 ‘Use’로 설정하십시오. Distance Check을 ‘On(Distance)’으로 설정한 후, 허용치를 입력하십시오 LED Tilt 측정 Body &gt; Coplanarity 메뉴로 이동하십시오. Inspection Mode &gt; Slope Mode를 ‘On(Slope)’로 설정하고, Decision Logic을 설정하십시오. Tolerance &gt; [Slope Mode]Max. Angle Difference 하위의 허용치를 설정하십시오. ROI &gt; [Slope Mode]Individual ROI 에서 ROI를 설정하십시오. 검사를 진행한 후 아래와 같이 결과를 확인할 수 있습니다."
},
{
"toc_id": "chapter09_heading05_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "Thickness 오프셋 측정 옵션 추가",
 "title2": "",
 "body": "Height Map에서 측정된 Thickness 높이 값에 사용자가 원하는 수치를 더할 수 있는 옵션이 추가되었습니다. Thickness offset: 0 Thickness offset: 10 ※ 유의 사항 - Thickness offset 값을 설정하면, 복원된 3D 형상과 측정된 높이 값에 괴리가 있기 때문에 사용자가 혼란을 느낄 수 있습니다. 이에 대한 주의가 필요합니다."
},
{
"toc_id": "chapter09_heading06_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "Glass PCB 검사 기능 추가",
 "title2": "",
 "body": "BLU 시장에서 투명한 재질의 PCB 검사에 대한 요구가 점차 증가함에 따라, Glass PCB에서도 안정적인 Base를 확보할 수 있는 검사 기능이 개발되었습니다."
},
{
"toc_id": "chapter09_heading06_sub01_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "Glass PCB 검사 기능 추가",
 "title2": "사용 방법",
 "body": "VisionConfig.ini 파일을 열고 ‘Use_Removing_Base_Wave’ 항목을 ‘1’로 설정하십시오. Use_Removing_Base_Wave=1 Body &gt; Presetting &gt; 3D Parameter 하위 메뉴 중 3D Reconstruction in FOV 옵션을 ‘Use(FOV)’로 설정하십시오. 3D Base Parameter 하위 메뉴 중 Base Setting 옵션을 ‘Manual’로 설정하십시오. Base Setting의 하위 메뉴 중 3D Shape Shifting 입력란에 예상 오프셋 값(um)을 입력하십시오. ※ 참고: 3D Shape Shifting에 설정하는 예상 오프셋 값(um)에는 PCB의 두께를 입력하십시오."
},
{
"toc_id": "chapter09_heading07_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "OCVR Mask 확장 기능 추가",
 "title2": "",
 "body": "OCVR 검사에서 추출된 OCVR Mask가 완전히 제거되지 않은 경우, FM 검사에서 해당 영역을 이물로 오추출하여 가성불량이 발생하는 문제가 있었습니다. 이를 개선하기 위해 OCVR Mask를 확장하는 기능을 추가하였으며, 확장하고자 하는 Mask 크기를 사용자가 설정할 수 있습니다."
},
{
"toc_id": "chapter09_heading07_sub01_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "OCVR Mask 확장 기능 추가",
 "title2": "제약 사항",
 "body": "Mask 확장 크기는 ‘um’ 단위로 입력할 수 있으며, Default 값은 '0'입니다. 음수를 입력할 경우, 이 기능은 동작하지 않습니다. 입력 값은 검사 영역과 부품의 이미지 크기 안에서만 설정할 수 있습니다."
},
{
"toc_id": "chapter09_heading07_sub02_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "OCVR Mask 확장 기능 추가",
 "title2": "설정 방법",
 "body": "VisionConfig.ini 파일에서 Body_FM_OCVRMask_Extension_Um항목에 값을 입력하십시오. Default: 0 Minimum: 0 Maximum: 검사 영역과 부품 이미지 사이즈를 벗어나지 않는 범위에서 자동 설정됨. ※ 참고: OCVR Mask의 확장 크기는 사용 편의상 ‘um’ 단위로 입력하지만, 알고리즘 내부에서는 Pixel 단위로 변환하여 사용됩니다. 따라서, Pixel 단위 변환 시 내림되는 특성이 있으므로, 장비 분해능(resolution)보다 작은 값을 입력할 경우 실제 확장 영역은 변화가 없을 수 있습니다. 예시) 장비 Resolution 10um 일 경우, VisionConfig.ini 의 'Body_FM_OCVRMask_Extension_Um = 3' 으로 설정할 경우 최종적으로 적용되는 OCVR Mask 확장 Pixel 값은 '0' 입니다. &#x9f; 20um 설비의 최소 입력 값: ‘20’ &#x9f; 15um 설비의 최소 입력 값: ‘15’ &#x9f; 10um 설비의 최소 입력 값: ‘10’"
},
{
"toc_id": "chapter09_heading08_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "솔더 조인트 3D 품질 향상",
 "title2": "",
 "body": "일부 패키지 타입 검사에서 솔더 조인트의 3D 품질이 향상되었습니다. 지원 가능한 패키지 타입: QFP, SOIC, SOT, DPACK, CONNECTOR, CHIPARRAY, CRYSTAL, ALUMINUM CAPACITOR, QFN 실물 개선 전 개선 후 ※ 참고: 솔더 필렛의 실제 형상이 정상일 경우에만 3D 품질이 향상되며, 이중 반사나 냉납 등의 경우에는 3D 성능 향상을 기대할 수 없습니다."
},
{
"toc_id": "chapter09_heading08_sub01_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "솔더 조인트 3D 품질 향상",
 "title2": "설정 방법",
 "body": "Package Type을 QFP, SOIC, SOT, DPACK, CONNECTOR, CHIPARRAY, CRYSTAL, ALUMINUM CAPACITOR, 또는 QFN 로 설정하십시오. Lead &gt; Presetting &gt; Solder Fillet &gt; 3D Inspection Mode를 ‘Advance(Side)’로 설정하십시오. ※ 참고: VisionConfig.ini 파일에서 Lead Top Denoising 기능을 아래와 같이 활성화할 경우, 추가적으로 3D 품질을 향상시킬 수 있습니다"
},
{
"toc_id": "chapter09_heading09_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "[삼성 수원] OCVR 바코드를 통한 오삽 검사",
 "title2": "",
 "body": "사양이 비슷한 BGA 간의 오삽 검사 시, 외형 크기 및 문자 검사만으로는 정확한 검사가 어려웠습니다. 이를 개선하기 위해, 제조사로부터 전달받은 제품의 바코드와 AOI에서 인식한 OCVR 바코드를 비교하여 오삽을 검사할 수 있는 기능이 개발되었습니다. 판정 기준이 되는 부품의 바코드 정보를 OCV 검사 조건 창에서 입력하지 않고, 별도의 저장 공간에 출력된 데이터를 조회하여 판정함. 데이터 파일 내에 있는 결과를 조회해서 해당 내용이 있으면 양품으로 결과 출력 바코드 손상으로 인한 Fail 은 불량으로 처리 파일 내 조회 결과 양품은 양품으로 표시 파일 내 조회 결과 바코드 정보가 없으면 불량으로 표시"
},
{
"toc_id": "chapter09_heading09_sub01_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "[삼성 수원] OCVR 바코드를 통한 오삽 검사",
 "title2": "설정 방법",
 "body": "AOI Config &gt; MES Option에서 하기 옵션들을 설정하십시오. Wait MES response for Vision Inspection Complete: True MES response Waiting Time for Vision Inspection Complete: [msec] BRM으로 Message 송신 후, 회신 대기 시간 설정 msec 단위로 설정, 해당 시간이 지나면 알람 발생 Inspection Result Item: None/Barcode On Component MES I/F - MAICR, MAICR_R 사용 기반 Defect Type에 따른 항목 확장 가능 None: 공백 문자열을 송신, 수신 시, 처리 구문 없음 (단, BRM Message 수신 대기) Barcode On Component: Json Format의 Barcode Component 정보 재 판정 기능 사용 GTC – PGM: False ※ 참고: 이 기능을 사용하려면 고객사를 Samsung으로 선택했을 때 활성화되는 GTC-PGM 옵션을 ‘False’로 설정해야 합니다. AOIGUI &gt; Settings로 이동하여 아래 항목들을 설정하십시오. Data/Export&gt; MES &gt; Use MES 선택 Data/Export &gt; Display &gt; Show All Results(Good+Fail) 선택 시, Defect View &gt; Result Database/Image Caption에 모든(Good, Fail) 결과가 표시됨. 선택 해제 시, Defect View &gt; Result Database/Image Caption 에 Fail 결과만 표시됨. 설정 (All - Good, Fail) 해제 (Only Fail) Data/Export &gt; Display &gt; Barcode Inspection On Component &gt; Save Barcode on Component Always(NG + GOOD) 선택 시, SQL Database - KY_Result_주차 DB의 CompBarcode에 모든(Good, NG) 결과 업데이트 선택 해제 시, SQL Database - KY_Result_주차 DB의 CompBarcode에 NG 결과만 업데이트 설정 해제 Case 1 (Save - Fail, Good 설정의 결과에 따름 - Defect Result Off / Good Result Off) 해제 Case 2 (Save - Fail, Good 설정의 결과에 따름 - Defect Result On / Good Result Off) Save - Fail, Good On/Off UI Data/Export &gt; Display &gt; Barcode Inspection On Component &gt; Judge Good even if not recognized: 선택 해제 ※ 주의: Judge Good even if not recognized 옵션 선택 시, 결과 데이터가 기록되지 않습니다. Data/Export &gt; Display &gt; OCR Result &gt; Save Always(NG + GOOD) 선택 ※ 주의: Save Always(NG+GOOD) 선택 해제 시, AOI의 OK 판정 결과를 BRM 으로 전송하지 않습니다. AOIGUI &gt; PCB Settings 창으로 이동하여, 하기 항목을 설정하십시오. Barcode on component for mes: 판정 필요 항목 설정 (Level, Array, Name = Component) Level - None: 기능 미사용 (모든 어레이 및 부품 조건 불만족) Level - PCB: 설정한 어레이와 부품에 해당되는 경우 재판정 (설정한 어레이 및 설정한 부품인 경우) Level - Array: 설정한 부품에 해당되는 경우 재판정 (모든 어레이, 설정한 부품인 경우) Level - All: 모든 바코드 재판정 특수 문자 * 입력 시, All과 같은 의미 PCB, Array 설정 예시 : Level - All 과 같은 의미 : Array 2 &amp; All Component : All Array &amp; IC40 : Array 2 &amp; IC40 (Base Model) : All Array &amp; IC39 (Base Model) : All Array &amp; All Component"
},
{
"toc_id": "chapter09_heading09_sub02_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "[삼성 수원] OCVR 바코드를 통한 오삽 검사",
 "title2": "결과 확인",
 "body": "Json File 송신 (MAICR) 송신 정보 저장 경로: C:\\KohYoung\\maicr.json Log File 경로: C:\\KYLOG\\AOIGUI\\KYLOG-AOIGUI-날짜.LOG Log File 이력: 검색어 \x22insert Defect Info\x22 정보의 내용은 PCB Setting의 BIOC 조건을 만족하는 Component를 json file 로 기록 수신 (MAICR_R) 수신 정보 저장 경로: C:\\KohYoung\\maicr_r.json Log File 경로: C:\\KYLOG\\AOIGUI\\KYLOG-AOIGUI-날짜.LOG Log File 이력: 검색어 \x22Receive Json Format Msg\x22 정보의 내용은 송신한 Component에 해당하는 재판정 결과를 json file 로 기록 Defect View Display Result Database Display 최종 검사 결과를 표기함 (AOI 결과 유지, BRM 재판정에 의한 결과 변경에 관계없음) Image Caption Display 재 판정 시, 결과가 변경된 경우 만 표기"
},
{
"toc_id": "chapter09_heading10_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "[Intel] SPTD Automation",
 "title2": "",
 "body": "SECSGEM의 상태를 AOIGUI에 추가하여, 에러 발생시 검사를 진행하지 않고 바이패스 처리하도록 하는 옵션이 추가되었습니다."
},
{
"toc_id": "chapter09_heading10_sub01_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "[Intel] SPTD Automation",
 "title2": "설정 방법 - AOI Config",
 "body": "BRM 연동 옵션 KY I/F &gt; Use PKGMsg: True RTCMD 사용을 위한 옵션 Wait mes response for RTCMD: True Inline Barcode Pre Check 사용 옵션 Wait mes response for Pre Check: True MES response timeout message in prebuffer (only Inline barcode):True (인라인 바코드가 Pre Buffer에 있을 경우)"
},
{
"toc_id": "chapter09_heading10_sub02_KOR.html",
 "chapter_i": "9",
 "chapter": "대외비 기능 (Confidential)",
 "title": "[Intel] SPTD Automation",
 "title2": "설정 방법 - AOIGUI Settings",
 "body": "MES Use MES Use Inline Barcode pre-check when barcode is not recongnized Check BYPASS by MES when error occurs"
},
{
"toc_id": "Info.html",
 "chapter_i": "10",
 "chapter": "문서 정보",
 "title": "",
 "title2": "",
 "body": "Attached Manual_Internal AOI 2.8.0.0 Release Notes AOI Ver. 2.8.0.0 Copyright © 2023 Koh Young Technology Inc. All Rights Reserved."
},
{
"toc_id": "chapter00_heading01_KOR.html",
 "chapter_i": "10",
 "chapter": "문서 정보",
 "title": "저작권 및 면책조항",
 "title2": "",
 "body": "이 매뉴얼은 ㈜고영테크놀러지의 서면 승인 없이는 전체 또는 일부를 복사, 복제, 번역 또는 그 어떠한 전자매체나 기계가 읽을 수 있는 형태로 출판될 수 없습니다. 이 매뉴얼은 ㈜고영테크놀러지의 통제 하에 있지 않는 기타 업체로의 웹사이트 링크를 포함하고 있을 수도 있으며, ㈜고영테크놀러지는 링크된 그 어떠한 사이트에 대해서도 책임을 지지 않습니다. 또한, 출처를 미처 밝히지 못한 인용 자료들의 저작권은 원작자에게 있음을 밝힙니다. 혹시라도 있을 수 있는 오류나 누락에 대해 ㈜고영테크놀러지는 일체의 책임을 지지 않습니다. 제품의 버전이나 실행되는 형태에 따라 사진이 다를 수도 있습니다. 사양이나 사진은 매뉴얼 제작 시점의 최신 자료에 기초하고 있으나, 예고 없이 변경될 수도 있습니다."
},
{
"toc_id": "chapter00_heading02_KOR.html",
 "chapter_i": "10",
 "chapter": "문서 정보",
 "title": "개정 이력",
 "title2": "",
 "body": "개정 번호 날짜 설명 작성자 1.0 2023-05-31 문서 작성 - GUI 팀, Vision 팀 - TW: 이루리 ﻿ ﻿ ﻿ ﻿"
}
]