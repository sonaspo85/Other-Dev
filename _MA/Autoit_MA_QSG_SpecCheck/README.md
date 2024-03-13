# MA_QSG_SpecCheck

## 폴더 구조

* lib : 7zip 압축 파일 라이브러리, xslt 변환을 위한 saxon 파일
* output : 리포트 엑셀 파일을 저정하는 경로
* resource
    * langlists.txt - 사용하는 언어 현황, 해당 언어 파일에 포함하지 않는 언어가 있을 경우 검증 진행을 멈추는데 사용
    * spec2xml-data.xlsm - QSG 매뉴얼에서 검증할 모든 언어 데이터, xsls\languages.xml 파일을 생성하는데 사용
    * template - 리포트 엑셀 파일 기본 서식 파일
* xsls : idml -> xml 변환 논리 xslt
* xslt-backup : 3.0 버전 이전에 사용한 xslt 파일, 삭제해도 무관

## 파일 관련 사항

* au3 파일을 autoit 관련 파일입니다.
* reference.vbs 파일은 \resource\spec2xml-data.xlsm 파일의 VBA 코드를 저장한 파일입니다.  
    1. vbs 코드는 엑셀에서 개발도구 > Visual Basic 클릭 
    2. 왼쪽 프로젝트 창에서 모듈 > Main 더블 클릭  

## 컴파일 및 배포 방법

<!-- 1. Autoit - SciTe Editor에서 SpecChecker-4.2.0.au3 파일을 연뒤 Ctrl + F7을 누르세요.
2. x86, x64 파이명에 버전을 변경한 다음 하단의 Compile Script 버튼을 클릭하세요.
3. 새로운 exe 파일이 생성되면 필수 파일들만 압축하여 다음의 서버 경로에 업로드합니다.  
    (워크서버) /tcs/_Source/MA/Spec-Checker
4. 버전별, 날짜별로 폴더를 생성해 파일을 업로드한 다음 워크플랜에 공지합니다.
김경란 팀장이 버전 확인 수정해달라고 요청하면 다음의 경로에 파일을 수정해 업로드하세요.
생활가전 html 서버 : 10.10.11.9 (id:ha | pw:ast141#) /TCS/specChecker-ver.html -->
1. compile.exe 를 실행해 컴파일 및 압축을 진행하세요.
2. 다음 경로에 버전별 폴더를 생성해 압축파일을 업로드하세요.
    (워크서버) /tcs/_Source/MA/Spec-Checker
3. 지난 게시글을 참고하여 워크플랜에 배포 게시물을 작성하세요.
    (워크플랜) [https://wp2.astkorea.net/task/doc/#view/2021022507124407c33]
4. H사 테스트 후 이상이 없어, 서버의 버전확인 데이터를 업데이트해야하는 경우
    ftp_up.exe를 실행하세요.

## git sever commit 방법

1. 작업 폴더에서 우클릭 후 Git Commit -> "master"...를 누르세요.
2. 메시지 작성 후 Commit 버튼을 누르세요.
3. Commit이 완료되면 Push 버튼을 눌러 파일을 전송하세요.