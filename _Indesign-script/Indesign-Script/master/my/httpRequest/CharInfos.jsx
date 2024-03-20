/***********************************************************************/
/*                                                                     */
/*      CharInfos :: Displays Unicode details on selected character    */
/*                   THIS SCRIPT REQUIRES THE 'EXTENDABLES' FRAMEWORK  */
/*                                                                     */
/*      [Ver: 1.0]  [Author: Marc Autret]          [Modif: 11/10/10]   */
/*      [Lang: EN]  [Req: InDesign CS3/CS4/CS5]    [Creat: 11/10/10]   */
/*                                                                     */
/*      Installation:                                                  */
/*                                                                     */
/*      1) Download Extendables: http://extendables.org/               */
/*         and unzip the package into:                                 */
/*         Scripts/Scripts Panel/extendables/                          */
/*                                                                     */
/*      2) Place the current file into Scripts/Scripts Panel/          */
/*                                                                     */
/*      2) Run InDesign, open a document, and select a character       */
/*                                                                     */
/*      3) Exec the script from your scripts panel:                    */
/*           Window > Automation > Scripts   [CS3/CS4]                 */
/*           Window > Utilities > Scripts    [CS5]                     */
/*         + double-click on the script file name                      */
/*                                                                     */
/*      Bugs & Feedback: marc{at}indiscripts{dot}com                   */
/*                       www.indiscripts.com                           */
/*                                                                     */
/*      Extendables-related::                                          */
/*                       http://github.com/stdbrouw/Extendables/       */
/*                       Copyright (c) 2010 Stijn Debrouwere           */
/*                                                                     */
/***********************************************************************/


// Don't forget to update your path
// to extendables.jsx :
#include 'extendables/extendables.jsx'

// Gonna use Extendables' http module:
var http = require('http');

// Gonna use Extendables' ui module (scriptUI stuff)
var ui = require('ui');

var parseUnicodeHTMLTable = function(/*str*/ htmlTable)
//================================================
// Retrieves <td> datas from a valid XML <table> whose
// each item has the following basic structure:
//   <tr>
//     <td>Property</td>
//     <td>Value</td>
//   </tr>
// Note: <td> may contain <a> and/or <br/> children
// 
// htmlTable: String
// ret: key=>value's object
//================================================
{
	// Emulates the join function for XMLList
	var xmlJoin = function(/*XML*/xml, /*str*/joiner)
		{
		var i, a = [];
		for( i in xml ) a.push(xml[i].text());
		return a.join(joiner||', ');
		};

	var xInfos = XML(htmlTable).tr.td,
		iMax = xInfos.length()-2,
		i, t, prop, xValue, ret = {};

	// Let's loop through the xInfos XMLList with step=2
	for( i=0 ; i <= iMax ; i+=2 )
		{
		prop = xInfos[i].text();
		xValue = xInfos[1+i];
		switch( (t=xValue.a).length() )
			{
			case 0 : // no <a> elem
				t = xValue.text();
				break;
			case 1 : // one <a> elem
				t = t.text();
				break;
			default : // multiple <a> elems
				t = xmlJoin(t, ', ');
				break;
			}
		ret[prop] = t;
		}
	return ret;
};

var CHAR_INFOS_URL = 'http://www.fileformat.info/info/unicode/char/{}/index.htm';
var getUnicodeCharInfos = function(/*str*/ charStr)
//================================================
// Returns Unicode informations about the supplied character
// Use: http module
// 
// charStr: String
// ret: Object in the form {entry: string, infos: key=>value's object}
//================================================
{
	// Keep the first character
	charStr = charStr[0];
	
	// Converts charStr into 4-digits codepoint ('UUUU'):
	var charCode = charStr.charCodeAt(0).toString(16).toUpperCase();
	while( 4 > charCode.length ) charCode = '0' + charCode;

	// Here we use the String#format() helper:
	var url = CHAR_INFOS_URL.format(charCode);

	// ...then http#get()
	var response = http.get(url);
	if( response.status != 200 )
		{
		throw new HTTPError( "Unable to get {}.".format(url) );
		}
	
	// All is fine: response.body contains the whole HTML contents
	
	// Note: We can't directly use XML(response.body) because
	//       the retrieved HTML code is not XML-compliant!
	//       So let's pre-parse the HTML by ourselves:
	var infos = response.body.
		replace(/\s+/g,' ').
		split(/<table class="list">/ig);

	if( 3 > infos.length )
		{
		throw new Error( "Unable to parse the Web data.");
		}

	return {
		entry: 'U+{} ({})'.format(charCode, charStr),
		// Note: infos[2] seems to be XML-compliant
		infos: parseUnicodeHTMLTable('<table>' + infos[2])
		};
};

var displayObjectInfos = function(/*obj*/ objInfos)
//================================================
// Displays a nice infos dialog box
// Use: ui module
//
// objInfos: {entry:str, infos:obj}
// ret: void
//================================================
{
	var dlg = new ui.Dialog(" Unicode Character Infos 1.0");
	
	//----- UIShortcuts#panel hack
	// Reason: pan = dlg.panel('pInfos',objInfos.entry)
	//         does not yet properly work...
	var pan = dlg.add_container('pInfos', 'panel');
	pan.el().text = objInfos.entry;
	pan.el().margins = 20;
	//------
	
	// Create a 2-column listbox through the list() shortcut
	var list = pan.list('lbInfos', ["Property", "Value"]);

	// Use Extendables' object#keys
	var infoKeys = objInfos.infos.keys();
	
	// Feed the listbox
	var k;
	while( k=infoKeys.shift() )
		list.add_item(k, [k,objInfos.infos[k]]);
	
	dlg.button('bOk','OK');
	
	// Go!
	dlg.window.show();
};

var main = function()
{
	var t;
	
	// We call the generic 'is' method provided by the framework:
	if( !app.is('indesign') )
		{
		// Extendables's EnvironmentError:
		throw new EnvironmentError( "This script only works in InDesign." );
		}

	if( !(t=app.selection).length ||
		!('appliedFont' in (t=t[0])) ||
		!(t=(t.contents)) )
		{
		alert( "Please select a character." );
		return;
		}

	if( typeof t == 'number' )
		{
		alert( "The selected character belongs to InDesign SpecialCharacters." )
		return;
		}

	if( !http.has_internet_access() )
		{
		// HTTPError is provided by the http module
		throw new HTTPError("No internet access.");
		}
	
	if( t = getUnicodeCharInfos(t) )
		{
		displayObjectInfos(t);
		}
};

main();