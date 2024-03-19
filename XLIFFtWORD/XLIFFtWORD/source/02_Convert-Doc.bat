@echo off
echo Just a moment, please!
echo I'm processing...

set CLASSPATH=
set SAXON_DIR=\xsls\Saxonica\

REM Set environment variables
set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%

for %%G in (*.sdlxliff) do (
ren %%G source.sdlxliff
java -Xmx1024m net.sf.saxon.Transform -o:bi-lingual.xml -s:source.sdlxliff -xsl:xsls\bi-lingual.xsl
java -Xmx1024m net.sf.saxon.Transform -o:dummy.xml -s:bi-lingual.xml -xsl:xsls\make-doc.xsl
del source.sdlxliff
)
del bi-lingual.xml
echo Success!
pause