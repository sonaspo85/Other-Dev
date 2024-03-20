var myDoc = app.activeDocument;
myDoc.xmlPreferences.defaultCellTagName = "Cell";
myDoc.xmlPreferences.defaultImageTagName = "Image";
myDoc.xmlPreferences.defaultStoryTagName = "Story";
myDoc.xmlPreferences.defaultTableTagName = "Table";

var myGraphics = myDoc.allGraphics;
var myGraphicsCount = myGraphics.length;
var myMaster = myDoc.masterSpreads;
var myMasterNumber = myMaster.count() - 1;
var masterImage = 0;
for ( ; myMasterNumber > -1 ; myMasterNumber--) {
	imageNumber = myMaster[myMasterNumber].allGraphics;
	masterImage += imageNumber.length;
}
myGraphicsCount -= masterImage;

for (var j = 0; j < myGraphicsCount ; j++) {
	try {
		if (myGraphics[j].itemLink.status == 1819109747) {
			// 링크 오류 상태
			return false;
		}
	} catch (ex) {
		throw ex;
	}
}

function MappingToStyle(myDoc) {
    try {
        var result = true;
        
        var tables = myDoc.xmlElements[0].evaluateXPathExpression("descendant::Table[not(@HeaderRowCount)]");
        var tables_count = tables.length;
        
        if (tables_count > 0) {
            for (var i=0 ; i<tables_count ; i++) {
                var table = tables[i].tables[0];
                var tbDirection = ""; //추가 속성 by iM - 20.07.30
                tables[i].xmlAttributes.add('HeaderRowCount', table.headerRowCount + '');
                //추가 속성 by iM - 20.07.30
                tables[i].xmlAttributes.add('FooterRowCount', table.footerRowCount + '');
                tables[i].xmlAttributes.add('BodyRowCount', table.bodyRowCount + '');
                tables[i].xmlAttributes.add('ColumnCount', table.columnCount + '');
                if (table.tableDirection == "1278366308") {
                    tbDirection = "LeftToRightDirection";
                } else
                    tbDirection = "RightToLeftDirection";
                tables[i].xmlAttributes.add('TableDirection', tbDirection + '');
                tables[i].xmlAttributes.add('AppliedTableStyle', table.appliedTableStyle.name + '');
                //추가 속성 by iM - 20.07.30
                var rows = table.rows;
                var rows_count = rows.length;
                for (var j=0 ; j<rows_count ; j++)
                    rows[j].cells[0].associatedXMLElement.xmlAttributes.add('newrow', 'newrow');
                var columns = table.columns;
                var columns_count = columns.length;
                var widths = [];
                for (var j=0 ; j<columns_count ; j++)
                    widths = widths.concat((columns[j].width/table.width).toFixed(2) + '*');
                tables[i].xmlAttributes.add('colspecs', widths.join(':'));
            }
            

            var cells = myDoc.xmlElements[0].evaluateXPathExpression("descendant::Cell[not(@namest)]");
            var cells_count = cells.length;
            
            for (var i=0 ; i<cells_count ; i++) {
                var cell = cells[i].cells[0];
                var cellfBaseline = ""; //추가 속성 by iM - 20.07.30
                var cellVerticajust = ""; //추가 속성 by iM - 20.07.30
                if (cell.columnSpan > 1) {
                    var namest = cell.parentColumn.index + 1;
                    var nameend = namest + cell.columnSpan - 1;
                    cells[i].xmlAttributes.add('namest', 'col' + namest);
                    cells[i].xmlAttributes.add('nameend', 'col' + nameend);
                }
                //추가 속성 by iM - 20.07.30
                cells[i].xmlAttributes.add('Name', cell.name + '');
                cells[i].xmlAttributes.add('RowSpan', cell.rowSpan + '');
                cells[i].xmlAttributes.add('ColumnSpan', cell.columnSpan + '');
                cells[i].xmlAttributes.add('AppliedCellStyle', cell.appliedCellStyle.name + '');
                if (cell.firstBaselineOffset == "1296135023") {
                    cellfBaseline = "ASCENT_OFFSET";
                } if (cell.firstBaselineOffset == "1296255087") {
                    cellfBaseline = "CAP_HEIGHT";
                } if (cell.firstBaselineOffset == "1296386159") {
                    cellfBaseline = "EMBOX_HEIGHT";
                } if (cell.firstBaselineOffset == "1313228911") {
                    cellfBaseline = "FIXED_HEIGHT";
                } if (cell.firstBaselineOffset == "1296852079") {
                    cellfBaseline = "LEADING_OFFSET";
                } if (cell.firstBaselineOffset == "1299728495") {
                    cellfBaseline = "X_HEIGHT";
                }
                cells[i].xmlAttributes.add('FirstBaselineOffset', cellfBaseline + '');
                if (cell.verticalJustification == "1953460256") {
                    cellVerticajust = "TOP_ALIGN";
                } if (cell.verticalJustification == "1667591796") {
                    cellVerticajust = "CENTER_ALIGN";
                } if (cell.verticalJustification == "1651471469") {
                    cellVerticajust = "BOTTOM_ALIGN";
                } if (cell.verticalJustification == "1785951334") {
                    cellVerticajust = "JUSTIFY_ALIGN";
                }
                cells[i].xmlAttributes.add('VerticalJustification', cellVerticajust + '');
                //추가 속성 by iM - 20.07.30
            }
        }

        var TagList = myDoc.xmlTags.everyItem();
        var TagCounter = myDoc.xmlTags.count();
        var None = myDoc.characterStyles[0];
        var allParagraphStyles = myDoc.allParagraphStyles;
        var allCharacterStyles = myDoc.allCharacterStyles;
        var allTableStyles = myDoc.allTableStyles;
        var allCellStyles = myDoc.allCellStyles;
        var xmlMaps = myDoc.xmlImportMaps;

        // for (var i = 0 ; i < TagCounter ; i++) {
        //     // Cell, Story, Table, Topic*, PA_* 들은 따로 처리 해준다.
        //     TagName = TagList.name[i];
        //     var added = false;
            
        //     if (TagName == 'Root'
        //     || TagName == myDoc.xmlPreferences.defaultCellTagName
        //     || TagName == myDoc.xmlPreferences.defaultImageTagName
        //     || TagName == myDoc.xmlPreferences.defaultStoryTagName
        //     || TagName == myDoc.xmlPreferences.defaultTableTagName
        //     //|| TagName == 'topicItem'
        //     //|| TagName == 'xref'
        //     )
        //         added = true;
            
        //     if (imporCheck) {
        //         if (!added)
        //             xmlMaps.add(TagName, TagName);
        //         else
        //             xmlMaps.add(TagName, None);
        //     } else {
        //         if (!added) {
        //             for (var j = 2 ; j < allParagraphStyles.length ; j++) {
        //                 var ps = allParagraphStyles[j].name;
        //                 if (ps == TagName) {
        //                     xmlMaps.add(TagName, allParagraphStyles[j]);
        //                     added = true;
        //                     break;
        //                 }
        //             }
        //         }
                
        //         if (!added) {
        //             for (var j = 1 ; j < allCharacterStyles.length ; j++) {
        //                 var cs = allCharacterStyles[j].name;
        //                 if (cs == TagName) {
        //                     xmlMaps.add(TagName, allCharacterStyles[j]);
        //                     added = true;
        //                     break;
        //                 }
        //             }
        //         }
            
        //         if (!added) {
        //             for (var j = 0 ; j < allTableStyles.length ; j++) {
        //                 var ts = allTableStyles[j].name;
        //                 if (ts == TagName) {
        //                     xmlMaps.add(TagName, allTableStyles[j]);
        //                     added = true;
        //                     break;
        //                 }
        //             }
        //         }
            
        //         if (!added) {
        //             for (var j = 0 ; j < allCellStyles.length ; j++) {
        //                 var cs = allCellStyles[j].name;
        //                 if (cs == TagName) {
        //                     xmlMaps.add(TagName, allCellStyles[j]);
        //                     added = true;
        //                     break;
        //                 }
        //             }
        //         }
            
        //         if (!added) {
        //             errorMsgs.push(TagName + ' 태그 매핑 실패');
        //             result = false;
        //             hasError = true;
        //         }
        //     }
            
        // }
    
    //     if (result)
    //         myDoc.mapXMLTagsToStyles();
    //     else
    //         return result;

    //     var need_id = myDoc.xmlElements[0].evaluateXPathExpression("descendant::*[starts-with(name(), 'Chapter') or starts-with(name(), 'Heading') or name()='Description-NoHTML'][not(@id)]");
    //     var needs_count = need_id.length;
    //     for (var i=0 ; i<needs_count ; i++)
    //         need_id[i].xmlAttributes.add('id', 'd' + need_id[i].id);
            
    //     var nested = myDoc.xmlElements[0].evaluateXPathExpression("descendant::*[starts-with(name(), 'Empty')][not(@nested)][preceding-sibling::*[not(starts-with(name(), 'Empty'))][1][starts-with(name(), 'OrderList') or starts-with(name(), 'UnorderList')]]");
    //     var nested_count = nested.length;
    //     for (var i=0 ; i<nested_count ; i++)
    //         nested[i].xmlAttributes.add('nested', 'nested');
        
    //     return result;
    // } catch (ex) {
    //     errorMsgs.push('MappingToStyle 함수 오류(' + myDoc.name + '): Line:' + ex.line + ':: ' + ex);
    //     hasError = true;
    //     throw ex;
    // }
}