@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\

REM Set environment variables
set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%
set curDir=%cd%


rem java net.sf.saxon.Transform  -s:dummy.xml -xsl:xsls/designmap_name.xsl
rem java net.sf.saxon.Transform  -s:dummy.xml -xsl:xsls/story_merged.xsl
java net.sf.saxon.Transform  --suppressXsltNamespaceCheck:on  -s:dummy.xml -xsl:xsls/resource_merged.xsl
rem java net.sf.saxon.Transform  -s:temp/resource_merged.xml -xsl:xsls/cdata_remove.xsl -o:temp/cdata_remove.xml
rem java net.sf.saxon.Transform  -s:temp/cdata_remove.xml -xsl:xsls/trash_clean.xsl -o:temp/trash_clean.xml

pause

