# MA Image Apps

무선 팀의 일러스트 이미지 번역 xml Export, Import 기능 스크립트, [워크플랜](https://wp2.astkorea.net/task/doc/#view/202201280211230dfad)

## 파일 설명

* _MA-illust-ExportXML.jsx_ : 선택한 폴더의 일러스트 파일에서 텍스트를 추출해 xml 파일로 생성
* _MA-illust-ImportXML.jsx_ : 선택한 폴더의 일러스트 파일과 같은 파일명의 xml 파일을 불러와 번역된 텍스트를 일러스트에 입력하는 스크립트
* _ImageApps_MA_Settings.xlsm_ : settings.xml 파일을 생성, ImportXML 실행 시 언어별 설정 값을 불러와 적용

## 문제점

참고 : https://wp2.astkorea.net/task/doc/#view/202206280531540c312 댓글 참조

스크립트 처음 실행 시 폰트 설정 값이 제대로 적용되지 않는 문제 발생, 일러스트레이터의 버그로 짐작되며, 최초 일러스트레이터 실행한 다음 일러스트 파일을 열고 닫은 후 스크립트를 실행할 것