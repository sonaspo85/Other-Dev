# tmx2xml-transform

* 트라도스에서 tmx 파일을 변환하여 해당 툴을 이용해 tmx 파일을 json 파일로 변환한 다음 ftp에 업로드
* TMX Search 사이트에 tmx 파일을 json 파일로 변환하기 위한 툴 [노션 페이지](https://www.notion.so/AST-TMX-Search-b7fef072fd614eb5b51dff4b618132fe)
* 무선 팀 TM 전용 : sdltm 파일을 dita에 최적화된 TM 파일로 변환

## 폴더 구조
* __dist_ : 배포할 파일을 저장하는 폴더
* _json_ : tmx -> json 파일을 저장하는 폴더
* _lib_ : xslt를 위한 saxon 라이브러리
* _temp_ : 변환 중 임시 파일을 생성하는 폴더
* _xslt_ : 변환 논리 xslt 파일을 저장하는 폴더

## 컴파일 및 배포
1. Autoit - SciTe Editor에서 tmx2xml-transform.au3 파일을 연뒤 Ctrl + F7을 누르세요.
2. tmx2xml-transform.exe 파일명으로 설정한 다음 하단의 Compile Script 버튼을 클릭하세요.
3. 새로운 exe 파일이 생성되면 필수 파일들만 압축하여 다음의 서버 경로에 업로드합니다. (워크서버) /tcs/_Source/common/tmx2xml-transform
4. 날짜별로 폴더를 생성해 파일을 업로드한 다음 워크플랜에 공지합니다.