@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\


set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%

set region=SEA
set zipName=G998B_DS_QSG_CIS_Rus


rem if exist "%cd%\temp\mergeSrc" goto :cond
rem goto :skip

rem :cond
rem for %%d in ("%cd%\temp\cleanSource" "%cd%\temp\mergeSrc") do rd /s /q "%%~d"

rem :skip


rem rem rem rem  ************* IDML to XML  *********************
rem java net.sf.saxon.Transform  -s:xsls\dummy.xml -xsl:xsls/01-designmap_name.xsl
rem java net.sf.saxon.Transform  -s:xsls\dummy.xml -xsl:xsls/02-story_merged.xsl
java net.sf.saxon.Transform  -s:xsls\dummy.xml -xsl:xsls/03-specExtract.xsl
rem java net.sf.saxon.Transform -s:xsls\dummy.xml -xsl:xsls/04-resource_merged.xsl region=%region% zipName=%zipName%
rem java net.sf.saxon.Transform -o:temp\05-table-structure.xml -s:temp\04-resource_merged.xml -xsl:xsls/05-table-structure.xsl
rem java net.sf.saxon.Transform -o:temp\05_1-orderList-grouping.xml -s:temp\05-table-structure.xml -xsl:xsls/05_1-orderList-grouping.xsl


rem  ************* languageData Compare  *********************
rem java net.sf.saxon.Transform  -s:temp\05_1-orderList-grouping.xml -xsl:xsls/06-Main-spec-extract.xsl


rem rem rem rem rem rem  ************* excelData Compare  *********************
rem java net.sf.saxon.Transform -o:temp\07-excel-compare.xml -s:temp\06-spec-extract.xml -xsl:xsls\07-Main-excel-compare.xsl


rem rem rem rem rem rem rem rem  ************* output HTML  *********************
rem java net.sf.saxon.Transform -s:temp\07-excel-compare.xml -xsl:xsls\08-Main-html-structure.xsl
rem java net.sf.saxon.Transform -o:output\outputHTML.html -s:temp\outputHTML.xml -xsl:xsls\09-deep-indent.xsl




rem rem rem rem  ************* IDML folder delete *********************


rem java net.sf.saxon.Transform -o:temp\05-grouping-doc.xml -s:temp\05-table-structure.xml -xsl:xsls/05-grouping-doc.xsl
pause

