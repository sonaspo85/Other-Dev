// IdExtenso wants to run in INDD.
// ---
//#target 'indesign'
// Path to IdExtenso entry point.
// ---
#include '../$$.jsxinc'
// Web module.
// ---
#include '../etc/$$.Web.jsxlib'
#include '../core/$$.JSON.jsxlib'
#include '../etc/Web/$$.HttpSecure.jsxinc'
#include '../etc/Web/$$.HttpSocket.jsxinc'
// Load the framework.
// ---
$$.load(-1);

const url = "https://m.search.naver.com/p/csearch/ocontent/util/SpellerProxy?color_blindness=0&q=how";
//const url = "http://date.jsontest.com";
var o = $$.Web.get(url, 'https');
//get_S_b_y_b_y_Õ(/*str*/uri,/*0|1=0*/wantText,/*uint=120*/timeOut,/*0|1=0*/VOLATILE,/*uint=10*/R301,  µ,$$,tg,ret,hSec,code,errKind)
//var o = $$.JSON(url);
$.writeln(o.toSource());