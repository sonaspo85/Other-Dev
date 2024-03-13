@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\

REM Set environment variables
set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%

set SourcePath="H:/Dev_tool/_MA/SEA_html_converter/SEA_converter_Tool_bat/resource/WEA_R90X_R91X_R92X_EN_UM_VF6_080122_FINAL.htm"

rem ONE-STEP Flare **************************************************************************************
java net.sf.saxon.Transform  -s:temp\merged.xml            -o:temp\00-make-one-html.html 	-xsl:xsl_2022\xsls2\Flare-xsls\00-make-one-html.xsl
java net.sf.saxon.Transform  -s:temp\00-make-one-html.html    -o:temp\01-make-html.html    	    -xsl:xsl_2022\xsls2\Flare-xsls\01-make-html.xsl
java net.sf.saxon.Transform  -s:temp\01-make-html.html        -o:temp\02-href_define.html 	 	-xsl:xsl_2022\xsls2\Flare-xsls\02-href_define.xsl
java net.sf.saxon.Transform  -s:temp\02-href_define.html      -o:temp\03-review.html 	 		-xsl:xsl_2022\xsls2\Flare-xsls\03-make-review-html.xsl
java net.sf.saxon.Transform  -s:temp\03-review.html           -o:temp\04-nested1.html 	 	    -xsl:xsl_2022\xsls2\Flare-xsls\04-nest-bullet-1.xsl
java net.sf.saxon.Transform  -s:temp\04-nested1.html          -o:temp\05-nested2.html 	 	    -xsl:xsl_2022\xsls2\Flare-xsls\05-nest-bullet-body.xsl
java net.sf.saxon.Transform  -s:temp\05-nested2.html          -o:temp\06-grouped1.html 	 	    -xsl:xsl_2022\xsls2\Flare-xsls\06-group-bullet-1.xsl
java net.sf.saxon.Transform  -s:temp\06-grouped1.html         -o:temp\07-img_wrap.html 	 	    -xsl:xsl_2022\xsls2\Flare-xsls\07-img_wrap.xsl
java net.sf.saxon.Transform  -s:temp\07-img_wrap.html         -o:temp\08-nested3.html 	 	    -xsl:xsl_2022\xsls2\Flare-xsls\08-nest-bullet-2.xsl
java net.sf.saxon.Transform  -s:temp\08-nested3.html          -o:temp\09-nested4.html 	 	    -xsl:xsl_2022\xsls2\Flare-xsls\09-nest-graphic.xsl
java net.sf.saxon.Transform  -s:temp\09-nested4.html          -o:temp\10-nested5.html 	 	    -xsl:xsl_2022\xsls2\Flare-xsls\10-nest-between-ols.xsl
java net.sf.saxon.Transform  -s:temp\10-nested5.html          -o:temp\11-grouped3.html 		    -xsl:xsl_2022\xsls2\Flare-xsls\11-group-ol.xsl
java net.sf.saxon.Transform  -s:temp\11-grouped3.html         -o:temp\finalize.html 		 	-xsl:xsl_2022\xsls2\Flare-xsls\12-temporary_check.xsl


pause