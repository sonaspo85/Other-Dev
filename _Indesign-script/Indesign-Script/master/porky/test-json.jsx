//@include bin/porky.jsx;

// JSON remote access
settings.dataSource.type = "JSON";
settings.dataSource.name = "https://m.search.naver.com/p/csearch/ocontent/util/SpellerProxy?color_blindness=0&q=%EB%92%A4%EC%A7%88%EB%9D%BC%EA%B3%A0";


// specify path in dot notation here or leave "" to request the entire object
var myXMLResult = connectToDataSource("");

alert( JSON.parse(myXMLResult) );

alert( JSON.stringify(myXMLResult) );