@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\
set _JAVA_OPTIONS=-Xmx4024m -Xms4024m

set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon-he-10.3.jar;%CLASSPATH%

set transform=net.sf.saxon.Transform


set srcPath=D:\MA\Mobile\OneClick\231214-1\test2\
set tempPath=%srcPath%\temp
set xslPath=H:\Dev_tool\_MA\OneClickAssist\xsls

@echo off
rem rem rem ********* idml_import.xml **********
rem java net.sf.saxon.Transform  -s:%tempPath%\Cross.xml  -o:%tempPath%\001.xml  -xsl:%xslPath%\001.xsl
rem java net.sf.saxon.Transform  -s:%tempPath%\001.xml  -o:%tempPath%\002.xml  -xsl:%xslPath%\002.xsl
rem java net.sf.saxon.Transform  -s:%tempPath%\002.xml  -o:%tempPath%\003.xml  -xsl:%xslPath%\003.xsl
rem java net.sf.saxon.Transform  -s:%tempPath%\003.xml  -o:%tempPath%\003_1.xml  -xsl:%xslPath%\003_1.xsl
rem java net.sf.saxon.Transform  -s:%tempPath%\003_1.xml  -o:%tempPath%\003_2.xml  -xsl:%xslPath%\003_2.xsl
rem java net.sf.saxon.Transform  -s:%tempPath%\003_2.xml  -o:%tempPath%\003_3.xml  -xsl:%xslPath%\003_3.xsl  tempPath=%tempPath%
java net.sf.saxon.Transform  -s:%tempPath%\003_3.xml  -o:%srcPath%\tags.xml  -xsl:%xslPath%\003_4.xsl
rem rem rem rem *************************************************

rem java net.sf.saxon.Transform  -s:%xslPath%\dummy.xml  -o:%srcPath%\out\dummy.xml  -xsl:%xslPath%\006.xsl  srcPath=%srcPath%

rem rem rem rem *************************************************


rem pause



rem java net.sf.saxon.Transform  -s:temp\search.html  -o:temp\search_new.html  -xsl:xsls\004.xsl
rem java net.sf.saxon.Transform  -s:temp\start_here.html  -o:temp\start_here_new.html  -xsl:xsls\005.xsl
rem if exist temp rd /q/s temp




