@echo off
echo Just a moment, please!
echo *** Mobis processing ***

set SAXON_DIR=C:\Saxonica\
set _JAVA_OPTIONS=-Xmx4024m -Xms4024m

set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon-he-10.3.jar;%CLASSPATH%

set transform=net.sf.saxon.Transform

set projectDirs="G:/MS-Drive/OneDrive - UOU/WORK/Workspace/WORK/Other-Dev/_MC/Mobis/IDMLtoHTML_Converter_V6/"

if exist output rmdir output /s /q >NUL

@echo off
rem rem rem ********* idml_import.xml **********as
rem java %transform% -s:%projectDirs%resource\mergedXML.xml -o:%projectDirs%temp\01-simplified.xml -xsl:%projectDirs%xsls\01-simplify.xsl
rem java %transform% -s:%projectDirs%temp\01-simplified.xml -o:%projectDirs%temp\02_0-RTLLgsArrowDirection.xml -xsl:%projectDirs%xsls\02_0-RTLLgsArrowDirection.xsl
rem java %transform% -s:%projectDirs%temp\02_0-RTLLgsArrowDirection.xml -o:%projectDirs%temp\02_1-tagsClear.xml -xsl:%projectDirs%xsls\02_1-tagsClear.xsl
rem java %transform% -s:%projectDirs%temp\02_1-tagsClear.xml -o:%projectDirs%temp\02_2-videoWithInNode.xml -xsl:%projectDirs%xsls\02_2-videoWithInNode.xsl
rem java %transform% -s:%projectDirs%temp\02_2-videoWithInNode.xml -o:%projectDirs%temp\02_3-CharRangeParaRange.xml -xsl:%projectDirs%xsls\02_3-CharRangeParaRange.xsl
rem java %transform% -s:%projectDirs%temp\02_3-CharRangeParaRange.xml -o:%projectDirs%temp\03_0-imgOrtagsClear.xml -xsl:%projectDirs%xsls\03_0-imgOrtagsClear.xsl
rem java %transform% -s:%projectDirs%temp\03_0-imgOrtagsClear.xml -o:%projectDirs%temp\03_1-tableDefine.xml -xsl:%projectDirs%xsls\03_1-tableDefine.xsl
rem java %transform% -s:%projectDirs%temp\03_1-tableDefine.xml -o:%projectDirs%temp\03_2-pDefine.xml -xsl:%projectDirs%xsls\03_2-pDefine.xsl
rem java %transform% -s:%projectDirs%temp\03_2-pDefine.xml -o:%projectDirs%temp\04_0-tableWidth.xml -xsl:%projectDirs%xsls\04_0-tableWidth.xsl
rem java %transform% -s:%projectDirs%temp\04_0-tableWidth.xml -o:%projectDirs%temp\04_1-hyperlinkPDHD.xml -xsl:%projectDirs%xsls\04_1-hyperlinkPDHD.xsl
rem java %transform% -s:%projectDirs%temp\04_1-hyperlinkPDHD.xml -o:%projectDirs%temp\04_2-tagsClear.xml -xsl:%projectDirs%xsls\04_2-tagsClear.xsl
rem java %transform% -s:%projectDirs%temp\04_2-tagsClear.xml -o:%projectDirs%temp\05-wrapTagHttp.xml -xsl:%projectDirs%xsls\05-wrapTagHttp.xsl
rem java %transform% -s:%projectDirs%temp\05-wrapTagHttp.xml -o:%projectDirs%resource/ch-images.xml -xsl:%projectDirs%xsls\06_0-chapterImgFilePath.xsl
rem java %transform% -s:%projectDirs%temp\05-wrapTagHttp.xml -o:%projectDirs%temp\06_1-convert_PtoH.xml -xsl:%projectDirs%xsls\06_1-convert_PtoH.xsl
rem java %transform% -s:%projectDirs%temp\06_1-convert_PtoH.xml -o:%projectDirs%temp\06_2-tagsClear.xml -xsl:%projectDirs%xsls\06_2-tagsClear.xsl
rem java %transform% -s:%projectDirs%temp\06_2-tagsClear.xml -o:%projectDirs%temp\07-createPlacing_Video.xml -xsl:%projectDirs%xsls\07-createPlacing_Video.xsl
rem java %transform% -s:%projectDirs%temp\07-createPlacing_Video.xml -o:%projectDirs%temp\08-split_BRWithin_ulol.xml -xsl:%projectDirs%xsls\08-split_BRWithin_ulol.xsl
rem java %transform% -s:%projectDirs%temp\08-split_BRWithin_ulol.xml -o:%projectDirs%temp\09_0-insert_UL4toUL.xml -xsl:%projectDirs%xsls\09_0-insert_UL4toUL.xsl
rem java %transform% -s:%projectDirs%temp\09_0-insert_UL4toUL.xml -o:%projectDirs%temp\09_1-wrap_headingInTopic.xml -xsl:%projectDirs%xsls\09_1-wrap_headingInTopic.xsl
rem java %transform% -s:%projectDirs%temp\09_1-wrap_headingInTopic.xml -o:%projectDirs%temp\10-topic_hierarchy.xml -xsl:%projectDirs%xsls\10-topic_hierarchy.xsl
rem java %transform% -s:%projectDirs%temp\10-topic_hierarchy.xml -o:%projectDirs%temp\11-insert_excelID.xml -xsl:%projectDirs%xsls\11-insert_excelID.xsl
rem java %transform% -s:%projectDirs%temp\11-insert_excelID.xml -o:%projectDirs%temp\12-replace_hrefAttrToSCID.xml -xsl:%projectDirs%xsls\12-replace_hrefAttrToSCID.xsl
rem java %transform% -s:%projectDirs%temp\12-replace_hrefAttrToSCID.xml -o:%projectDirs%temp\13-nest_ULnote_child.xml -xsl:%projectDirs%xsls\13-nest_ULnote_child.xsl
rem java %transform% -s:%projectDirs%temp\13-nest_ULnote_child.xml -o:%projectDirs%temp\14-adjustGrouping_ul.xml -xsl:%projectDirs%xsls\14-adjustGrouping_ul.xsl
rem java %transform% -s:%projectDirs%temp\14-adjustGrouping_ul.xml -o:%projectDirs%temp\15-nest_ULnote.xml -xsl:%projectDirs%xsls\15-nest_ULnote.xsl
rem java %transform% -s:%projectDirs%temp\15-nest_ULnote.xml -o:%projectDirs%temp\16-adjustGrouping_ul1.xml -xsl:%projectDirs%xsls\16-adjustGrouping_ul1.xsl
rem java %transform% -s:%projectDirs%temp\16-adjustGrouping_ul1.xml -o:%projectDirs%temp\17-tableVR_rowspanCNT.xml -xsl:%projectDirs%xsls\17-tableVR_rowspanCNT.xsl
rem java %transform% -s:%projectDirs%temp\17-tableVR_rowspanCNT.xml -o:%projectDirs%temp\18-nest_groupTag.xml -xsl:%projectDirs%xsls\18-nest_groupTag.xsl
rem java %transform% -s:%projectDirs%temp\18-nest_groupTag.xml -o:%projectDirs%temp\19-tagsClear.xml -xsl:%projectDirs%xsls\19-tagsClear.xsl
rem java %transform% -s:%projectDirs%temp\19-tagsClear.xml -o:%projectDirs%temp\20-nest_by_ul.xml -xsl:%projectDirs%xsls\20-nest_by_ul.xsl
rem java %transform% -s:%projectDirs%temp\20-nest_by_ul.xml -o:%projectDirs%temp\21-adjustGrouping_ul1-2.xml -xsl:%projectDirs%xsls\21-adjustGrouping_ul1-2.xsl
rem java %transform% -s:%projectDirs%temp\21-adjustGrouping_ul1-2.xml -o:%projectDirs%temp\22-nest-ul1to3.xml -xsl:%projectDirs%xsls\22-nest-ul1to3.xsl
rem java %transform% -s:%projectDirs%temp\22-nest-ul1to3.xml -o:%projectDirs%temp\23-nest_betweenColors.xml  -xsl:%projectDirs%xsls\23-nest_betweenColors.xsl
rem java %transform% -s:%projectDirs%temp\23-nest_betweenColors.xml -o:%projectDirs%temp\24-adjustGrouping_color.xml -xsl:%projectDirs%xsls\24-adjustGrouping_color.xsl
rem java %transform% -s:%projectDirs%temp\24-adjustGrouping_color.xml -o:%projectDirs%temp\25-convert_GroupTagsToOL.xml -xsl:%projectDirs%xsls\25-convert_GroupTagsToOL.xsl
rem java %transform% -s:%projectDirs%temp\25-convert_GroupTagsToOL.xml -o:%projectDirs%temp\26-nest_ul2CautionWarning.xml -xsl:%projectDirs%xsls\26-nest_ul2CautionWarning.xsl
rem java %transform% -s:%projectDirs%temp\26-nest_ul2CautionWarning.xml -o:%projectDirs%temp\27-startGrouping_cmdOL.xml -xsl:%projectDirs%xsls\27-startGrouping_cmdOL.xsl
rem java %transform% -s:%projectDirs%temp\27-startGrouping_cmdOL.xml -o:%projectDirs%temp\28-adjustGrouping_cmdOL.xml -xsl:%projectDirs%xsls\28-adjustGrouping_cmdOL.xsl
rem java %transform% -s:%projectDirs%temp\28-adjustGrouping_cmdOL.xml -o:%projectDirs%temp\29-imgTagsClear.xml -xsl:%projectDirs%xsls\29-imgTagsClear.xsl
rem java %transform% -s:%projectDirs%temp\29-imgTagsClear.xml -o:%projectDirs%temp\30-unWrap_nestingLastImg.xml -xsl:%projectDirs%xsls\30-unWrap_nestingLastImg.xsl
rem java %transform% -s:%projectDirs%temp\30-unWrap_nestingLastImg.xml -o:%projectDirs%temp\31-tagsClear.xml -xsl:%projectDirs%xsls\31-tagsClear.xsl
rem java %transform% -s:%projectDirs%temp\31-tagsClear.xml -o:%projectDirs%temp\32-define_titleLvNfileAttr.xml -xsl:%projectDirs%xsls\32-define_titleLvNfileAttr.xsl
rem java %transform% -s:%projectDirs%temp\32-define_titleLvNfileAttr.xml -o:%projectDirs%temp\33-wrap_h1h2inDiv.xml -xsl:%projectDirs%xsls\33-wrap_h1h2inDiv.xsl
rem java %transform%  -s:%projectDirs%temp\33-wrap_h1h2inDiv.xml -o:%projectDirs%temp\34-startGrouping_linemit.xml -xsl:%projectDirs%xsls\34-startGrouping_linemit.xsl
rem java %transform% -s:%projectDirs%temp\34-startGrouping_linemit.xml -o:%projectDirs%temp\35-nest_warningGroupAttr.xml -xsl:%projectDirs%xsls\35-nest_warningGroupAttr.xsl
rem java %transform% -s:%projectDirs%temp\35-nest_warningGroupAttr.xml -o:%projectDirs%temp\36-adjustGrouping_h2Continue.xml -xsl:%projectDirs%xsls\36-adjustGrouping_h2Continue.xsl
rem java %transform% -s:%projectDirs%temp\36-adjustGrouping_h2Continue.xml -o:%projectDirs%temp\37-make_videoTags.xml -xsl:%projectDirs%xsls\37-make_videoTags.xsl
rem java %transform% -s:%projectDirs%temp\37-make_videoTags.xml -o:%projectDirs%temp\38-define_featureChap_FileAttr.xml -xsl:%projectDirs%xsls\38-define_featureChap_FileAttr.xsl
rem java %transform% -s:%projectDirs%temp\38-define_featureChap_FileAttr.xml -o:%projectDirs%temp\39-define_Atag_HrefAttr.xml -xsl:%projectDirs%xsls\39-define_Atag_HrefAttr.xsl
rem java %transform% -s:%projectDirs%temp\39-define_Atag_HrefAttr.xml -o:%projectDirs%temp\40-setExportFileName.xml -xsl:%projectDirs%xsls\40-setExportFileName.xsl
rem java %transform% -s:%projectDirs%temp\40-setExportFileName.xml -o:%projectDirs%temp\41-tagsClear.xml -xsl:%projectDirs%xsls\41-tagsClear.xsl
rem java %transform% -s:%projectDirs%temp\41-tagsClear.xml -o:%projectDirs%resource\htmlBase.xml -xsl:%projectDirs%xsls\42-defineApplink.xsl
rem rem rem rem rem rem rem *********************************************************************************************************
rem java %transform% -s:%projectDirs%resource\UITxt.xml -o:%projectDirs%temp\dummy.xml -xsl:%projectDirs%xsls\43-makeUITextJson.xsl
rem java %transform% -s:%projectDirs%resource\tocBase.xml -o:%projectDirs%temp\dummy.xml -xsl:%projectDirs%xsls\44-makeToc.xsl
rem java %transform% -s:%projectDirs%resource\tocBase.xml -o:%projectDirs%temp\dummy.xml -xsl:%projectDirs%xsls\45-makeToc.xsl
rem java %transform% -s:%projectDirs%resource\tocBase.xml -o:%projectDirs%temp\dummy.xml -xsl:%projectDirs%xsls\46-makeMiniToc.xsl
rem java %transform% -s:%projectDirs%resource\tocBase.xml -o:%projectDirs%temp\dummy.xml -xsl:%projectDirs%xsls\47-makeIndex.xsl
rem java %transform% -s:%projectDirs%resource\htmlBase.xml -o:%projectDirs%temp\dummy.xml -xsl:%projectDirs%xsls\48-convertToHtml.xsl
rem java %transform% -s:%projectDirs%resource\htmlBase.xml -o:%projectDirs%temp\dummy.xml -xsl:%projectDirs%xsls\49-make_id_db.xsl
rem java %transform% -s:%projectDirs%resource\htmlBase.xml -o:%projectDirs%temp\dummy.xml -xsl:%projectDirs%xsls\50-makeSearchJson.xsl
rem java %transform%  -s:%projectDirs%resource\tocBase.xml -o:%projectDirs%temp\dummy.xml -xsl:%projectDirs%xsls\51-makeSearchHtml.xsl
java %transform%  -s:%projectDirs%xsls\dummy.xml -o:%projectDirs%temp\dummy.xml -xsl:%projectDirs%xsls\52-makeEOupdate.xsl


echo complete!!
rem pause





rem if exist temp rd /q/s temp




