@echo off
set SAXON_DIR=C:\Saxonica\

set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9ee.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%

set targetPath="G:\WORK\kohyoung\221014\01_HTML ddd\00_SPI_ProgramimingGuides"
java net.sf.saxon.Transform  -s:xsls\dummy.xml  -o:temp\search_db.js  -xsl:xsls\01-marged.xsl  targetPath=%targetPath%



pause