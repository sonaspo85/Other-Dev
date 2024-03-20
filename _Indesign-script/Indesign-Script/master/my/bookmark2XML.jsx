var doc = app.activeDocument;
var docPath = doc.filePath;
var root = new XML("<root/>");
var BMs = new XML("<stories/>");
root.appendChild(BMs);

var story = doc.stories[0];
var paras = story.paragraphs.everyItem().getElements();

for (var i=0,l=paras.length; i<l; i++) {
	var para = paras[i];
	var paraStyle = para.appliedParagraphStyle.name;
	var titlex = para.contents.replace('\r',"");
	var hash = GetHashCode(titlex);

	try {
		if (para.appliedParagraphStyle.name.indexOf("Chapter") != -1) {
			var Chapter = <chapter title={titlex} id={hash} style={paraStyle}></chapter>;
			BMs.appendChild(Chapter);
		}
		if (para.appliedParagraphStyle.name.indexOf("Heading1") != -1) {
			var h2counter=0;
			var h3counter=0;
			var h4counter=0;
			var Heading1 = <heading1 id={hash} title={titlex} style={paraStyle}></heading1>;
			if (typeof(Chapter) != 'undefined' && Chapter != null) {
				//Exist!!
				Chapter.appendChild(Heading1);
			} else {
				BMs.appendChild(Heading1);
			}
		}
		if (para.appliedParagraphStyle.name.indexOf("Heading2") != -1) {
			var Heading2 = <heading2 title={titlex} id={hash} style={paraStyle} order={"#"+h2counter}></heading2>;
			Heading1.appendChild(Heading2);
			h2counter++;
		}
		if (para.appliedParagraphStyle.name.indexOf("Heading3") != -1) {
			// $.writeln (titlex);
			// $.writeln (root.toXMLString());
			var h2number = h2counter-1;
			if (Heading1.contains(Heading2)) {
				// $.writeln ("heading2 있다.");
				var Heading3 = <heading3 title={titlex} id={hash} style={paraStyle} order={"#"+h2number+"#"+h3counter}></heading3>;
				Heading2.appendChild(Heading3);
				h3counter++;
				// exit();
			} else {
				// $.writeln ("heading2 없다.");
				var Heading3 = <heading3 title={titlex} id={hash} style={paraStyle} order={"#"+h2counter+"#"+h3counter}></heading3>;
				Heading1.appendChild(Heading3);
				h3counter++;
				// exit();
			}
			
		}
		if (para.appliedParagraphStyle.name.indexOf("Heading4") != -1) {
			var Heading4 = <heading4 title={titlex} id={hash} style={paraStyle} order={"#"+h2counter+"#"+h3counter+"#"+h4counter}></heading4>;
			Heading3.appendChild(Heading4);
			h4counter++;
		}
	} catch(err) {}
}

var file = new File(docPath + "/" + doc.name.split(".indd").join(".xml"));
var xml = root.toXMLString();
// $.writeln(xml);

// for (var j=0; j<xml.elements.length; j++) {
// 	$.writeln(xml.elements[j].name);
// }

file.open("w");  
file.write(xml);
// file.encoding = "UNICODE";
file.close();

alert("Complete");

function GetHashCode(str){
    var hash = 0;
    for (var i = 0; i < str.length; i++) {
        var character = str.charCodeAt(i) * (i + 1);
        hash += character;
        // hash = hash & hash; // Convert to 32bit integer
    }
    return hash;
}