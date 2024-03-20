#include 'extendables/extendables.jsx'
// #include "json2.jsx"
// #include "GetURLs.jsx"

var http = require('http');
var ui = require('ui');
// var docs = app.documents;

// if (docs.length == 0) {
// 	alert("인디자인 파일을 열은 후 실행하세요.");
// 	exit();
// }

// if (app.selection.length == 0 ) {
// 	alert("선택된 문장 또는 단어가 없습니다.");
// 	exit();
// }

if( !http.has_internet_access() ) {
	// HTTPError is provided by the http module
	throw new HTTPError("No internet access.");
}

var myText = "뒤질라고";
var uriText = encodeURI(myText);
// https://m.search.naver.com/p/csearch/ocontent/spellchecker.nhn?_callback=window.__jindo2_callback._spellingCheck=0&q=, 
// var url = "https://m.search.naver.com/p/csearch/ocontent/spellchecker.nhn?_callback=window.__jindo2_callback._spellingCheck=0&q=" + myText;
var url = "http://speller.cs.pusan.ac.kr/results";
var gotourl = encodeURI(url);
// var parseHTML = ParseURL(url);
// $.writeln(parseHTML.data);
$.writeln(gotourl);
var text1 = 'text1';
var response = http.post(url, myText, text1);

// if( response.status != 200 ) {
// 	throw new HTTPError( "연결이 안됩니다." );
// }
var result = response.body;

$.writeln(result);