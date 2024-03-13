var search=[
{
"toc_id": "chapter01_KOR.html",
 "chapter_i": "1",
 "chapter": "개요",
 "title": "",
 "title2": "",
 "body": "CEditor는 ePM-SPI에서 생성한 PAD 파일(*.pad)과 사용자의 CAD 파일을 병합하여 JOB 파일(*.mdb)을 생성하는 프로그램입니다. CEditor의 주요 기능은 다음과 같습니다. PAD 파일 및 CAD 파일의 변환 특정 패드의 검사 Tolerance 값(기준값)을 입력/변경 일련의 패드를 그룹으로 묶어 Part name과 ComponentID를 부여 PAD 파일과 CAD 파일을 병합하여 3D Inspector에서 사용하는 작업 파일인 JOB 파일로 변환하여 저장"
},
{
"toc_id": "chapter02_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "",
 "title2": "",
 "body": "이 장에서는 CEditor의 화면 구조에 대해 설명합니다. CEditor의 화면은 아래와 같이 구성됩니다."
},
{
"toc_id": "chapter02_heading01_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 메뉴",
 "title2": "",
 "body": "CEditor 화면의 가장 상단에 있는 메인 메뉴에는 다음 2가지 항목이 있습니다."
},
{
"toc_id": "chapter02_heading01_sub01_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 메뉴",
 "title2": "파일 메뉴",
 "body": "파일 메뉴의 주요 기능은 다음과 같습니다. PAD 파일(*.pad) 로드 JOB 파일(*.mdb) 로드/저장 CAD 파일 로드/적용 CSV 파일(*.csv)형식으로 작업 사항을 저장 항목 기능 PAD파일 불러오기 PAD 파일(*.pad) 로드 JOB파일 불러오기 JOB 파일(*.mdb) 로드 JOB파일 저장하기 작업 중인 JOB 파일을 저장 다른이름으로 JOB파일 저장하기 작업 중인 JOB 파일을 다른 이름으로 저장 Save Network Job 네트워크를 통해 Job 파일을 저장 Save Network Job as 네트워크를 통해 Job 파일을 다른 이름으로 저장 Load CAD-default CAD 파일 로드 Pin CAD파일 불러오기 Pin CAD 파일 로드 AD파일 가져오기 FABMASTER FATF 및 Mentor Neutral 형식의 CAD 파일 로드 Report 가져오기 CSV 파일(*.csv) 로드 Report 내보내기 CSV 파일로 저장 사용자 편집 현재 사용자를 변경 나가기 프로그램 종료"
},
{
"toc_id": "chapter02_heading01_sub02_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 메뉴",
 "title2": "도구 메뉴",
 "body": "도구 메뉴의 주요 기능은 다음과 같습니다. 프로그램 화면 회전/대칭/이동 적용된 CAD 파일 회전/대칭 패드 추가 및 편집 항목 기능 PCB 정보 해당 PCB의 정보 변경 Pads Shift 전체 혹은 선택 패드의 위치 이동 Component Size Rotation Component ID의 폭과 길이 설정 CAD Rotation CAD 자료를 90도 회전 CAD Mirror X CAD 자료를 X축 기준으로 회전 CAD Mirror Y CAD 자료를 Y축 기준으로 회전 PAD Rotation 90 degree 선택된 패드들을 패드의 외곽선을 기준으로 90도 회전 PAD Rotation - 90 degree 선택된 패드들을 패드의 외곽선을 기준으로 -90도 회전 PAD 추가 패드를 추가/생성 PAD 편집 PAD 파일 편집 PAD 삭제 선택한 패드 삭제 PAD 병합 Gerber 파일을 변환해 만든 PAD 파일을 현재의 JOB 파일에 병합 패드 간격 측정 두 개의 패드 사이 거리를 측정 수동 핀 배치 핀 번호를 수동으로 지정 PAD 검색 &amp; 선택 특정 속성의 패드를 찾아 선택 Library Editor Library 별로 검사 조건을 편집 Size Library Edit 패드의 사이즈나 모양 별로 그룹을 형성하여, 검사 조건을 자동 입력 Master Library Editor 사용자가 설정한 Library Data를 서버에 업로드 또는 클라이언트에서 다운로드하여 관리할 수 있는 기능을 위한 편집 Block Component Editor 특정 Component에서 불량이 발생하였을 경우 Defact View에서 PASS를 하지 못하도록 하는 제한하는 기능(Block Component)을 사용하기 위한 Component List 편집 CAD 형식 설정 CAD 파일을 열어 형식 설정 Stencil Complexity Setup Pad의 면적비에 따라 프린트 복잡도를 설정한 후 해당 PCB의 Print 난이도를 계산하는 기능 FOV 최적화 FOV의 이동 경로를 시뮬레이션 Panel Rotation Teaching Tool KSMART Warp 기능 사용 시 각 Panel의 각도 값을 수동으로 Teaching 하는 기능 Options JOB 파일을 저장할 폴더를 설정 프로그램정보 CEditor의 버전과 시스템 정보 확인 ※ 참고: 위 항목들 중 Edit Pad, Merge Pad, Edit Layer, Manual Pin Assign, Library Editor, Size Library에 대해 상세한 사항은 다음 페이지부터 설명하겠습니다. Edit PAD 패드를 선택한 후 메인 메뉴에서 Tools &gt; Edit PAD를 클릭하여 패드를 편집할 수 있습니다. 항목 기능 RECT 사각 패드로 변경 시 선택 CIRCLE 원형 패드로 변경 시 선택 UNDEFINE 모양을 정의할 수 없는 패드일 경우 선택 R_RECT 모서리가 둥근 사각 패드일 경우 선택 OBLONG 타원 패드일 경우 선택 N.SLOP 하나의 패드를 선택하여 입력한 –각도로 회전 P.SLOP 하나의 패드를 선택하여 입력한 +각도로 회전 G.TAB Gold Tab일 경우 선택 Outside Hole Extend ROI에 Via Hole이 존재하는 패드 Inside Hole Extend ROI보다 안쪽에 Via Hole이 존재하는 패드 B.BadMark Black Bad Mark로 선택 W.BadMark White Bad Mark로 선택 L.F.Rect, L.F.Circle, L.F.Etc Local Fiducial로 선택 (Rect/Circle/Etc: Fiducial 모양) Tape.L, Tape.R PCB를 고정하기 위한 Tape 검사를 할 경우 선택 - Tape L: Tape의 ROI왼쪽에 위치 - Tape R: Tape이 ROI오른쪽에 위치 MultiBlob 단일 패드가 여러 개의 개구부로 나뉜 경우 선택 ROT.ETC T형이며 각도가 있는 패드일 경우 선택 S.Diamond, L.Diamond 다이아몬드 모양 패드일 경우 선택 - S: ROI 안에 주변 패드가 들어오는 경우 - L: ROI 안에 주변 패드가 들어오지 않는 경우 QFP QFP 패드일 경우 선택 Laser. P Laser Pointer로 높이를 측정하기 위한 패드일 경우 선택 Corner ㄱ 혹은 ㄴ 자 같은 형태의 패드일 경우 선택 Bond Land Ceramic board에만 존재하는 특수 패드일 경우 선택 Merge PAD Tools &gt; Merge PAD는 현재의 JOB 파일에 GerbPAD나 ePM-SPI 프로그램으로 생성한 PAD 파일을 병합할 때 사용합니다. ※ 참고: 이 기능은 JOB 파일과 병합할 PAD 파일에 동일한 패드가 존재해야 사용할 수 있습니다. Tools &gt; Merge PAD를 선택하면 다음과 같은 화면이 나타납니다. 새롭게 합칠 패드와 동일하게 존재하는 패드를 선택하십시오. 패드를 선택하면 다음과 같은 메시지가 나타납니다. 올바른 패드를 선택했다면 예 버튼을 클릭하십시오. 파일 선택창에서 합칠 PAD 파일을 선택하고 열기 버튼을 클릭한 후 PCB 정보를 입력하십시오. Merge Job file 창이 나타납니다. 여기에서 기존 JOB 파일과 중복되는 패드를 선택하십시오. ※ 참고: 이때, 기존 JOB 파일과 원점이 다르다면, Rotation 기능과 Flip 기능을 사용하여 원점이 일치하도록 맞추십시오. 동일한 패드를 선택한 후, 예 버튼을 클릭하십시오. 그러면 기존 JOB 파일에 새롭게 선택한 PAD 파일이 추가되고 우측 상단에 진행 상황을 보여 주는 화면이 나타납니다. Manual Pin Assign Tools &gt; Manual Pin Assign에서는 핀 번호가 부여되지 않은 패드에 핀 번호를 수동으로 지정할 수 있습니다. 이 기능을 사용하면 1번으로 정의한 핀을 기준으로 하여 지정한 방향 순으로 선택한 패드들에게 핀 번호를 자동으로 부여할 수 있습니다. 항목 기능 Order by 핀 번호가 부여되는 방향 선택 - Row: 가로 방향 순서로 부여 - Column: 세로 방향 순서로 부여 - Clockwise: 시계방향 순서로 부여 - Counterclockwise: 반 시계 방향 순서로 부여 Pin 1 선택한 패드들에 핀 번호를 부여할 때, 기준으로 할 패드를 1번 핀으로 설정 StartNo 핀 번호를 부여할 때 시작되는 숫자나 문자 입력 Use Alphabet 선택한 항목에 따라서 열 혹은 행이 바뀔 때 알파벳을 부여 BGA 같은 부품에 이 기능을 사용할 경우 선택 Apply JEDEC 표준에 따를 경우 선택 이 기능을 사용하면, 알파벳 형식으로 번호를 부여할 때, 숫자와의 혼동을 방지하기 위해 I 같은 문자는 사용하지 않음. Use Alphabet 항목을 선택했을 경우에만 선택 가능 ※ 참고 - Use Alphabet 항목의 경우, Row와 Column 옵션을 선택해야 사용할 수 있습니다. - Apply JEDEC Format 항목의 경우, Use Alphabet 옵션을 선택해야 사용할 수 있습니다. Library Editor 이 항목은 Part library 별로 검사 조건을 편집할 때 사용합니다. CAD 파일의 Part library 이름을 이용하여 검사 조건을 설정할 때 이 항목을 사용하면, Part library 이름 별로 검사 조건을 확인하거나 여러 검사 조건을 동시에 변경할 수 있습니다. 항목 기능 Edit 선택한 library의 검사 조건 변경 Delete 선택한 library 항목 삭제 Pad View 선택한 library가 적용되어 있는 패드 표시 Save 변경한 library 저장 Use Server Library 서버를 이용할 때 선택 Library 서버가 설치되어 있는 PC의 IP 주소 입력, 입력한 IP 주소에 따라 서버 접속 및 동기화 Connect CEditor를 서버에 연결 Sync 서버에 있는 library와 현재 장비에 있는 library를 병합 Size Library 이 항목은 패드의 사이즈나 모양 별로 그룹을 형성하여, 검사 조건을 자동으로 입력할 때 사용합니다. 이 항목에서 형성한 library는 장비 전체에서 공유할 수 있습니다. 사용 환경 ㈜고영테크놀러지의 SPI 장비나 CEditor가 설치되어 있는 Offline PC 네트워크를 구축해 놓은 환경에서 library 공유 가능 사용 방법 CEditor를 실행한 후 Tools &gt; Size Library Editor를 선택하십시오. Load 버튼을 클릭하여 원하는 library 파일을 선택하십시오. ※ 참고: 설정 파일을 로드한 상태라면 새로 생성하지 않아도 됩니다. 그룹의 이름과 원하는 형태(All, Rectangle, Square, Circle, ETC) 중 하나를 선택하십시오. 해당 그룹에 맞는 나머지 조건을 입력하십시오. ADD 버튼을 클릭하여 조건 그룹을 추가하십시오. 그룹을 선택한 후 Edit 버튼을 클릭하십시오. 선택된 그룹에 대한 검사조건을 변경할 수 있습니다. JOB 파일을 로드한 후 Update JOB 버튼을 클릭하거나, JOB 파일을 새로 생성하십시오. ※ 참고: Update JOB 버튼을 클릭하면 현재 PCB의 패드들을 Size Library의 설정대로 그룹화할 수 있습니다. 해당 JOB 파일에 설정된 그룹을 찾았을 경우 그룹에 자동으로 등록됩니다. 따라서 특정 패드의 그룹 정보 확인 및 그룹의 검사 조건 변경이 용이합니다. ※ 참고: 패드에 설정된 검사 조건이 2개 이상일 경우, Library List의 위에서 아래 순으로 검사조건이 적용되며 우선순위는 조정 가능합니다. 수동으로 설정한 패드가 다른 library보다 우선순위가 가장 높습니다."
},
{
"toc_id": "chapter02_heading02_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "세부 메뉴",
 "title2": "",
 "body": "세부 메뉴에는 다음 6가지 항목이 있습니다. Menu group: 사용자가 시스템 사용 중 CEditor의 기능을 좀더 편하게 이용하도록 아이콘으로 만들어 나열한 항목 Mouse mode: 마우스를 이용하여 수행할 작업의 종류를 선택하는 도구 Pad Select/Search: 패드를 검색하거나 선택할 때 사용하는 항목 Search ID/Trend: Component ID 검색/Trend 보기 옵션 Array/Panel Select: Array/Panel 별 선택 보기 Condition Tree: Pad Inspection Condition Tree 창 출력"
},
{
"toc_id": "chapter02_heading02_sub01_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "세부 메뉴",
 "title2": "Mouse Mode",
 "body": "Mouse Mode 메뉴는 메인 화면에서 마우스를 클릭하거나 드래그한 후 수행할 작업을 선택하는 도구입니다. 이 메뉴에는 다음 4가지 항목이 있습니다. Pad: 선택한 영역의 패드를 선택 Fiducial: 선택한 패드를 fiducial로 지정 Unused: 선택한 범위 내의 패드를 검색에서 제외 CAD Move: CAD 데이터만 이동 ※ 참고: Pad, Fiducial, Unused 항목의 경우, 마우스 우측 버튼을 클릭하면 해당 작업을 취소할 수 있습니다. 이 메뉴를 사용하려면 다음 순서대로 작업하십시오. 마우스 모드 우측에 있는 삼각형 모양 아이콘을 클릭하십시오. 나타난 리스트에서 수행할 작업에 맞는 항목을 선택하십시오. ※ 참고: 리스트에 나타난 각 항목에 대해서는 위의 설명을 참고하십시오."
},
{
"toc_id": "chapter02_heading02_sub02_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "세부 메뉴",
 "title2": "Condition Tree",
 "body": "이 메뉴는 각 검사 조건을 선택하여 해당 조건이 설정된 Pad를 빠르게 확인할 수 있는 기능입니다. Pad Inspection Condition Tree 창에서 검사 조건을 선택하면, 해당 조건이 설정된 Pad들을 검색하여 보여줍니다. 각 검사 조건마다 정해진 색으로 Pad를 표시하며, 여러 가지 조건이 설정된 Pad의 경우, 검정색으로 표시합니다. 항목 기능 Show Same Condition Pads 선택한 Pad와 동일한 검사 조건을 가진 Pad 표시 Draw Extend ROI 모든 Pad의 Extend ROI 영역 표시 Pad Inspection Condition Tree 확인하고자 하는 검사 조건을 선택하면, 해당 조건이 설정된 Pad가 정해진 색으로 표시 Pad Tolerance Pad Condition 창을 실행하여 검사 속성 재 설정 Pad Edit Inspect Condition 사용 방법은 다음과 같습니다. 1. Pad Inspection Condition Tree 의 검사 조건 목록 중, 확인하고자 하는 검사 조건을 선택하고 Search 버튼을 클릭하십시오. 해당 검사 조건이 설정된 패드들이 색깔로 표시됩니다. 반대로, PCB 뷰어에서 확인하고 싶은 Pad를 클릭하면 아래와 같이 해당 Pad의 속성값이 Tool Tip으로 표시됩니다. Tool Tip은 Pad가 없는 부분을 클릭하거나 Condition Tree 창을 닫으면 사라집니다. 선택한 Pad와 동일한 조건의 Pad를 확인하려면, 'Show Same Condition Pads' 항목을 선택한 후 PCB 뷰어에서 임의의 Pad를 클릭하십시오. 선택한 Pad와 동일한 검사 조건을 가진 Pad들이 자동으로 선택되어 표시됩니다. Draw Extend ROI 항목을 선택하면 개별 Extend ROI가 설정된 Pad들의 Extend ROI 영역을 파란색 사각형으로 표시합니다. PCB 뷰어 위에서 마우스를 한번 클릭 한 후 키보드의 'Z'를 누르면, Extend ROI 영역을 표시하거나 표시하지 않을 수 있습니다. ※ 참고: Extend ROI 영역이 설정되어 있는 Pad인 경우에만 Extend ROI 영역이 위와 같이 표시됩니다."
},
{
"toc_id": "chapter02_heading03_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "좌측 메뉴",
 "title2": "",
 "body": "CEditor의 좌측 메뉴는 선택된 패드의 정보를 표시하고 대상 패드의 검사 조건 등을 표시합니다. 선택한 패드의 검사 조건이나 ComponentID 등을 수정하는 기능도 제공합니다. 좌측 메뉴에는 다음 4가지 항목이 있습니다. 패드 정보 검사 조건 Group ComponentID"
},
{
"toc_id": "chapter02_heading03_sub01_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "좌측 메뉴",
 "title2": "패드 정보",
 "body": "메인 화면에서 선택한 패드의 정보를 표시하는 영역입니다. 항목 설명 ID 선택한 패드의 ID Type 선택한 패드의 모양 X, Y 위치 (X, Y Pos) 선택한 패드의 위치 좌표 X, Y 사이즈 (SizeX, Y) 선택한 패드의 사이즈 면적(Area) 선택한 패드에서 납이 도포되는 면적을 백분율로 나타낸 값 ※ 참고: 위 항목들 중 면적의 경우, 패드 모양이 사각형일 경우를 100%로 가정하고 원형은 78.54%로 설정하여 검사를 진행합니다."
},
{
"toc_id": "chapter02_heading03_sub02_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "좌측 메뉴",
 "title2": "검사 조건",
 "body": "메인 화면에서 선택한 패드의 검사 조건을 조회하고 수정할 수 있는 영역입니다. 이 영역에 있는 Edit 버튼을 클릭하면 해당 검사 조건을 변경할 수 있습니다. 항목 설명 체적(Volume) Volume 검사 수행 여부 E.W/E 과납 경고 및 불량 판정 기준값 I.W/E 미납 경고 및 불량 판정 기준값 편차(Offset) 위치 검사 수행 여부 X/Y W X/Y축 뒤틀림 경고 판정 기준값 X/Y E X/Y축 뒤틀림 경고에 대한 불량 판정 기준값 브릿지(Bridge) 브릿지 오류 검사 여부 및 불량 판정 기준값 형상(Shape) 형상 오류 검사 여부 및 기준값 Cop. 평탄도 오류 검사 여부 Dual 해당 패드를 듀얼 모드로 검색할 것인지 여부 S/L/U/W 높이 오류 검사 여부 및 불량 판정 기준값 S (Stencil Height) / L (Lower Height) / U (Upper Height) / W (Warning) 해당 패드를 일반 패드와 다른 각도로 찍을 것인지 여부 Head. R 해당 패드를 일반 패드와 다른 각도로 찍을 것인지 여부 편집(Edit) 위의 검사 조건들을 변경"
},
{
"toc_id": "chapter02_heading03_sub03_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "좌측 메뉴",
 "title2": "Group",
 "body": "특정 패드를 그룹으로 설정하여, 그룹별로 패드를 선택하거나 검사 결과를 표시할 수 있는 영역입니다. 이 영역에 있는 기능은 SPC Plus에서 그룹별 통계를 확인할 때 사용합니다. 항목 설명 Group 이 기능의 사용 여부 선택 추가(ADD) PCB에서 선택한 패드들을 그룹으로 설정 Import/Export 그룹을 부품명 단위로 내보내기/불러오기 삭제(Delete) 리스트에서 선택된 그룹 삭제 그룹 내보내기/불러오기 그룹에 속한 패드를 부품 명 단위로 저장하여, *.txt 파일로 내보내기/불러오기 할 수 있는 기능이 추가되었습니다. 내보내기한 그룹명이 *.txt 파일의 파일명이 되고, 해당 그룹에 속하는 패드들의 부품 명이 저장됩니다. *.txt 파일을 불러오면 파일명을 그룹명으로 하여, 파일에 저장된 부품명의 패드들을 그룹으로 생성할 수 있습니다. 제약 사항 OSAT Job은 지원하지 않습니다. 부품 명 단위로만 내보내기/불러오기 할 수 있습니다. 그룹은 최대 50개까지 생성할 수 있습니다. 불러온 파일에 50개 이상의 Component가 존재할 경우, 50개만 불러오기 됩니다. 그룹 내보내기 CEditor에서 JOB 파일을 불러온 후, 좌측 메뉴의 Group 패널 하단의 Import/Export 버튼을 클릭하십시오. Group Import/Export 창이 나타나면, Export 탭을 선택하십시오. Group 목록에 현재 사용중인 JOB 파일의 그룹들이 표시됩니다. 내보내고자 하는 그룹을 목록에서 선택하고, Export Selected Groups를 클릭하십시오. Group 목록의 모든 그룹을 내보내기 하려면, Export All Group를 클릭하십시오. 저장할 경로를 선택하고, 확인을 클릭하십시오. ※ 참고: 선택한 경로에 동일한 이름의 파일이 존재하는 경우, 현재 파일로 덮어씌울지 여부를 묻는 메시지가 팝업합니다. 예(Y)를 클릭하면, 현재 내보내기한 파일로 대체됩니다. 그룹 불러오기 Group Import/Export 창의 Import 탭을 선택하십시오. Select Folder를 클릭하고, 부품명 단위로 저장된 *.txt 파일이 있는 폴더를 선택하십시오. 선택한 폴더에 저장된 *.txt 파일이 왼쪽 목록에 표시됩니다. 생성하고자 하는 그룹을 목록에서 선택하고, Add Selected Groups를 클릭하십시오. 목록의 모든 파일을 불러와서 그룹을 생성하려면, Add All Group를 클릭하십시오. ※ 참고: 현재 JOB 파일에 동일한 그룹명이 존재할 경우, 기존 그룹은 삭제되고 불러온 *.txt 파일의 그룹으로 새로 생성됩니다."
},
{
"toc_id": "chapter02_heading03_sub04_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "좌측 메뉴",
 "title2": "Component ID",
 "body": "선택한 패드의 Component ID 정보를 표시/수정/편집/검색할 수 있는 메뉴입니다. 항목 설명 CAD 갱신 (CAD Refresh) CAD에서 분배한 Component ID 값을 다시 로드 수정(Modify) 선택한 패드의 Component ID를 수정 편집(Edit) 리스트에서 선택한 Component ID를 수정 검색(Find) 입력한 Component ID를 가진 패드를 검색"
},
{
"toc_id": "chapter02_heading03_sub05_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "좌측 메뉴",
 "title2": "상태 조회줄",
 "body": "이 메뉴는 현재 읽고 있는 파일의 정보 및 현재 CEditor가 수행하고 있는 작업 상태를 나타냅니다. 상태 조회줄은 CEditor 메인 화면 하단에 존재합니다. 항목 기능 Coordinate 선택한 패드에 대한 각종 정보 Auto Update JOB 파일을 로드할 때, Size Library 적용 여부 Selected Pads 현재 메인 화면에서 선택된 패드의 개수 Fiducial 현재 fiducial 개수/Fiducial로 지정 가능한 최대 개수 Total Pad 패드의 총 개수"
},
{
"toc_id": "chapter02_heading04_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 화면",
 "title2": "",
 "body": "CEditor의 메인 화면은 PAD 파일, CAD 파일 등을 로드하여 얻은 PCB 정보 그림을 표시하는 영역입니다. 메인 화면은 프로그램의 중앙에 위치합니다."
},
{
"toc_id": "chapter02_heading04_sub01_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 화면",
 "title2": "메인 화면에 소속된 메뉴",
 "body": "메인 화면의 그림에 커서를 놓고 마우스 오른쪽 버튼을 클릭하면 관련 메뉴가 나타납니다. 이러한 메뉴에 대한 상세 내용은 아래 그림과 표를 참고하십시오. 항목 기능 Actual View 현재 파일 내용이 화면 전체를 차지하도록 화면 비율 변경 Zoom In/Zoom Out 현재 그림을 한 단계 확대/축소 SelectZoom 현재 그림을 원하는 비율(2~8배)로 선택하여 화면 출력 Pads 세부 메뉴의 mouse mode에 있는 Pad와 같은 기능 Tolerance Setting Tolerance Setting 화면 출력 Pad Edit Edit Pad 화면 출력 Pad Inspection Condition Inspection Condition 화면 출력 Size Lib Menu Size Library 화면 출력 Pad Error Notification Block Component로 등록된 패드에서 불량이 발생했을 때 에러메시지 팝업 여부 설정 Register Pads by Component: 선택한 부품 내의 모든 패드가 특정 패드로 등록됨. Settings: 설정 화면 표시 ※ 참고: 위 항목 중 Pads에 대해서는 본 문서의 Mouse Mode를 참고하십시오. Pad Error Notification 설정 Option Description Component List Block Component로 등록할 부품을 검색, 등록, 삭제 - 상단 입력창에 부품명을 입력한 후 등록하면, 아래 리스트에 등록한 부품명 표시 ※ 존재하지 않는 부품명을 검색하거나 추가한 경우, “해당 부품명이 존재하지 않습니다.”라는 문구가 나타납니다. Error Message 등록한 패드에서 불량이 발생했을 때 에러메시지 팝업 여부 설정 - “특정 부품의 패드에 인쇄가 잘못되었습니다. 보드를 폐기해주세요.” 라는 문구가 기본 제공되며, 문구 수정 가능 - Revert to Default Message: 기본 문구로 변경 - Apply: 메시지 변경 적용 ※ Apply 버튼은 변경된 부분이 있는 경우에만 활성화됩니다. ※ 참고: Component List에서 부품 선택 후 마우스 오른쪽 버튼을 클릭해도 동일한 메뉴가 나타납니다."
},
{
"toc_id": "chapter02_heading04_sub02_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 화면",
 "title2": "Pads",
 "body": "이 기능은 세부 메뉴의 mouse mode에서도 사용할 수 있으나, 사용자의 편의를 위해 CEditor 메인 화면에서도 사용할 수 있게 만든 메뉴입니다. 항목 기능 Unselect All 현재 선택을 모두 취소 Select same pads 현재 선택한 패드와 동일한 형상의 패드를 모두 선택 Change Condition 현재 선택한 패드의 검사 조건을 변경 Merge Pads 현재 선택한 패드들을 병합"
},
{
"toc_id": "chapter02_heading04_sub03_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 화면",
 "title2": "Tolerance Setting",
 "body": "Tolerance Setting 항목을 선택하면 아래와 같이 SPI Inspection Condition 대화상자의 Tolerance Setting 탭이 나타납니다. Tolerance Setting 탭에서는 선택한 패드에 대한 각 검사 항목의 허용범위를 설정합니다. ※ 참고: 각 검사 항목 설정에 대한 자세한 설명은 검사 조건 메뉴를 참고하십시오."
},
{
"toc_id": "chapter02_heading04_sub04_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 화면",
 "title2": "Package Information",
 "body": "이 절에서는 Package Information 탭의 설정에 대해 설명합니다. 항목 기능 배열 번호(Array Number) 선택된 Pad가 속해있는 Array 번호 Panel Number 선택된 Pad가 속해있는 Panel 번호 Step Zoom Number 선택된 Pad가 속해있는 Step Zoom 번호 Cad Data Cad File에서 읽은 데이터를 확인/수정 Component Name Pad의 Component 이름 Edit Library Library 관리 Part Name Pad의 Part 이름 Pin Number Pad의 Pin 번호 Comp. Package 선택된 Pad가 속해있는 Comp. Package."
},
{
"toc_id": "chapter02_heading04_sub05_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 화면",
 "title2": "Pad Information",
 "body": "Pad Edit 항목을 선택하면 아래와 같이 Pad Information 탭이 나타납니다. Pad Information 탭에서는 선택한 패드의 속성을 설정할 수 있습니다. 항목 기능 Selected Pad 현재 선택된 Pad 표시 - Single Pad: 선택된 Pad가 한 개일 경우 - Multi Pads: 선택된 Pad가 여러 개일 경우 Shape Pad 모양 편집 (Rectangle/Circle/Polygon) Position Pad 위치 정보 표시 (Position 정보 편집 불가능) Size Pad 크기 편집 Area % Pad 면적비율 편집 Rotation Pad 기울기 편집 ※ 참고 - 선택된 Pad 들 중 Polygon Pad가 존재할 경우 Size, Area%, Rotation 정보는 수정할 수 없습니다. - Polygon Pad의 경우 Shape 정보는 변경할 수 있지만, 다시 Polygon Pad로 복원할 경우 Polygon 모양이 정상적으로 그려지지 않습니다."
},
{
"toc_id": "chapter02_heading04_sub06_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 화면",
 "title2": "Inspction Condition ",
 "body": "Inspection Condition 항목을 선택하면 아래와 같이 SPI Inspection Condition 대화상자의 Inspection Condition 탭이 나타납니다. Inspection Condition 탭에서는 선택한 패드의 상세한 검사 조건을 설정할 수 있습니다. 항목 기능 Inspection Object 검사 대상 Pad의 최적의 검사 조건 설정 Measure Range Pad 높이 측정 영역 설정 Noise Removal Noise 제거 관련 설정 Board Reflection Pad 표면 특성 관련 설정 Reference Plane Pad의 Base 관련 설정 Slope Compensation 기울기 보상 기능 활성화 Extended ROI Base 제외 영역 설정 - 제외 영역은 패드 위치부터 확장하여 픽셀단위로 입력 Quick Setting Inspection Condition창의Quick Setting은 Pad의 특성에 따라 미리 설정해 놓은 값들을 자동으로 입력하여 빠르게 패드 검사 속성을 설정할 수 있는 옵션입니다. Quick Setting 우측의 콤보박스를 클릭하여 해당하는 타입의 패드를 선택하십시오. 미리 저장해 놓은 검사 속성이 자동으로 설정됩니다. 각 항목을 선택했을 때 입력되는 설정 값들은 C:\\Kohyoung\\KY-3030\\QuickSetting.ini 파일에 저장됩니다. 설정 값을 변경하려면 'QuckSetting.ini' 파일의 내용을 수정하십시오. Inspection Object Inspection Object 패널에서는 검사대상 Pad의 유형, 재질 및 색상을 선택하여 최적의 검사조건을 설정합니다. 항목 기능 Object Type 검사 대상 선택 - Solder Paste Type: 일반적인 Solder에 대한 측정 및 검사 - Gold Tab Type: Gold Tap의 Pad 상의 이물검사 - Bond Land Type: Bond Land의 Pad 상의 이물검사 - Tape Type: Jig를 고정하기 위한 Tape 영역 - Local Fiducial Type: Local Fiducial로 사용되는 Pad - Pad Bad Mark Type: Pad Bad Mark로 사용되는 Pad - Epoxy: Epoxy Pad를 검사 - Mask Type: 업데이트 예정 Object Color Object Type이 Local Fiducial 또는 Pad Bad Mark일 경우 설정 가능 - None/Black/White/Red/Green/Blue 중 해당 색상 선택 ※ 참고 - 위에 존재하지 않는 Object Type들은 모두 Solder Type으로 변경되어 일반 Pad와 같이 처리됩니다. - Epoxy pad를 검사할 때 Epoxy height method측정 옵션이 ‘Max’로 되어 있으면 Height를 상위 0~5% 높이의 평균 높이로 측정하여 검사합니다. Measurement Measurement 패널에서는 검사대상 Pad 높이의 측정영역 및 측정방식을 설정합니다. 항목 기능 Object Type - Upper Limit (0~600): 3D 높이 측정의 상한 값 입력 - Lower Limit: 3D 높이 측정의 하한 값 자동 입력 - Higher Than Upper Limit: Pad 높이가 측정 상한 값보다 높을 경우 선택 Object Color - Height Threshold: 선택한 Threshold 보다 높은 부분을 Solder로 인식하는 방식 (Threshold: 5~1000) - Segmentation: Solder 검사에 RGB 조명을 사용하는 방법으로 추출 영역에서 체적, 면적, 높이를 계산하여 보다 실제 형상에 가까운 값을 추출하는 방식 ※ 참고: Upper Max 값을 입력하면, 그에 따라 Lower Max 값이 자동으로 계산되어 입력됩니다. - Measure Range 검사 속성 적용 예시 Noise Removal Noise Removal 패널에서는 노이즈 제거와 관련한 항목들을 설정합니다. 항목 기능 Gray Brightness - Upper Limit: 설정 값보다 큰 밝기의 픽셀은 노이즈로 처리 - Lower Limit: 설정 값보다 작은 밝기의 픽셀은 노이즈로 처리 Visible Threshold 설정 값보다 작은 Visibility 값의 픽셀은 노이즈로 처리"
},
{
"toc_id": "chapter02_heading04_sub07_KOR.html",
 "chapter_i": "2",
 "chapter": "화면 구조",
 "title": "메인 화면",
 "title2": "Board Reflection Characteristic",
 "body": "Board Reflection Characteristic 패널에서는 검사 대상 보드가 FPCB와 같이 반짝이거나 투명한 재질인 경우 난반사 문제 관련한 항목들을 설정합니다. 항목 기능 Shiny 검사 대상 보드의 표면이 밝게 빛나는 경우, Segmentation 적용 난반사 문제가 있는 영역을 포함하여 Base로 선택할 수 있음 Transparent 검사 대상 보드가 여러 단차로 이루어지는 투명 재질일 때 사용 각 영역별로 Segmentation을 적용 후 가장 높은 영역을 Base로 설정 Board Color 검사 대상 보드의 색상 설정 Pad 표면마다 색상이 다르거나 검정색일 경우, Board 색상 설정 ※ 참고: 이 설정은 Reference Plane 설정에서 Use Segmentation Info.를 선택했을 때만 적용됩니다. Reference Plane Reference Plane 패널에서는 측정 기준높이와 관련한 항목들을 설정합니다. 항목 기능 ROI Selection Pad의 Base로 사용할 ROI 영역 설정 - Unused: 일반적인 ROI 영역 - Largest: Multi-base 옵션. 상대적으로 큰 면적의 영역을 Base로 결정 - Long Axis: 한쪽 방향으로 긴 Pad 형태 (Ex. QFP Component) Special Geometry 노이즈를 제거 범위 설정 - Via Hole: ROI 내에 Via Hole에서 발생하는 노이즈 제거 - Jig: ROI 내에 PCB 고정을 위한 Jig가 포함되어 발생하는 노이즈 제거 Base Align Pad의 Base 검출 방법 설정 - Normal: 3D 조명만 사용하여 Base를 검출하는 방법 - Segmentation: RGB 조명을 사용하여 Base를 검출하는 방법 ※ 참고: Via Hole, Segmentation 기능 관련 고급 설정은 3D Inspector의 Vision Parameter 설정 창에서 변경할 수 있습니다. &lt;Via Hole 검사 속성 적용 예시&gt; &lt;Jig 검사 속성 적용 예시&gt; Slope Compensation Slope Compensation 패널에서는 기울기 보상과 관련한 항목들을 설정합니다. 항목 기능 Slope Compensation - Enable Slope 보상 기능 활성화 여부 &lt;Slope Compensation 검사 속성 적용 예시&gt; Extend ROI Extend ROI 패널에서는 Extend ROI 영역을 설정할 수 있습니다. 항목 기능 Extend ROI(0~50) Extend ROI 적용 Align by Long-Axis Direction Pad의 긴 방향 기준으로 Extend ROI가 설정됩니다."
},
{
"toc_id": "chapter03_KOR.html",
 "chapter_i": "3",
 "chapter": "CEditor 사용 절차",
 "title": "",
 "title2": "",
 "body": "이 장에서는 CEditor의 사용 절차를 소개합니다. 사용자의 편의를 위해 이 장에서 소개하는 순서에 따라 작업할 것을 권장합니다. CEditor의 실행 절차는 성격에 따라 다음과 같이 나뉩니다. 기본 실행 절차: 위 그림의 CAD 파일이 없는 경우에 해당 STEP 1~4 추가적인 절차: 위 그림의 CAD 파일이 있는 경우에 해당 STEP A-1~A-3 각 STEP별 상세 설명은 다음 페이지에서부터 진행합니다. ※ 참고: 추가적인 절차는 CEditor의 필수 절차는 아닙니다. 이는 3D Inspector에 의한 검사 통계를 상세히 보기 위해 Component ID를 추가하는 실행 절차입니다."
},
{
"toc_id": "chapter03_heading01_KOR.html",
 "chapter_i": "3",
 "chapter": "CEditor 사용 절차",
 "title": "기본 실행 절차",
 "title2": "",
 "body": "CEditor의 기본적인 실행 절차는 아래 그림과 같습니다. CEditor의 입력 파일은 ePM-SPI에서 생성한 PAD 파일(*.pad)이며, 출력 파일은 3D Inspector에 대한 입력 파일인 JOB 파일(*.mdb)입니다. ※ 참고: 이 절에서는 CAD 파일을 적용하지 않는 경우를 전제로 하여 절차를 설명합니다. 3D Inspector에 의한 검사 통계를 더 상세히 하기 위해 ComponentID를 추가하는 작업에 대해서는 추가적인 절차(CAD 파일 추가)를 참고하십시오."
},
{
"toc_id": "chapter03_heading01_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "CEditor 사용 절차",
 "title": "기본 실행 절차",
 "title2": "PAD 파일 로드 (STEP 1)",
 "body": "이 절에서는 CEditor에서 PAD 파일을 로드하는 방법에 대해 설명합니다. PAD 파일을 로드하려면 다음 순서대로 작업하십시오. CEditor를 실행하면 사용자 선택 대화상자가 나타납니다. 사용자의 권한에 해당하는 권한 아이콘을 선택한 후, Password에 암호를 입력하십시오. ※ 참고: Operator는 CEditor를 사용할 수 없습니다. OK 버튼을 클릭하십시오. CEditor의 메인 화면이 나타납니다. 메인 메뉴의 파일을 클릭하고 Load Pad File를 클릭하십시오. 작업할 PAD 파일을 선택한 후, OK 버튼을 클릭하십시오. PAD 파일을 로드하면, PCB 설정 대화상자가 나타납니다. 올바른 조건 정보를 입력한 후, Apply 버튼을 클릭하십시오. 그러면 사용자가 선택한 PAD 파일이 메인 화면에 나타납니다."
},
{
"toc_id": "chapter03_heading01_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "CEditor 사용 절차",
 "title": "기본 실행 절차",
 "title2": "Fiducial 지정(STEP 2)",
 "body": "이 절에서는 PCB를 검사할 때 사용할 fiducial을 지정하는 방법을 설명합니다. Fiducial을 지정하려면 다음 순서대로 작업하십시오. CEditor 세부 메뉴에 있는 mouse mode를 Fiducial로 선택하십시오. Fiducial로 설정할 패드를 왼쪽 마우스 버튼으로 클릭하여 지정하십시오. ※ 참고 - 일반 패드가 fiducial로 설정되면 패드 색깔이 노란색으로 변합니다. - 패드의 fiducial 설정을 해제하려면, 다시 한번 fiducial로 선택된 패드를 클릭하거나 마우스 모드를 Fiducial에서 Unused로 변경하십시오. 변경하는 방법에 대해서는 Mouse Mode를 참고하십시오."
},
{
"toc_id": "chapter03_heading01_sub03_KOR.html",
 "chapter_i": "3",
 "chapter": "CEditor 사용 절차",
 "title": "기본 실행 절차",
 "title2": "패드 별 검사 조건 입력(STEP 3)",
 "body": "이 절에서는 패드 별로 검사 조건을 입력하는 방법에 대해 설명합니다. 패드 별로 검사 조건을 입력하려면 다음 순서대로 작업하십시오. 검사 조건을 변경할 패드를 선택하십시오. 좌측 메뉴에 있는 편집 버튼을 클릭하십시오. SPI Inspection Condition 대화상자가 나타납니다. 원하는 검사 조건을 입력한 후 확인 버튼을 클릭하십시오. ※ 참고 - 각 검사 조건에 대한 자세한 설명은 검사 조건 메뉴를 참고하십시오. - Change Opt. 항목을 사용하면, 적용할 패드의 범위를 설정할 수 있습니다. Change Opt. 항목에 대한 자세한 설명은 Apply Pad를 참고하십시오."
},
{
"toc_id": "chapter03_heading01_sub04_KOR.html",
 "chapter_i": "3",
 "chapter": "CEditor 사용 절차",
 "title": "기본 실행 절차",
 "title2": "JOB 파일 저장(STEP 4)",
 "body": "JOB 파일을 저장하려면 다음 순서대로 작업하십시오. 메인 메뉴 중 파일을 클릭하십시오. JOB파일 저장하기를 클릭하십시오. JOB 파일을 저장할 경로를 선택한 후, 저장 버튼을 클릭하십시오."
},
{
"toc_id": "chapter03_heading02_KOR.html",
 "chapter_i": "3",
 "chapter": "CEditor 사용 절차",
 "title": "추가적인 절차(CAD 파일 추가)",
 "title2": "",
 "body": "기본 실행 절차에서 설명한 CEditor의 기본적인 실행 절차 이외에 CAD 파일을 추가할 경우의 작업에 대해 설명합니다. ※ 참고: 이 절차는 CEditor의 필수 실행 절차는 아닙니다. 다만, 3D Inspector에 의한 검사 통계를 보다 상세히 하기 위해 ComponentID를 추가하는 작업 중 한 단계입니다. CAD 파일을 추가하는 목적은 3D Inspector에 의한 검사 통계를 각 파트 별 또는 부품 별로 정확하게 정보를 수집하는 것입니다. PCB의 검사 대상에 ComponentID나 Pin CAD 정보를 추가하면 검사 통계 자료를 보다 세밀하게 수집할 수 있습니다. CAD 파일 추가 절차를 수행하려면 다음 순서대로 작업하십시오. 기본 실행 절차에서 설명한 STEP 1: PAD 파일 열기를 먼저 수행하십시오. 위 그림의 STEP 2 ~ STEP 5를 순차적으로 수행하십시오. 위 그림의 각 단계 별 상세 설명은 다음 페이지부터 진행하겠습니다. ※ 참고: 단, 위 그림의 STEP 1에 대한 설명은 기본 실행 절차에 있으므로 생략합니다."
},
{
"toc_id": "chapter03_heading02_sub01_KOR.html",
 "chapter_i": "3",
 "chapter": "CEditor 사용 절차",
 "title": "추가적인 절차(CAD 파일 추가)",
 "title2": "CAD나 Pin CAD 파일 로드",
 "body": "CAD나 PIN CAD 파일을 로드하려면 다음 순서대로 작업하십시오. PAD 파일 로드(STEP 1)를 참고하여, 유사한 방법으로 PAD 파일을 로드하십시오. PAD 파일의 그림이 메인 화면에 나타납니다. 메인 메뉴 중 파일을 클릭하십시오. 필요한 CAD 파일의 종류에 맞게 아래 그림에서 표시한 메뉴 중 하나를 선택하십시오. Component CAD일 경우: Load CAD - default 클릭 Pin CAD일 경우: Pin CAD 파일 불러오기 클릭 FABMASTER FATF일 경우: CAD File 가져오기 클릭 ※ 참고: FABMASTER FATF의 경우, Top 파일과 Bottom 파일이 구분되어 있습니다. 각 파일에 맞는 옵션으로 로드하십시오. Select Export File 대화상자가 나타납니다. 파일이 있는 경로를 선택한 후, 열기 버튼을 클릭하십시오. CAD 파일을 처음 로드할 경우, 먼저 CAD format을 정의해야 합니다. 메인 메뉴 중 도구를 클릭하고 CAD 형식 설정을 클릭하십시오. ※ 참고: CAD format을 정의할 필요가 없으면 이 순서를 무시하고 부품 중점 맞추기(Centroid)로 넘어가십시오. Define CAD Format 대화상자가 나타나면 Auto Import Value from CAD 버튼을 클릭하여 CAD 파일을 로드합니다. ※ 참고 - CAD 파일을 처음 로드할 경우, Define CAD Format 대화상자의 0번 행의 각 Column에서 마우스 오른쪽 클릭을 하면 각 Column에 삽입할 항목을 선택할 수 있습니다. - CAD 파일을 로드 시, 설정이 초기화됩니다. ※ 참고: Define CAD Format 대화 상자의 항목 중에서 ComponentID, X Position, Y Position, Rotation, Library Name은 필히 입력해야 합니다. Define CAD Format 대화상자의 작업을 마치면, 아래와 같이 CAD 파일에 ComponentID나 핀 번호가 부여되어 메인 화면에 나타납니다. ※ 참고 - CAD의 위치와 패드의 위치가 일치하지 않을 경우, mouse mode를 CAD Move로 선택하여 드래그하면 CAD 파일을 움직일 수 있습니다. 이 작업에 대해서는 부품 중점 맞추기(Centroid)를 참고하십시오. - Zoom 기능을 사용해야 하거나 ComponentID나 핀 번호가 메인 화면에 표시되지 않을 경우, 좌측 메뉴의 CAD Refresh(F5) 버튼을 클릭하거나 키보드에서 &lt;F5&gt; 키를 누르십시오. 현재의 JOB 파일을 저장하십시오."
},
{
"toc_id": "chapter03_heading02_sub02_KOR.html",
 "chapter_i": "3",
 "chapter": "CEditor 사용 절차",
 "title": "추가적인 절차(CAD 파일 추가)",
 "title2": "부품 중점 맞추기(Centroid)",
 "body": "이 절차는 현재 작업 중인 패드들의 위치와 CAD 파일 추가 후 표시된 ComponentID 혹은 핀 번호의 위치가 서로 다를 경우, 사용자가 수동으로 상호 위치를 맞추는 작업입니다. 이 작업을 하려면 다음 순서대로 작업하십시오. 먼저 위치가 어긋나 있는 패드가 있는지, 있다면 어느 패드인지 확인하십시오. ※ 참고: 모든 패드와 ComponentID 혹은 핀 번호가 잘 일치하는지 여부를 정확히 확인하려면, 다음 순서로 작업하십시오. 1. 세부 메뉴에서 Search ID의 Not Find 버튼을 클릭하십시오. 2. 그러면 위치가 어긋난 패드의 ComponentID 혹은 핀 번호의 옆에 ‘Not match’라고 나타납니다. 3. 어긋난 패드와 ComponentID 혹은 핀 번호를 일치시킨 후, 세부 메뉴에서 Search ID의 All 버튼을 클릭하십시오. 메인 메뉴 중 도구를 클릭한 후, Mirror나 Rotation을 클릭하십시오. Mouse mode를 CAD move로 설정하십시오. ※ 참고: Mouse mode를 CAD move로 설정하는 방법에 대해서는 Mouse Mode를 참고하십시오."
},
{
"toc_id": "chapter03_heading02_sub03_KOR.html",
 "chapter_i": "3",
 "chapter": "CEditor 사용 절차",
 "title": "추가적인 절차(CAD 파일 추가)",
 "title2": "PCB 복제(Array Board 적용일 경우)",
 "body": "Array board에 CAD 추가 단계를 적용할 때, PCB 전체가 아니라 하나의 array에 대해서만 ComponentID가 설정되어 있는 경우가 많습니다. 이러한 경우, 하나의 array에 적용된 ComponentID를 다른 array에 복제하여 사용해야 합니다. ※ 참고: Single Board일 경우에는 이 작업을 수행하지 마십시오. Array Board의 PCB를 복제하려면 다음 순서대로 작업하십시오. 먼저, 부품 중점 맞추기 작업이 완료되었는지 확인하십시오. 적용할 Array에서, 같은 위치에 있는 패드를 1개 선택하십시오. 각 패드를 클릭한 후, 좌측 메뉴에서 해당 패드의 X 좌표와 Y 좌표를 확인하십시오. ①번 Array와의 좌표 값의 차이를 비교해 보십시오. 예를 들어, 좌표 값을 비교한 결과 X축은 90.0, Y축은 50.0의 차이가 있다는 것을 발견했다고 가정해보겠습니다. 좌측 메뉴의 하단에 있는 ComponentID의 Set 버튼을 클릭하십시오. PCB의 array에 맞게 열과 행 값을 Cols와 Rows에 각각 입력하십시오. 예시로 주어진 그림의 경우, PCB가 열 2개, 행 2개인 array로 이루어졌으므로 Cols와 Rows에 2를 입력합니다. ※ 참고: Pitch는 array간의 간격입니다. 순서 4에서 확인한 값인 90과 50을 Cols Pitch와 Rows Pitch에 입력하고 Set CAD 안의 Set 버튼을 클릭하십시오. ※ 참고: 순서 5의 그림에서, Cols Pitch와 Rows Pitch의 값은 다음과 같이 계산하여 대입하십시오. - Cols Pitch = ②번 array의 기준점의 X 위치 – ①번 array의 X 위치 - Rows Pitch = ③번 array의 기준점의 Y 위치 – ①번 array의 Y위치 해당 정보를 입력한 후, Set 버튼을 클릭하십시오. 그러면 ①번 array에 있던 ComponentID 혹은 핀 번호의 값이 ②, ③, ④번 array에 복제됩니다. 좌측 메뉴의 CAD Refresh(F5) 버튼을 클릭하거나 키보드에서 &lt;F5&gt; 키를 누르십시오. 그러면 모든 ComponentID 혹은 핀 번호가 화면에 나타납니다. 세부 메뉴의 search ID에 있는 All 버튼을 클릭하십시오. ②번~ ④번 array에 있는 CAD와 패드 정보에 대해 ComponentID와 핀 번호를 부여하여 등록합니다 Rotated or Flipped Arrays 특정 Array의 각도가 다른 경우가 있습니다. 이 경우에는 다음과 같은 과정을 수행합니다. 첫 번째 패널의 CAD 위치를 설정하십시오. 세부 메뉴의 Search ID에 있는 All 버튼을 클릭하십시오. 그러면 모든 ComponentID 혹은 핀 번호가 화면에 나타납니다. CAD를 다음 패널로 Move하거나 Mirroring한 후, 세부 메뉴의 Search ID에 있는 All 버튼을 클릭하십시오. 모든 패널의 각도가 일치할 때까지 위 1~3번 순서를 반복하여 실행하십시오. JOB 파일을 저장하십시오."
},
{
"toc_id": "chapter03_heading02_sub04_KOR.html",
 "chapter_i": "3",
 "chapter": "CEditor 사용 절차",
 "title": "추가적인 절차(CAD 파일 추가)",
 "title2": "JOB 파일 저장",
 "body": "JOB 파일을 저장하십시오. ※ 참고: 이 작업을 수행하는 방법은 JOB 파일 저장(STEP 4)을 참고하십시오.."
},
{
"toc_id": "chapter04_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "",
 "title2": "",
 "body": "이 장에서는 CEditor의 각 기능 별 세부적인 항목 설정에 대해 설명합니다. 이 장에서 상세히 다룰 기능은 다음과 같습니다. 검사 조건 메뉴 패드 추가/수정 ComponentID 등록/수정 FOV 최적화"
},
{
"toc_id": "chapter04_heading01_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "검사 조건 메뉴",
 "title2": "",
 "body": "이 절에서는 PCB의 검사 조건을 설정하는 방법에 대해 설명합니다. 3D Inspector의 PCB 검사에 대한 정확성을 높이기 위해, 3D Inspector의 PCB 검사 항목 임계치를 CEditor에서 설정할 수 있습니다. 이 임계치는 SPC Plus 통계 자료 정보로 사용됩니다. 3D Inspector의 PCB 검사 항목 임계치 설정은 Change PAD Inspection Condition 대화상자에서 수행합니다. Change PAD Inspection Condition 대화상자의 항목은 다음과 같습니다. 부피 틀어짐 브릿지 높이 Shape Area Coplanarity Other Setting Apply Pad Apply Change Option Change PAD Inspection Condition 대화상자를 열려면 다음 순서대로 작업하십시오. 검사 조건을 변경할 패드를 선택하십시오. 좌측 메뉴에 있는 편집 버튼을 클릭하십시오."
},
{
"toc_id": "chapter04_heading01_sub01_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "검사 조건 메뉴",
 "title2": "부피",
 "body": "이 절에서는 PCB 검사 조건 중, 부피 설정에 대해 설명합니다. 항목 기능 부피 부피 검사 여부를 설정 Unit 표기에 사용할 단위의 설정 과납 일정치를 초과하는 납이 검출되면 과납으로 처리 미납 일정치 미만의 납이 검출되면 미납으로 처리 Warning 비율 부피 결과값 중 경고로 처리할 %값 설정"
},
{
"toc_id": "chapter04_heading01_sub02_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "검사 조건 메뉴",
 "title2": "틀어짐",
 "body": "이 절에서는 PCB 검사 조건 중, 틀어짐 설정에 대해 설명합니다. 항목 기능 틀어짐 틀어짐(위치) 검사 여부를 설정 Unit 표기에 사용할 단위를 설정 X/Y 위치 오류 설정값을 초과하는 X/Y축 오차가 있으면, 틀어짐 불량 판정 내림 비율경고 위치 결과값 중 경고로 처리할 %값 설정"
},
{
"toc_id": "chapter04_heading01_sub03_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "검사 조건 메뉴",
 "title2": "브릿지",
 "body": "이 절에서는 PCB 검사 조건 중, 브릿지 설정에 대해 설명합니다. 항목 기능 브릿지 브릿지 검사 여부 설정 4Way 4 방향 브릿지 조건 설정 높이 어느 정도를 초과하는 높이의 브릿지를 error로 표기할지 설정 Distance 브릿지 검사 시, 설정된 거리 이내의 패드들과만 비교 4방향 브릿지 검사 4 방향 브릿지 검사는, 한 패드에서 브릿지가 발생할 수 있는 4 방향 중, 임의로 특정 방향에 브릿지가 발생하더라도 에러로 처리하지 않도록 설정하는 옵션입니다. 이 옵션을 사용하려면 다음 순서대로 진행하십시오. Tolerance Setting 탭의 브릿지 항목 설정에서 4Way 버튼을 클릭하면 아래와 같이 4방향 브릿지 설정 옵션이 나타납니다. Left (L), Right(R), Top(T), Bottom(B)의 네 방항 중에, 브릿지가 발생하더라도 오류로 처리하지 않으려면 해당 방향의 체크를 해제하십시오. &lt;Example&gt; 4 방향에 모두 브릿지 검사를 했을 때, 패드(ID:133) Top 방향에 브릿지 에러가 발생하였음을 확인할 수 있습니다. Tolerance Setting 탭에서 4Way 버튼을 누르고 Top(T) 방향의 체크박스를 선택 해제하고 저장하십시오. JOB 파일을 다시 불러오고, 검사를 진행하십시오. 해당 패드(ID:133)의 검사결과를 확인해 보면, 아래와 같이 Top쪽에 브릿지 에러가 발생하였지만, \x22Good\x22으로 처리되었음을 확인할 수 있습니다."
},
{
"toc_id": "chapter04_heading01_sub04_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "검사 조건 메뉴",
 "title2": "높이",
 "body": "이 절에서는 PCB 검사 조건 중, 높이 설정에 대해 설명합니다. 항목 기능 높이 높이 검사 여부 설정 Mil Mille Inch 단위로 입력 스텐실 스텐실의 높이 입력 높이이상 일정 높이를 초과하는 경우 Error로 표기 높이이하 일정 높이 미만인 하는 경우 Error로 표기 경고 높이 결과값 중 경고로 처리할 %값 설정"
},
{
"toc_id": "chapter04_heading01_sub05_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "검사 조건 메뉴",
 "title2": "Shape",
 "body": "이 절에서는 PCB 검사 조건 중, 형상 설정에 대해 설명합니다. 항목 기능 Shape 형상 이상 검사 여부를 설정 Balance 밸런스 수치가 이 항목값보다 크면 형상 오류로 처리"
},
{
"toc_id": "chapter04_heading01_sub06_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "검사 조건 메뉴",
 "title2": "Area",
 "body": "이 절에서는 PCB 검사 조건 중, 영역 설정에 대해 설명합니다. 항목 기능 Area 영역 이상 검사 여부를 설정 최소 납이 도포된 영역이 이 항목값보다 작으면 오류로 처리 최대 납이 도포된 영역이 이 항목값보다 크면 오류로 처리"
},
{
"toc_id": "chapter04_heading01_sub07_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "검사 조건 메뉴",
 "title2": "Coplanarity",
 "body": "이 절에서는 Tolerance Setting 항목 중, 평탄도 설정에 대해 설명합니다. 항목 기능 Coplanarity 평탄도 이상 검사 여부를 설정 Top Area 패드를 위에서 봤을 때, 설정한 %만큼의 면적을 제외하고 높이와 위치의 값을 설정 Volume 각 패드의 평균 부피값으로부터 설정한 값만큼 벗어나면 오류로 처리 Offset 각 패드를 위에서 봤을 때, 설정한 값만큼 센터로부터 벗어나면 오류로 처리"
},
{
"toc_id": "chapter04_heading01_sub08_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "검사 조건 메뉴",
 "title2": "Apply Pad",
 "body": "이 절에서는 검사 조건을 적용할 Pad의 범위 설정에 대해 설명합니다. 항목 기능 1 Pad 선택한 하나의 패드에만 적용 선택된 Pads 선택한 복수의 패드에 설정 적용 모든 Pads 해당 PCB의 모든 패드에 설정 적용 동일 Pads 해당 PCB 내에서 선택한 패드와 같은 모양을 한 모든 패드에 설정 적용"
},
{
"toc_id": "chapter04_heading01_sub09_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "검사 조건 메뉴",
 "title2": "Apply Change Option",
 "body": "이 절에서는 변경한 검사 조건의 적용 범위 설정에 대해 설명합니다. 항목 기능 Tolerance Setting 선택한 Pad 범위에 적용할 검사 조건 선택"
},
{
"toc_id": "chapter04_heading02_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "패드 추가/수정",
 "title2": "",
 "body": "이 장에서는 패드를 추가하거나 수정하는 방법에 대해 설명합니다. CEditor는 작업하기 위한 PAD 파일이나 JOB 파일을 로드하여, 사용자가 원하는 특정 패드를 추가하거나 수정할 수 있게 합니다. Fiducial이 찍히지 않은 채 나온 잘못된 PAD 파일 (*.pad)이 입력되어 향후 PCB 검사에 영향을 줄 수 있거나, PCB 변경으로 인한 부분적 수정이 요구될 때, CEditor를 통해 보다 간편하게 작업할 수 있습니다."
},
{
"toc_id": "chapter04_heading02_sub01_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "패드 추가/수정",
 "title2": "패드 추가",
 "body": "기존 PCB에 패드를 추가하려면, 다름 순서대로 작업하십시오. 메인 메뉴에서 도구를 선택한 후 Pad 추가를 클릭하십시오. 항목 기능 형상 패드의 모양 설정 X/Y 위치 패드의 위치 설정 패드의 중심점 위치 너비/길이 패드의 넓이나 길이를 설정 면적(%) 납이 도포되는 패드 영역 설정 Angle 경사진 패드의 기울기 설정 Continuous Add 패드를 연속적으로 추가 - Number: 같은 모양의 패드를 설정한 개수만큼 추가 - Pitch: Number에서 설정한 개수의 패드를 설정한 Pitch 단위로 생성 - Direction: Number와 Pitch에서 설정한 값으로 패드를 생성할 방향 선택 조건에 맞게 정보를 입력한 후, OK 버튼을 클릭하십시오. 새 패드가 추가되어 화면에 나타납니다."
},
{
"toc_id": "chapter04_heading02_sub02_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "패드 추가/수정",
 "title2": "패드 수정",
 "body": "기존 PCB의 패드를 수정하려면, 다름 순서대로 작업하십시오. 변경하고자 하는 패드를 왼쪽 마우스로 클릭하십시오. 그러면 해당 패드를 빨간색 사각형으로 활성화할 수 있습니다. 메인 메뉴에서 도구를 선택한 후, Pad 편집 을 클릭하십시오. 조건에 맞게 정보를 수정한 후 확인 버튼을 클릭하십시오. 수정한 정보가 적용된 패드가 화면에 나타납니다. ※ 참고: 다수의 패드를 수정하려면 Inspection Condition 메뉴 우측에 있는 Apply Pad 항목에서 적용할 패드의 범위를 설정하십시오."
},
{
"toc_id": "chapter04_heading03_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "ComponentID 수정",
 "title2": "",
 "body": "CAD 파일 추가 작업을 하다가, ComponentID를 수정해야 할 수도 있습니다. 패드와 ComponentID가 제대로 매칭되지 않는 경우가 많은데, 주요 원인은 다음 2가지입니다. Case 1: ComponentID 범위 내에 원하는 PCB가 존재하지 않음 Case 2: ComponentID 범위 내에 원하는 PCB 외에 다른 PCB가 존재 위 두 원인에 대한 사례들 및 사례 별 대처 방안은 Case 에서 설명하겠습니다. ComponentID를 수정하려면 세부 메뉴 중 Search ID의 Not Find 버튼을 클릭하십시오. 그러면 ComponentID 목록이 메인 화면에 있는 해당 ComponentID에 표시되고, 매칭이 어긋난 ComponentID의 옆에 Not Match라고 나타납니다.* ※ 참고: Pin CAD의 경우에는, ComponentID의 범위가 아닌 각각의 패드를 가리키므로 이 기능을 사용하지 않습니다."
},
{
"toc_id": "chapter04_heading03_sub01_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "ComponentID 수정",
 "title2": "Case 1",
 "body": "정해진 영역(파란색 상자) 안에 들어가야 할 패드(하얀색 상자)가 들어가지 않으면, 패드와 ComponentID가 제대로 매칭되지 않습니다. 이 경우, 해당 ComponentID 영역을 재설정하여 문제를 해결합니다. 다음 순서대로 작업하십시오. Mouse mode를 Pad로 변경한 후, 원하는 패드의 주위 영역을 다시 설정하십시오. 좌측 메뉴의 ComponentID 항목 안에 있는 Modify 버튼을 클릭하십시오. 그러면 Set Component 대화상자가 나타납니다. Set Component 대화상자에서 Get Block Size 버튼을 클릭하여, 해당 ComponentID 영역을 재설정하십시오. 해당 ComponentID 영역에 포함될 패드의 개수를 No of Pad에 입력한 후, OK 버튼을 클릭하십시오."
},
{
"toc_id": "chapter04_heading03_sub02_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "ComponentID 수정",
 "title2": "Case 2",
 "body": "정해진 ComponentID 범위 내에 정해진 2개의 패드 외에 다른 패드가 포함되면, 패드와 ComponentID가 제대로 매칭되지 않습니다. 이와 같은 경우, Case 1과 같이 해당 ComponentID 영역의 재설정을 통해 문제를 해결합니다. 다음 순서대로 작업하십시오. Mouse mode를 Pad로 변경한 후, 원하는 패드의 주위 영역을 다시 설정하십시오. 좌측 메뉴의 ComponentID 항목 안에 있는 Modify 버튼을 클릭하십시오. 그러면 Set Component 대화상자가 나타납니다. Set Component 대화상자에서 Get Block Size 버튼을 클릭하여, 해당 ComponentID 영역을 재설정하십시오. 해당 ComponentID 영역에 포함될 패드의 개수를 No of Pad에 입력한 후, OK 버튼을 클릭하십시오. ※ 참고: 위 순서로 작업하였으나 해결하지 못했으면 Case 3 또는 Case 4를 참고하십시오."
},
{
"toc_id": "chapter04_heading03_sub03_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "ComponentID 수정",
 "title2": "Case 3",
 "body": "Case 2와 같은 상황이지만, Case 2와 달리 해당 ComponentID 영역을 다시 설정하는 것으로는 해결할 수 없는 경우도 발생합니다. 이 경우 다음 순서대로 작업하십시오. Mouse mode를 Unused로 변경한 후, 없애야 하는 패드를 클릭하십시오. 그러면 해당 패드를 검사 영역에서 제외할 수 있습니다. Mouse mode를 Pad로 변경하십시오. Case 2와 마찬가지로 영역을 지정한 후, Modify 버튼을 클릭하십시오. Mouse mode를 Unused로 변경한 후, 해당 패드에 오른쪽 클릭을 하거나 드래그하여 범위 안에 넣으십시오. 그러면, 패드는 다시 검사 범위에 속하게 됩니다. 좌측 메뉴의 ComponentID 항목 안에 있는 Modify 버튼을 클릭하십시오. 그러면 Set Component 대화상자가 나타납니다. Set Component 대화상자에서 Get Block Size 버튼을 클릭하여, 해당 ComponentID 영역을 재설정하십시오. 해당 ComponentID 영역에 포함될 패드의 개수를 No of Pad에 입력한 후, OK 버튼을 클릭하십시오. ※ 참고: 위 순서로 작업하였으나, 해결하지 못했으면 Case 4를 참고하십시오."
},
{
"toc_id": "chapter04_heading03_sub04_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "ComponentID 수정",
 "title2": "Case 4",
 "body": "아래의 경우는 Case 3과 같은 상황이지만 크기가 커진 경우입니다. Case 3과 마찬가지로, 지워야 할 원을 지운 후 ComponentID를 등록하십시오. 그러면 패드와 ComponentID가 정상적으로 매칭됩니다."
},
{
"toc_id": "chapter04_heading04_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "FOV 최적화",
 "title2": "",
 "body": "CEditor는 3D Inspector로 PCB 검사를 실제로 시작하기 전에 시뮬레이션을 하여 PCB 검사할 때 카메라의 이동 경로를 예상하는 기능을 제공합니다. 이 기능이 FOV 최적화 기능이며, 카메라의 이동 경로를 미리 살피고, 더 정확하게 PCB를 검사하기 위한 기능입니다. FOV 최적화를 실행하려면, 다음 순서대로 작업하십시오. 메인 메뉴에서 도구를 선택한 후 FOV 최적화를 클릭하십시오. 그러면 FOV 최적화 대화상자가 나타납니다. 항목 기능 Camera 해상도 검사 기기에 장착된 카메라의 화소 수 선택 Step Zoom Step zoom 옵션을 사용하는 경우, Step zoom의 단계 수 입력 (패드의 Step Zoom은 좌측 메뉴에 있는 Edit 항목에서 설정할 수 있음) Camera Margin 카메라의 Margin값 설정 Z Scale Factor 검사 기기의 Z Scale Factor 값 수정 해당 설정을 모두 마친 후, Show 버튼을 클릭하십시오. 그러면 아래와 같은 창이 나타납니다. 어느 점을 기준으로 하여 검사를 시작할지 설정한 후, 설정 버튼을 클릭하십시오. 그러면 FOV 최적화를 시작할 수 있습니다. 각각의 노란 상자는 하나의 FOV 입니다. 이 옵션으로 검사를 하면, 해당 PCB는 25번의 촬영으로 모든 패드에 대한 검사를 마칠 수 있습니다. Margin값이나 기타 Optimize option값을 변경하면 좀더 빠른 검사가 가능합니다. ※ 참고: 이 기능은 단순히 이동 경로를 시뮬레이션하여 예상하는 기능입니다. 검사 장비에서는 카메라 상태와 기타 옵션에 따라 예상 경로와 다르게 작업할 수도 있습니다. 실제로 검사를 진행할 때, FOV 최적화를 하려면 3D Inspector에서 검사 설정을 변경해야 합니다."
},
{
"toc_id": "chapter04_heading05_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Size Library",
 "title2": "",
 "body": "Size Library 기능은 각 패드의 크기와 형상에 따라 검사 임계치를 자동으로 부여하여, 최적화가 가능하게 합니다."
},
{
"toc_id": "chapter04_heading05_sub01_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Size Library",
 "title2": "Size Library 화면",
 "body": "# 항목 설명 ① Size library 데이터 파일 Size Library 데이터 파일의 전체 경로 표시 LOAD/Save/SaveAs: Size Library 데이터 파일을 로드/저장 ② Size library 설정 Size Library 이름, 형상 및 상세 조건 정보 입력 ③ Size library 목록 Size Library 정보 표시 (우선 순위. Size Library 이름, 티칭 정보) ④ Offset(%) 조건 오프셋 검사 조건 버튼 ADD: Size Library 추가 Edit: Inspection Condition 창 활성화 Delete: 현재 선택된 Size Library 삭제 Clear All: 등록된 Size Library 파일 내용을 모두 삭제 Priority: 우선순위 변경 Check Latest Update Time: Size Library의 업데이트 시간 확인할 지 여부 Update Job: 변경된 Spec.을 ini 파일에 저장하고, 현재 로드된 JOB 파일에 Size Library Spec.을 설정"
},
{
"toc_id": "chapter04_heading05_sub02_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Size Library",
 "title2": "Size Library 생성",
 "body": "Size Library를 사용하려면 먼저 library를 생성하여야 합니다. 다음 순서대로 작업하십시오. 메인 메뉴 중 도구를 선택한 후, Size Library Editor를 클릭하십시오. 생성하려는 조건에 맞게 상단의 항목들을 입력한 후, 추가 버튼을 클릭하십시오. 그러면 Library 그룹이 1개 추가됩니다. 해당 그룹을 클릭한 후, 편집 버튼을 클릭하십시오. 그러면 해당 library 그룹에 설정할 검사 임계치가 나타납니다. 해당 그룹에 맞은 검사 임계치를 입력한 후 확인버튼을 클릭하십시오. 위와 같은 방식으로 추가할 Library 요소를 추가하면 아래와 같이 하나의 library가 완성됩니다. Library 생성이 끝나면 상단의 Save 버튼을 클릭하여 작업을 저장하십시오."
},
{
"toc_id": "chapter04_heading05_sub03_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Size Library",
 "title2": "Size Library의 적용",
 "body": "이 절에서는 Size Library를 JOB 파일에 적용하는 방법을 설명합니다. 해당 library를 JOB 파일에 적용하는 것에는 다음 2가지 방법이 있습니다. 자동 적용 수동 적용 자동 적용은 JOB 파일을 로드하면 나타나는 PCB 설정 창에서 Auto update Size Lib.항목을 선택하면 됩니다. 수동 적용은 Size Library 대화상자에서 JOB 업데이트 버튼을 클릭하면 됩니다. CEditor 좌측 메뉴에 있는 Group 목록에서 해당 그룹을 선택하면 적용된 사항을 확인할 수 있습니다."
},
{
"toc_id": "chapter04_heading05_sub04_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Size Library",
 "title2": "Size Library 수정",
 "body": "이 절에서는 Size Library를 수정하는 방법에 대해 설명합니다. Size Library를 수정하는 방법으로는 다음의 2가지 방법이 있습니다. 그룹으로 선택한 조건에 대한 수정 해당 그룹의 검사 한계치에 대한 수정 그룹으로 선택되는 조건에 대한 수정은 다음의 순서대로 작업하십시오. Size Library 창에서 수정을 원하는 그룹을 클릭하면 해당 항목에 대한 선택 조건이 아래와 같이 나타납니다. 그룹 이름을 수정하지 않고, Shape과 SizeSpec을 수정한 후 추가 버튼을 클릭하면, 그룹 선택 조건이 수정됩니다. 해당 그룹의 검사 한계치에 대한 수정은 다음의 순서대로 작업하십시오. Size Library 창에서 수정을 원하는 그룹을 클릭 한 후, 편집 버튼을 클릭하십시오. Change Part Library Condition 대화상자가 뜨면, 해당 창의 내용을 수정한 후 확인 버튼을 클릭하십시오. ※ 참고 - 위와 같이 수정 후, 저장을 하지 않으면 해당 변경 사항은 저장되지 않습니다. - 위와 같이 수정 후, &lt;Job 업데이트&gt; 버튼을 클릭하거나 새로운 JOB 파일을 로드하여 Auto Update를 실행하지 않으면 JOB 파일에 변경 사항이 적용되지 않습니다."
},
{
"toc_id": "chapter04_heading05_sub05_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Size Library",
 "title2": "Size Library에 Manually Assign 기능",
 "body": "Size Library를 적용하고 싶지 않은 Pad들의 경우, Size Library와 JOB 파일에서 미리 그룹을 설정하여, JOB 파일을 변경해도 해당 그룹에 속한 Pad들은 Size Library가 적용되지 않도록 하는 기능입니다. 사용 방법 CEditor &gt; Tools &gt; Size Library에서, Manually Assign 옵션을 선택한 후 Size Library를 적용시키지 않을 Library를 생성하십시오. CEditor 에서 Manually Assign 옵션을 적용한 Library 이름과 동일한 이름으로 Group을 생성하십시오. 생성한 그룹에 해당하는 Pad들은 JOB 변경 시에도 Size Library가 자동으로 적용되지 않습니다."
},
{
"toc_id": "chapter04_heading06_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Library Manager",
 "title2": "",
 "body": "이 장에서는 Library Manager의 하위기능인 Condition Library와 SPIGUI 프로그램의 연동을 위한 설정방법에 대해 설명합니다."
},
{
"toc_id": "chapter04_heading06_sub01_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Library Manager",
 "title2": "Condition Library 설정",
 "body": "KYConfig &gt; Code Input에서 ‘6701’을 입력하십시오. 하기 설정창에서 LM 기능 중 사용할 기능을 선택합니다. 항목 기능 Use Library manager LM 전체의 사용 여부 설정 LM user login LM 사용자 로그인 기능 사용 여부 설정 LM Save/Load job file LM 잡파일 관리 기능 사용 여부 설정 LM Policy control LM 검사 속성 관리 기능 사용 여부 설정 LM Real time monitoring LM 실시간 장비 상태 관리 기능 사용 여부 설정 LM Common scale factor LM Save/load job file의 하위 기능으로 고정 Scale factor값을 사용할 지 설정 LM SPC SPC에서도 LM 관련 기능 사용 여부 설정 ※ 참고 - 위의 창에서 LM Policy control 을 선택하면, Policy Manager 기능을 사용할 수 있습니다. Policy Manager 에 대한 자세한 설명은 다음 장에서 기술합니다. - LM SPC 기능은 특정 사이트에서 사용가능 합니다."
},
{
"toc_id": "chapter04_heading06_sub02_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Library Manager",
 "title2": "Condition Library",
 "body": "이 장에서는 Condition Library의 실행과 화면 구성에 대해 설명합니다. Condition Library 실행 CEditor를 실행한 후, JOB 파일을 불러오십시오. Tools &gt; Condition Library를 선택하십시오. ※ 참고: Condition Library 메뉴는 LM 서버에서 해당장비에 Condition Library 수정 권한이 부여된 사용자에 한해 사용할 수 있습니다. Condition Library 화면 구성 항목 기능 Download from Server KSMART 서버에서 라이브러리 내려받기 Upload to Server KSMART LM에 해당 라이브러리를 업데이트 Save to Local File KSMART에서 라이브러리를 다운로드 받아 로컬에 저장 Add New Multi Vendor 새로운 그룹 추가 Delete Multi Vendor 기존 그룹 삭제 탭 선택 Package, Part, Size 탭 선택 Job file 로드된 JOB 파일에 있는 패키지 중 라이브러리에 등록된 패키지와등록되지 않은 패키지를 표시 Property Lib. Name: 라이브러리 이름 설정 Stencil Height: 스텐실 두께 설정 Comment: 비고 및 설명 입력 Condition Library 등록된 Package/Part/Soze 입력 값을 관리 Apply to level 검사 조건을 적용할 레벨 선택 신규 Condition 추가 방법 Job file 목록에서 'Not registered' 항목을 1개 선택하십시오. Register package(Part 탭에서는 Register part 버튼) 버튼을 클릭하십시오. Condition Library에 해당 패키지가 등록됩니다. Registered item을 선택한 후 Add 버튼을 클릭하면, 신규 조건이 추가됩니다. Edit 버튼을 클릭하여, 등록된 조건의 Stencil height와 Comment를 편집할 수 있습니다. Condition 수정 Condition Library에서 수정할 항목을 선택하십시오. Con. edit 버튼을 클릭하십시오. 수정할 검사 Spec을 입력하십시오. Condition 정보가 변경되면 Cor 항목에 ‘O’가 표시됩니다."
},
{
"toc_id": "chapter04_heading07_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Pad/Local Fiducial Grouping 기능",
 "title2": "",
 "body": "Pad Grouping은 바닥면에 높이 차이가 있는 PCB를 검사 할 때, 각 바닥 높이 별로 적절한 바닥면(Base Plane) 보상이 진행될 수 있도록 돕는 기능입니다. 이 기능을 이용하면, 각 바닥면 별로 패드 및 로컬 피두셜을 최대 5개까지 그룹핑하여 PCB 바닥 높이를 측정하며, 같은 그룹으로 설정된 패드 별로 바닥면을 보상하여 정상적으로 체적 및 높이 측정을 할 수 있습니다."
},
{
"toc_id": "chapter04_heading07_sub01_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Pad/Local Fiducial Grouping 기능",
 "title2": "설정 방법",
 "body": "KYConfig &gt; ETC Setup &gt; Use Pad Grouping 옵션을 선택하십시오. KYConfig에서 Group by Panel 항목과 FOV Size &gt; Panel Size 항목을 선택하십시오. Vision Parameter &gt; Condition 2 &gt; Set L-Fid as Base Plane 항목을 ‘True’로 설정하십시오."
},
{
"toc_id": "chapter04_heading07_sub02_KOR.html",
 "chapter_i": "4",
 "chapter": "CEditor 고급 기능 설정",
 "title": "Pad/Local Fiducial Grouping 기능",
 "title2": "사용 방법",
 "body": "CEditor에서 패드를 선택한 후, Tolerance Setting &gt; Other Setting에서, Pad Group ID를 설정하십시오. ※ 참고: Group ID는 최대 5개까지 설정할 수 있으며, Group 설정이 되어있지 않은 경우, “No Group” 으로 표시됩니다. Group ID는 CEditor에서만 설정할 수 있으며, SPIGUI에서는 Group ID를 확인은 할 수 있으나 설정은 할 수 없습니다. SPIGUI에서 Pad Grouping ID를 설정한 JOB 파일을 불러온 후, 자동검사를 진행합니다. ※ 참고: 만약 Pad Grouping ID는 설정되었지만, 해당 Pad Group에 Pad Local Fiducial이 존재하지 않을 경우, 아래와 같은 경고 메시지가 나타납니다. 아래와 같이, 바닥면의 높이 차가 존재하는 부분의 패드들에 대해서도 Volume 및 Height가 정상적으로 측정되었음을 확인할 수 있습니다. 기능 적용 전, Cavity 영역 내 패드들의 Volume 및 Height 측정 결과 기능 적용 후, Cavity 영역 내 패드들의 Volume 및 Height 측정 결과"
},
{
"toc_id": "chapter05_KOR.html",
 "chapter_i": "5",
 "chapter": "부록",
 "title": "",
 "title2": "",
 "body": "이 장에서는 CEditor의 용어에 대한 정의와 연관 정보를 제공합니다. ComponentID PCB에 올라가게 될 칩 및 저항의 ID CSV 파일 쉼표(,) 단위로 개체를 구분하는 파일 형식. Microsoft®사의 Excel®에서 지원하는 파일 형식 Fiducial 검사 기기 등이 PCB의 위치를 확인하기 위해 사용되는 기점 FOV (Field of View) 카메라가 한번에 찍는 범위 FOV Optimize FOV가 이동하는 경로를 최적화하는 기능 Gerber 파일 RS-274D 또는 RS-274X 규정에 따른 형식을 가지고 있는 파일 포맷 Maintenance (User) 사용자 등급의 하나로, 장비 관리자에게 추천하는 등급 Operator (User) 사용자 등급의 하나로, 검사를 진행하는 오퍼레이터에게 추천하는 등급 PAD 파일 Gerber Format에서 나타낸 패드들의 외양 정보를 SPI 검사를 하기에 적절하게 변형한 파일로, ㈜고영테크놀러지에서 사용하는 중간 단계의 파일 형식. 형식은 *.pad Step Zoom 카메라의 배율을 바꿀 수 있는 추가 옵션 중 한 가지 Supervisor (User) 사용자 등급의 하나로, 최종 관리자에게 추천하는 등급 JOB 파일(*.mdb) 패드의 모양 외에도 SPI검사에 필요한 정보를 담고 있는 포맷. 형식은 *.mdb"
},
{
"toc_id": "Info.html",
 "chapter_i": "6",
 "chapter": "문서 정보",
 "title": "",
 "title2": "",
 "body": "User Guide CEditor Rev5.0 Copyright © 2022 Koh Young Technology Inc. All Rights Reserved."
},
{
"toc_id": "chapter00_heading01_KOR.html",
 "chapter_i": "6",
 "chapter": "문서 정보",
 "title": "저작권 및 면책조항",
 "title2": "",
 "body": "이 매뉴얼은 ㈜고영테크놀러지의 서면 승인 없이는 전체 또는 일부를 복사, 복제, 번역 또는 그 어떠한 전자매체나 기계가 읽을 수 있는 형태로 출판될 수 없습니다. 이 매뉴얼은 ㈜고영테크놀러지의 통제 하에 있지 않는 기타 업체로의 웹사이트 링크를 포함하고 있을 수도 있으며, ㈜고영테크놀러지는 링크된 그 어떠한 사이트에 대해서도 책임을 지지 않습니다. 또한, 출처를 미처 밝히지 못한 인용 자료들의 저작권은 원작자에게 있음을 밝힙니다. 혹시라도 있을 수 있는 오류나 누락에 대해 ㈜고영테크놀러지는 일체의 책임을 지지 않습니다. 제품의 버전이나 실행되는 형태에 따라 사진이 다를 수도 있습니다. 사양이나 사진은 매뉴얼 제작 시점의 최신 자료에 기초하고 있으나, 예고 없이 변경될 수도 있습니다."
},
{
"toc_id": "chapter00_heading02_KOR.html",
 "chapter_i": "6",
 "chapter": "문서 정보",
 "title": "개정 이력",
 "title2": "",
 "body": "개정 번호 날짜 설명 1.0 2008-11-28 Created 2.0 2010-08-30 CEditor Ver. 1.1.343 3.0 2014-03-11 CEditor Ver. 1.1.430 (Job Ver. 2.0) 3.1 2015-04-24 CEditor Ver. 1.1.439 (Job Ver. 2.0) 4.0 2016-12-02 CEditor Ver. 1.1.0.577 (Job Ver. 2.0) 4.1 2017-05-15 CEditor Ver. 1.1.0.610 (Job Ver. 2.0) 5.0 2022-10-01 Updated ﻿ ﻿ ﻿"
},
{
"toc_id": "chapter00_heading03_KOR.html",
 "chapter_i": "6",
 "chapter": "문서 정보",
 "title": "공유 범위",
 "title2": "",
 "body": "Customer Distributor KY Confidential O ﻿ ﻿"
},
{
"toc_id": "chapter00_heading04_KOR.html",
 "chapter_i": "6",
 "chapter": "문서 정보",
 "title": "용어/약어",
 "title2": "",
 "body": "용어/약어 설명 N/A ﻿ ﻿ ﻿"
}
]