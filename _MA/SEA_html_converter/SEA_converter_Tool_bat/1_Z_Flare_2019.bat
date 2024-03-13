@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\

REM Set environment variables
set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%

REM del /Q ..\resource\images\*.*

REM ren *.mcbook HTML.mcbook
REM ren *.mclog HTML.mclog

java net.sf.saxon.Transform -s:xsls2\dummy.xml               -o:temp\dummy.xml                -xsl:xsl_2019\xsls2\Flare-xsls\00-merge-chapters.xsl
@REM java net.sf.saxon.Transform -s:temp\merged.xml            -o:temp\01-make-html.html        -xsl:xsl_2019\xsls2\Flare-xsls\01-make-html.xsl
@REM java net.sf.saxon.Transform -s:temp\01-make-html.html        -o:temp\02-href_define.html      -xsl:xsl_2019\xsls2\Flare-xsls\02-href_define.xsl
@REM java net.sf.saxon.Transform -s:temp\02-href_define.html      -o:temp\03-make-review-html.html -xsl:xsl_2019\xsls2\Flare-xsls\03-make-review-html.xsl
@REM java net.sf.saxon.Transform -s:temp\03-make-review-html.html -o:temp\04-nest-bullet-1.html    -xsl:xsl_2019\xsls2\Flare-xsls\04-nest-bullet-1.xsl
@REM java net.sf.saxon.Transform -s:temp\04-nest-bullet-1.html    -o:temp\05-nest-bullet-body.html -xsl:xsl_2019\xsls2\Flare-xsls\05-nest-bullet-body.xsl
@REM java net.sf.saxon.Transform -s:temp\05-nest-bullet-body.html -o:temp\06-group-bullet-1.html   -xsl:xsl_2019\xsls2\Flare-xsls\06-group-bullet-1.xsl
@REM java net.sf.saxon.Transform -s:temp\06-group-bullet-1.html   -o:temp\07-group-bullet-2.html   -xsl:xsl_2019\xsls2\Flare-xsls\07-group-bullet-2.xsl
@REM java net.sf.saxon.Transform -s:temp\07-group-bullet-2.html   -o:temp\08-nest-bullet-2.html    -xsl:xsl_2019\xsls2\Flare-xsls\08-nest-bullet-2.xsl
@REM java net.sf.saxon.Transform -s:temp\08-nest-bullet-2.html    -o:temp\09-nest-graphic.html     -xsl:xsl_2019\xsls2\Flare-xsls\09-nest-graphic.xsl
@REM java net.sf.saxon.Transform -s:temp\09-nest-graphic.html     -o:temp\10-nest-between-ols.html -xsl:xsl_2019\xsls2\Flare-xsls\10-nest-between-ols.xsl
@REM java net.sf.saxon.Transform -s:temp\10-nest-between-ols.html -o:temp\11-group-ol.html         -xsl:xsl_2019\xsls2\Flare-xsls\11-group-ol.xsl
@REM java net.sf.saxon.Transform -s:temp\11-group-ol.html         -o:temp\finalize.html            -xsl:xsl_2019\xsls2\Flare-xsls\12-indent-yes.xsl


REM del temp\*temp.html temp\grouped*.html temp\nested*.html temp\review.html temp\mergedXML.xml
REM if exist output rmdir output /s /q >NUL

pause
