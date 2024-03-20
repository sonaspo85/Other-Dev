var myDoc = app.activeDocument;

// 인디자인 찾기/변경 인터페이스 비우기
app.findTextPreferences = NothingEnum.nothing;
app.changeTextPreferences = NothingEnum.nothing;

// 문서내에서 "미디어"라는 문자열을 검색 하기
app.findTextPreferences.findWhat = "미디어";

// 검색할때 옵셥 설정 하기
app.findChangeTextOptions.caseSensitive = false;
app.findChangeTextOptions.includeFootnotes = false;
app.findChangeTextOptions.includeHiddenLayers = false;
app.findChangeTextOptions.includeLockedLayersForFind = false;
app.findChangeTextOptions.includeLockedStoriesForFind = false;
app.findChangeTextOptions.includeMasterPages = false;
app.findChangeTextOptions.wholeWord = false;

// 문서내에서 찾은 목록들을 변수에 저장
var myFoundItems = myDoc.findText();

alert("found: " + myFoundItems.length + "개수 입니다.");

//------------------------------------------
// 찾은 문자열을 다른 문자열로 변경하기
//------------------------------------------
app.changeTextPreferences.changeTo = "aaaaaaaaa";
myDoc.changeText();

// 인디자인 찾기/변경 인터페이스 비우기
app.findTextPreferences = NothingEnum.nothing;
app.changeTextPreferences = NothingEnum.nothing;