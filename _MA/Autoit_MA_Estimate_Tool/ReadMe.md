# MA Estimate Tool

무선 팀 청구서 자동 제작 툴, [노션 페이지](https://carnation-credit-f12.notion.site/MA-Estimate-Tool-de7dd5faed714810822ce67d7cad6b6d)

## 폴더구조

* __dist_ : 배포 파일 저장
* _functions_
    * _getStamp_ : python을 이용해 pdf의 주석을 파싱하는 라이브러리, 레포지토리 http://10.10.10.222:3000/gitserver/getStamp.git
    * __db2xml.au3_ : resource/DB.xlsx 파일을 xml로 변환하는 라이브러리, autoit editor로 단독 실행해야함
    * __duplicatePages.au3_ : 중복 페이지를 단일 페이지 문자열로 변환하는 라이브러리 예, 1, 2, 2 -> 1, 2(2)
    * __getRegion.au3_ : 파일명을 통해 출향지 정보를 가져오는 라이브러리, 하드코딩함
    * __getRow.au3_ : resource/db.xml 파일을 통해서 청구서에 입력할 row 값을 가져오는 라이브러리
    * __importprice.au3_ : 2022_template.xlsx 파일에 숨겨진 시트를 통해서 단가를 불러오는 라이브러리
    * __mergeStat.au3_ : 여러 개의 청구서를 모아 통계를 만드는 라이브러리
* _resource_
    * _DB.xlsx_, _db.xml_ : 청구 스탬프 이름 및 언어별 청구서 입력 row 값을 정희한 파일
    * _sec.txt_ : 삼성 사업부 담당자 명단
* _template_
    * _2022_template.xlsx_ : 청구서 서식 파일
    * _statistics-template.xlsx_ : 통계 현황 서식 파일

## 컴파일 및 배포 방법
1. Autoit - SciTe Editor에서 main-ui.au3 파일을 연뒤 Ctrl + F7을 누르세요.
2. MA-Estimate-tool.exe 파일명으로 설정한 다음 하단의 Compile Script 버튼을 클릭하세요.
3. 새로운 exe 파일이 생성되면 필수 파일들만 압축하여 다음의 서버 경로에 업로드합니다.
(워크서버) /tcs/_Source/MA/Estimate-Tool
4. 버전별, 날짜별로 폴더를 생성해 파일을 업로드한 다음 워크플랜에 공지합니다.