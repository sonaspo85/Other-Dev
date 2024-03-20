#include 'extendables/extendables.jsx'
 
// Tell Extendables we gonna use
// the 'http' and the 'ui' modules:
var http = require('http');
var ui = require('ui');
 
function parseHTML(/*str*/ htmlBody)
{
    // Our HTML parser
}
 
function getUnicodeCharInfos(/*str*/ charStr)
{
    // based on charStr Unicode value:
    var url = "http://www.fileformat.info/info/unicode/char/";
 
    // Sends the HTTP request to the server:
    var response = http.get(url);
 
    // Calls the parser
    var infos = parseHTML(response.body);
 
    return infos;
}
 
function displayInfos(...)
{
    // Uses the ui module to
    // create a nice ScriptUI dialog box
}
 
function main()
{
    car = /*getSelectedCharacter*/
 
    infos = getUnicodeCharInfos(car);
 
    displayInfos(infos);
}
 
main();