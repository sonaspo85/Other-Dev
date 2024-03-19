@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\


set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
REM set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%

set filename=E:/Dev_tool/unicodeTochar/eManual_Data_BUR_UNICODE_CONVERT_FINAL.py
set checkLang=BUR

if exist output rmdir output /s /q >NUL

rem rem ---- text to xml create ---------------
REM java net.sf.saxon.Transform -o:output.xml -s:dummy.xml -xsl:xsls\test01.xsl filename=%filename%
REM java net.sf.saxon.Transform -o:output2.xml -s:output.xml -xsl:xsls\test02.xsl
REM java net.sf.saxon.Transform -o:output3.xml -s:output2.xml -xsl:xsls\test03.xsl
java net.sf.saxon.Transform -o:output4.xml -s:output3.xml -xsl:xsls\test04.xsl
REM java net.sf.saxon.Transform -o:output5.xml -s:output4.xml -xsl:xsls\test05.xsl

REM java net.sf.saxon.Transform -o:output6.xml -s:sample.xml -xsl:xsls\test06.xsl  checkLang=%checkLang%
REM java net.sf.saxon.Transform -o:output6.xml -s:Paragraph_Variable.xml -xsl:xsls\test06.xsl checkLang=%checkLang%

REM java -Xmx4048m net.sf.saxon.Transform -o:output7.xml -s:output6.xml -xsl:xsls\test07.xsl checkLang=%checkLang%


REM java net.sf.saxon.Transform -o:output7.xml -s:output6.xml -xsl:xsls\test000.xsl

rem rem  ------------------------------
java net.sf.saxon.Transform -o:test_ENG_extract01.xml -s:dummy.xml -xsl:xsls\test_ENG_extract01.xsl

rem rem  ------------------------------
pause

