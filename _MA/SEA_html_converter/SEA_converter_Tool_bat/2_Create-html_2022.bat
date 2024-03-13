@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\

REM Set environment variables
set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%


rem del /F /Q resource\images\*.*
echo.
set/p model="Enter model name: "
set/p language="Select language (en / sp): "
REM rem set/p code="Enter model code: "


rem if exist Source-Flare\output rmdir Source-Flare\output /s /q >NUL
rem xcopy templates\* Source-Flare\output\ /q/s/i >NUL

java net.sf.saxon.Transform  -s:temp\finalize.html -o:temp\13-find-and-replace.xml -xsl:xsl_2022\xsls2\13-find-and-replace.xsl language=%language% model=%model%
java net.sf.saxon.Transform  -s:temp\13-find-and-replace.xml -o:temp\14-olul-grouping.xml -xsl:xsl_2022\xsls2\14-olul-grouping.xsl
java net.sf.saxon.Transform  -s:temp\14-olul-grouping.xml -o:temp\15-chapterize.xml -xsl:xsl_2022\xsls2\15-chapterize.xsl
java net.sf.saxon.Transform  -s:temp\15-chapterize.xml -o:temp\16-toc_chap_group.xml -xsl:xsl_2022\xsls2\16-toc_chap_group.xsl
java net.sf.saxon.Transform  -s:temp\16-toc_chap_group.xml -o:temp\17-class_blue_group.xml -xsl:xsl_2022\xsls2\17-class_blue_group.xsl
java net.sf.saxon.Transform  -s:temp\17-class_blue_group.xml -o:temp\18-sectionize.xml -xsl:xsl_2022\xsls2\18-sectionize.xsl
java net.sf.saxon.Transform  -s:temp\18-sectionize.xml -o:temp\19-grouping-topic.xml -xsl:xsl_2022\xsls2\19-grouping-topic.xsl
java net.sf.saxon.Transform  -s:temp\19-grouping-topic.xml -o:temp\20-define-Header_href_table.xml -xsl:xsl_2022\xsls2\20-define-Header_href_table.xsl

rem REM rem **************************************************************************************
java net.sf.saxon.Transform  -s:temp\20-define-Header_href_table.xml -o:temp\dummy.xml -xsl:xsl_2022\xsls2\21-minitoc.xsl
java net.sf.saxon.Transform  -s:temp\20-define-Header_href_table.xml -o:temp\dummy.xml -xsl:xsl_2022\xsls2\22-splitting.xsl
java net.sf.saxon.Transform  -s:temp\20-define-Header_href_table.xml -o:temp\dummy.xml -xsl:xsl_2022\xsls2\23-making-toc.xsl

java net.sf.saxon.Transform  -s:temp\20-define-Header_href_table.xml -o:temp\dummy.xml -xsl:xsl_2022\xsls2\24-making-start-here.xsl
java net.sf.saxon.Transform  -s:temp\19-grouping-topic.xml -o:temp\dummy.xml -xsl:xsl_2022\xsls2\25-making-search-html.xsl
java net.sf.saxon.Transform  -s:temp\19-grouping-topic.xml -o:temp\dummy.xml -xsl:xsl_2022\xsls2\26-making-json.xsl






rem REM rem ********************************************************************************************
rem REM rem **************** start-here.html 로 접속 되기 위한 index.html**************************
rem xcopy xsls2\index.html Source-Flare\output\ /q/s/i >NUL
rem java net.sf.saxon.Transform  -s:temp\19-grouping-topic.xml -o:temp\dummy.xml -xsl:xsls2\27-making-app.xsl


REM if exist temp rmdir temp /s /q >NUL
rem del 00-find-and-replace.xml 00-olul-grouping.xml 01-chapterize.xml 01-toc_chap_group.xml 01-class_blue_group.xml 02-sectionize.xml 03-topicalize.xml 04-topicalize.xml dummy.xml


REM rem ****개발자 편의를 위해 header태그가 속한 파일 path를 추출*******************************
rem java net.sf.saxon.Transform  -s:temp\19-grouping-topic.xml -o:temp\dummy.xml -xsl:xsls2\28-making-cross.xsl




pause