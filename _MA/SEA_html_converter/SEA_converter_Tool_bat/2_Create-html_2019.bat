@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\

REM Set environment variables
set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%
REM del /F /Q resource\images\*.*

echo.
set/p model="Enter model name: "
set/p language="Select language (en / sp): "
REM set/p code="Enter model code: " 

rem if exist output rmdir output /s /q >NUL
rem xcopy resource\* output\ /q/s/i >NUL

java net.sf.saxon.Transform -s:temp\finalize.html -o:temp\13-find-and-replace.xml  -xsl:xsl_2019\xsls2\13-find-and-replace.xsl language=%language% model=%model%
java net.sf.saxon.Transform -s:temp\13-find-and-replace.xml -o:temp\14-olul-grouping.xml  -xsl:xsl_2019\xsls2\14-olul-grouping.xsl
java net.sf.saxon.Transform -s:temp\14-olul-grouping.xml -o:temp\15-chapterize.xml  -xsl:xsl_2019\xsls2\15-chapterize.xsl
java net.sf.saxon.Transform -s:temp\15-chapterize.xml -o:temp\16-define-headerName.xml  -xsl:xsl_2019\xsls2\16-define-headerName.xsl
java net.sf.saxon.Transform -s:temp\16-define-headerName.xml -o:temp\17-grouping-topic.xml  -xsl:xsl_2019\xsls2\17-grouping-topic.xsl
java net.sf.saxon.Transform -s:temp\17-grouping-topic.xml -o:temp\dummy.xml  -xsl:xsl_2019\xsls2\18-splitting.xsl
java net.sf.saxon.Transform -s:temp\17-grouping-topic.xml -o:temp\dummy.xml  -xsl:xsl_2019\xsls2\19-making-toc.xsl
rem rem **************************************************************************************
java net.sf.saxon.Transform -s:temp\17-grouping-topic.xml -o:temp\dummy.xml  -xsl:xsl_2019\xsls2\20-making-start-here.xsl
java net.sf.saxon.Transform -s:temp\17-grouping-topic.xml -o:temp\dummy.xml  -xsl:xsl_2019\xsls2\21-making-search-html.xsl
java net.sf.saxon.Transform -s:temp\17-grouping-topic.xml -o:temp\dummy.xml  -xsl:xsl_2019\xsls2\22-making-json.xsl
rem rem **************** start-here.html 로 접속 되기 위한 index.html**************************
java net.sf.saxon.Transform -s:temp\17-grouping-topic.xml -o:temp\dummy.xml  -xsl:xsl_2019\xsls2\23-making-app.xsl
rem xcopy xsls2\index.html output\ /q/s/i >NUL


REM rem ****개발자 편의를 위해 header태그가 속한 파일 path를 추출*******************************
REM java net.sf.saxon.Transform -s:temp\17-grouping-topic.xml -o:temp\dummy.xml  -xsl:xsls2\24-making-cross.xsl



REM del 00-find-and-replace.xml 00-olul-grouping.xml 01-chapterize.xml 02-sectionize.xml 03-topicalize.xml dummy.xml

pause