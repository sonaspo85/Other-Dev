@echo off
echo Just a moment, please!

set SAXON_DIR=C:\Saxonica\
set CLASSPATH=%SAXON_DIR%lib\saxon-ee-10.0.jar;%CLASSPATH%;%CLASSPATH1%

java net.sf.saxon.Transform  -o:temp\out01.xml  -s:resource\output.xml -xsl:xsls/01.xsl
java net.sf.saxon.Transform  -o:temp\out02.xml  -s:temp\out01.xml -xsl:xsls/02.xsl

pause