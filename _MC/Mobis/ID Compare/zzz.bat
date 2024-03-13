@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\

REM Set environment variables
set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%

rem if exist temp rd /q/s temp

@echo off
java net.sf.saxon.Transform -o:output.xml -s:links_id_float.xml -xsl:xsls/compare1.xsl
rem java net.sf.saxon.Transform -o:finalize.xml -s:output.xml -xsl:xsls/compare2.xsl
rem del output.xml
rem ************************************************************************************************************************************************
rem if exist temp rd /q/s temp

pause