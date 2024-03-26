@echo off
chcp 65001
echo Just a moment, please!

rem set JAVA_HOME=H:\JAVA\java-workspace\SimpleCMS\jre\
rem set Path=%JAVA_HOME%\bin;%Path%
rem java -version

rem rem rem ----------------------------------------------------------------------------------

set SAXON_DIR=C:\Saxonica\
set CLASSPATH=%SAXON_DIR%lib\saxon-he-10.3.jar;%CLASSPATH%;
set _JAVA_OPTIONS=-Xmx4048m -Xms4048m

rem ***  variable  ***
set transform=net.sf.saxon.Transform

rem rem rem ----------------------------------------------------------------------------------

set resourcdDir="H:/Workspace/Other-Dev/_MA/Invoice/bat/resource"
set xslDir="H:/Workspace/Other-Dev/_MA/Invoice/bat/xsls"
set tempDir="H:/Workspace/Other-Dev/_MA/Invoice/bat/temp"




rem rem rem rem rem rem *************************************************************
java %transform%  -s:%xslDir%\dummy.xml  -o:%tempDir%\001.xml  -xsl:%xslDir%\001.xsl  resourcdDir=%resourcdDir%
java %transform%  -s:%tempDir%\001.xml  -o:%tempDir%\002.xml  -xsl:%xslDir%\002.xsl
java %transform%  -s:%tempDir%\002.xml  -o:%tempDir%\003.xml  -xsl:%xslDir%\003.xsl
java %transform%  -s:%tempDir%\001.xml  -o:%tempDir%\003-2.xml  -xsl:%xslDir%\003-2.xsl
java %transform%  -s:%tempDir%\003-2.xml  -o:%tempDir%\004.xml  -xsl:%xslDir%\004.xsl  tempDir=%tempDir%





rem java %transform%  -s:%resourcdDir%\combined_output.xml  -o:%tempDir%\004.xml  -xsl:%xslDir%\004.xsl  mergedF=%tempDir%

echo complete!!
rem pause

