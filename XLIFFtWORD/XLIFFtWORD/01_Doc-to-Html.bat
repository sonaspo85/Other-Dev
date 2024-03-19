@echo off
echo Just a moment, please!
echo I'm processing...

REM  This file is part of the DITA Open Toolkit project
REM  See the accompanying license.txt file for applicable licenses.
REM  (c) Copyright IBM Corp. 2006 All Rights Reserved.

REM Get the absolute path of DITAOT's home directory
set DITA_DIR=C:\DITA-OT-2.3\

rem Set environment variables
set ANT_OPTS=-Xmx1024m %ANT_OPTS%
set ANT_OPTS=%ANT_OPTS% -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl
set ANT_HOME=%DITA_DIR%
set PATH=%DITA_DIR%\bin;%PATH%
set CLASSPATH=%DITA_DIR%lib;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\dost.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\commons-codec-1.9.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\commons-io-2.4.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xml-resolver-1.2.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\icu4j-54.1.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xercesImpl-2.11.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xml-apis-1.4.01.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\saxon-9.1.0.8-dom.jar;%CLASSPATH%

java net.sf.saxon.Transform -o:source.html -s:source.xml -xsl:xsls\cleaning.xsl

del source.xml
echo Success!
pause
