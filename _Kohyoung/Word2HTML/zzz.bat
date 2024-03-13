@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\


set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
rem set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%\saxon-he-11.4.jar;%CLASSPATH%
REM set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%

set filename="H:/Dev_tool/_Kohyoung/Word2HTML/resources/AOI 2.8.0.0_Release Notes Attachments_Internal_KOR.htm"
set outfoldername="TESTfolder"
set outputPath="H:/Dev_tool/_Kohyoung/Word2HTML/Word2HTML/out"

if exist %outfoldername% rmdir %outfoldername% /s /q >NUL


rem rem rem ---- text to xml create ---------------
java net.sf.saxon.Transform -o:temp\00-line-feed.xml -s:xsls\dummy.xml -xsl:xsls\00-line-feed.xsl filename=%filename% outfoldername=%outfoldername%
java -cp %SAXON_DIR%lib\saxon9.jar net.sf.saxon.Transform -o:temp\01-orginal-source.xml -s:temp\00-line-feed.xml -xsl:xsls\01-extract-attr.xsl
java net.sf.saxon.Transform -o:temp\02-create-attr.xml -s:temp\01-extract-attr.xml -xsl:xsls\02-create-attr.xsl
java net.sf.saxon.Transform -o:temp\03-space-between-quot.xml -s:temp\02-create-attr.xml -xsl:xsls\03-space-between-quot.xsl
java net.sf.saxon.Transform -o:temp\04-self-closing_IDpos.xml -s:temp\03-space-between-quot.xml -xsl:xsls\04-self-closing_IDpos.xsl
java net.sf.saxon.Transform -o:temp\05-groupid-source.xml -s:temp\01-orginal-source.xml -xsl:xsls\05-groupid-source.xsl
java net.sf.saxon.Transform -o:temp\06-createXML-structure.xml -s:temp\05-groupid-source.xml -xsl:xsls\06-createXML-structure.xsl
java net.sf.saxon.Transform -o:temp\07-trash-tagClean.xml -s:temp\06-createXML-structure.xml -xsl:xsls\07-trash-tagClean.xsl
rem rem rem rem rem REM rem rem -----------------------------------

rem rem rem rem rem REM rem rem ---- create style tag ----------------
java net.sf.saxon.Transform -o:temp\08-make-styleinfo.xml -s:temp\07-extract-styleInfo.xml -xsl:xsls\08-make-styleinfo.xsl
java net.sf.saxon.Transform -o:temp\09-clear-styleinfo.xml -s:temp\08-make-styleinfo.xml -xsl:xsls\09-clear-styleinfo.xsl
rem REM rem rem rem ----------------------------------

java net.sf.saxon.Transform -o:temp\10-attrname-define.xml -s:temp\07-trash-tagClean.xml -xsl:xsls\10-attrname-define.xsl
java net.sf.saxon.Transform -o:temp\11-trash-tagClean.xml -s:temp\10-attrname-define.xml -xsl:xsls\11-trash-tagClean.xsl
java net.sf.saxon.Transform -o:temp\12-grouping-inlineText.xml -s:temp\11-trash-tagClean.xml -xsl:xsls\12-grouping-inlineText.xsl
java net.sf.saxon.Transform -o:temp\13-insert-destinationkeys.xml -s:temp\12-grouping-inlineText.xml -xsl:xsls\13-insert-destinationkeys.xsl

java net.sf.saxon.Transform -o:temp\14-image-grouping.xml -s:temp\13-insert-destinationkeys.xml -xsl:xsls\14-image-grouping.xsl
java net.sf.saxon.Transform -o:temp\14-nest-image.xml -s:temp\14-image-grouping.xml -xsl:xsls\14-nest-image.xsl
java net.sf.saxon.Transform -o:temp\15-grouping-SubList.xml -s:temp\14-nest-image.xml -xsl:xsls\15-grouping-SubList.xsl
java net.sf.saxon.Transform -o:temp\16-grouping-ULLlist.xml -s:temp\15-grouping-SubList.xml -xsl:xsls\16-grouping-ULLlist.xsl
java net.sf.saxon.Transform -o:temp\17-grouping-OLLlist.xml -s:temp\16-grouping-ULLlist.xml -xsl:xsls\17-grouping-OLLlist.xsl
java net.sf.saxon.Transform -o:temp\18-change-OLULtagName.xml -s:temp\17-grouping-OLLlist.xml -xsl:xsls\18-change-OLULtagName.xsl
java net.sf.saxon.Transform -o:temp\19-nested-OLUL.xml -s:temp\18-change-OLULtagName.xml -xsl:xsls\19-nested-OLUL.xsl
java net.sf.saxon.Transform -o:temp\20-grouping-ULOL.xml -s:temp\19-nested-OLUL.xml -xsl:xsls\20-grouping-ULOL.xsl
java net.sf.saxon.Transform -o:temp\21-delete-OLUL-umbering.xml -s:temp\20-grouping-ULOL.xml -xsl:xsls\21-delete-OLUL-umbering.xsl
java net.sf.saxon.Transform -o:temp\22-tableControl.xml -s:temp\21-delete-OLUL-umbering.xml -xsl:xsls\22-tableControl.xsl
java net.sf.saxon.Transform -o:temp\23-tableControl.xml -s:temp\22-tableControl.xml -xsl:xsls\23-tableControl.xsl
java net.sf.saxon.Transform -o:temp\24-grouping-note.xml -s:temp\23-tableControl.xml -xsl:xsls\24-grouping-note.xsl
java net.sf.saxon.Transform -o:temp\25-grouping-noteList.xml -s:temp\24-grouping-note.xml -xsl:xsls\25-grouping-noteList.xsl
java net.sf.saxon.Transform -o:temp\26-grouping-ULOL.xml -s:temp\25-grouping-noteList.xml -xsl:xsls\26-grouping-ULOL.xsl
java net.sf.saxon.Transform -o:temp\27-tagName-define.xml -s:temp\26-grouping-ULOL.xml -xsl:xsls\27-tagName-define.xsl
java net.sf.saxon.Transform -o:temp\28-grouping-para.xml -s:temp\27-tagName-define.xml -xsl:xsls\28-grouping-para.xsl
java net.sf.saxon.Transform -o:temp\29-topicalize.xml -s:temp\28-grouping-para.xml -xsl:xsls\29-topicalize.xsl
java net.sf.saxon.Transform -o:temp\30-grouping-midtitle.xml -s:temp\29-topicalize.xml -xsl:xsls\30-grouping-midtitle.xsl
java net.sf.saxon.Transform -o:temp\31-href-connection.xml -s:temp\30-grouping-midtitle.xml -xsl:xsls\31-href-connection.xsl
java net.sf.saxon.Transform -o:temp\32-final-cleaner.xml -s:temp\31-href-connection.xml -xsl:xsls\32-final-cleaner.xsl outputPath=%outputPath%


java net.sf.saxon.Transform -o:temp\dummy.xml -s:temp\32-final-cleaner.xml -xsl:xsls\33-search_js.xsl
java net.sf.saxon.Transform -o:temp\dummy.xml -s:temp\32-final-cleaner.xml -xsl:xsls\34-search-html.xsl
java net.sf.saxon.Transform -o:temp\dummy.xml -s:temp\32-final-cleaner.xml -xsl:xsls\35-split-html.xsl


rem xcopy "..\WORK\template\" "TESTfolder\*" /e/h/k/Y
pause