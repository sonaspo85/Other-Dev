@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\

REM Set environment variables
set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%
set curDir=%cd%

rem echo.
rem set/p language="What is the language? "

echo.
echo    Select the number of the language below list
echo    =======================================================
			echo        1.  ENG        2. ENG-KR        3. KOR
echo    =======================================================
set/p language="** What do you want to select any number?  "
echo     You choice [ language %language% ].

java net.sf.saxon.Transform  -s:Paragraph_Variable.xml  -xsl:xsls\01.xsl  -o:output.xml language=%language%

pause

