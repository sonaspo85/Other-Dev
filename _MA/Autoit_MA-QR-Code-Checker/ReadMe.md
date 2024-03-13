# MA QR Code Checker

무선 팀 QSG 매뉴얼 내의 QR 코드를 파싱해 언어에 따라 제대로된 링크로 이동하는지, 해당 링크가 존재하는지 확인하는 툴, [노션 페이지](https://carnation-credit-f12.notion.site/MA-QR-Code-to-URL-Validator-9efd2ff8676b4eda88ff756dd5c3e127)

## 폴더 및 파일 구조
* __dist_ : 배포 파일을 저장하는 폴더
* bin : 바코드를 파싱할 외부 프로그램, [참조](http://how-to.inliteresearch.com/barcode-reader-cli-examples/)
* _capter_ : 이동한 링크의 페이지를 캡쳐하여 저장하는 폴더
* _functions_
    * _capturescreen.js_ : puppeteer 모듈을 이용해 링크 페이지를 캡쳐하는 js 라이브러리
    * _capturescreen-chi.js_ : 중국어에서만 작동하는 화면 캡쳐 js 라이브러리
    * _decodeQR.js_ : QR 코드를 읽어들이는 js 라이브러리
    * _languages.xml_ : 언어 정보가 담긴 xml 파일
    * _qrcodes.json_ : PDF에 담긴 QR 코드 등에 대한 정보를 저정하는 파일
    * _request-url.js_ : QR 코드의 링크로 이동해 유효한지 확인하는 js 라이브러리
    * _urls.txt_ : url 링크 정보를 저장하는 txt 파일
* _logs.log_ : 로그를 기록하는 파일
* _main.au3_ : 메인 UI 라이브러리

## 컴파일 및 배포
1. Autoit - SciTe Editor에서 main.au3 파일을 연뒤 Ctrl + F7을 누르세요.
2. QRCodeURLValidator.exe 파일명으로 설정한 다음 하단의 Compile Script 버튼을 클릭하세요.
3. 새로운 exe 파일을 생성하면 필수 파일들만 압축하여 다음의 서버 경로에 업로드합니다. (워크서버) /tcs/_Source/MA/QRCodeURLValidator
4. 날짜별로 폴더를 생성해 파일을 업로드한 다음 워크플랜에 공지합니다.