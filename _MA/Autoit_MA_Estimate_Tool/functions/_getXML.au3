#include <File.au3>
#include <Array.au3>
#include <FileConstants.au3>
#include <String.au3>
#include <StringConstants.au3>

Global $ParentDir = StringLeft(@scriptDir,StringInStr(@scriptDir,"\",0,-1)-1)
Global $db = $ParentDir & "\resource\db.xml"

Global $dbXML = ObjCreate('Microsoft.XMLDOM')
$dbXML.Load($db)
_getAttr($dbXML, "W-planning", "basic")


Func _getAttr($dbXML, $stName, $type)
	Local $stLists = $dbXML.selectNodes('//stamp')
	Local $ij
	
	For $ij in $stLists
		If $ij.getAttribute('name') = $stName Then
			ConsoleWrite($ij.getAttribute('hName') & @CRLF)
			ConsoleWrite($ij.getAttribute($type) & @CRLF)
		EndIf
	Next
EndFunc