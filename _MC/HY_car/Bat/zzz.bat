@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\

REM Set environment variables
set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%
set curDir=%cd%

echo.
set/p language="What is the language? "
echo.
echo what is the model name?
echo  1. KONA Hybrid (OS HEV)
echo  2. VENUE (QX)
echo  3. GENESIS (JX)
set/p modelname="what is the model name? "
echo You choice [ cartype %modelname% ].

echo.
echo What is the cartype?
echo  1. genesis
echo  2. hyundai
echo.
set /p type="Input the number of the type you want to use: "
echo You choice [ cartype %type% ].

@echo off

java net.sf.saxon.Transform  -s:dummy.xml  -xsl:xsls\01-merged.xsl  -o:temp\01-merged.xml   modelname=%modelname% language=%language% cartype=%type%
rem rem rem java net.sf.saxon.Transform  -s:temp\merged.xml  -xsl:xsls\call-merged.xsl
java net.sf.saxon.Transform  -s:temp\01-merged.xml  -xsl:xsls\00-external_inline-strc.xsl  -o:temp\00-external_inline-strc.xml
java net.sf.saxon.Transform  -s:temp\00-external_inline-strc.xml  -xsl:xsls\02-trash_clean.xsl  -o:temp\02-trash_clean.xml
java net.sf.saxon.Transform  -s:temp\02-trash_clean.xml  -xsl:xsls\03-list_indent_define.xsl  -o:temp\03-list_indent_define.xml
java net.sf.saxon.Transform  -s:temp\03-list_indent_define.xml -xsl:xsls\04-ol-list-style-grouping.xsl  -o:temp\04-ol-list-style-grouping.xml
java net.sf.saxon.Transform  -s:temp\04-ol-list-style-grouping.xml -xsl:xsls\05-ul-list-style-grouping.xsl  -o:temp\05-ul-list-style-grouping.xml
java net.sf.saxon.Transform  -s:temp\05-ul-list-style-grouping.xml -xsl:xsls\06-ol-numbering.xsl  -o:temp\06-ol-numbering.xml
java net.sf.saxon.Transform  -s:temp\06-ol-numbering.xml -xsl:xsls\07-ol-nested.xsl  -o:temp\07-ol-nested.xml
java net.sf.saxon.Transform  -s:temp\07-ol-nested.xml -xsl:xsls\08-ul-nested.xsl  -o:temp\08-ul-nested.xml
java net.sf.saxon.Transform  -s:temp\08-ul-nested.xml -xsl:xsls\09-style-list-adjacent.xsl  -o:temp\09-style-list-adjacent.xml
java net.sf.saxon.Transform  -s:temp\09-style-list-adjacent.xml -xsl:xsls\10-style-list-structure.xsl  -o:temp\10-style-list-structure.xml
java net.sf.saxon.Transform  -s:temp\10-style-list-structure.xml -xsl:xsls\11-list-child.xsl  -o:temp\11-list-child.xml
java net.sf.saxon.Transform  -s:temp\11-list-child.xml -xsl:xsls\12-waring-group.xsl  -o:temp\12-waring-group.xml
java net.sf.saxon.Transform  -s:temp\12-waring-group.xml -xsl:xsls\13-Table-split.xsl  -o:temp\13-Table-split.xml
java net.sf.saxon.Transform  -s:temp\13-Table-split.xml -xsl:xsls\14-Table-converting.xsl  -o:temp\14-Table-converting.xml
java net.sf.saxon.Transform  -s:temp\14-Table-converting.xml -xsl:xsls\15-Table-structure.xsl  -o:temp\15-Table-structure.xml
java net.sf.saxon.Transform  -s:temp\15-Table-structure.xml -xsl:xsls\16-nest-grouping.xsl  -o:temp\16-nest-grouping.xml
java net.sf.saxon.Transform  -s:temp\16-nest-grouping.xml -xsl:xsls\17-div-split.xsl  -o:temp\17-div-split.xml
java net.sf.saxon.Transform  -s:temp\17-div-split.xml -xsl:xsls\18-heading-define.xsl  -o:temp\18-heading-define.xml
java net.sf.saxon.Transform  -s:temp\18-heading-define.xml -xsl:xsls\19-h2-grouping.xsl  -o:temp\19-h2-grouping.xml
java net.sf.saxon.Transform  -s:temp\19-h2-grouping.xml -xsl:xsls\20-href-a.xsl  -o:temp\20-href-a.xml
java net.sf.saxon.Transform  -s:temp\20-href-a.xml -xsl:xsls\21-img-conlr.xsl  -o:temp\21-img-conlr.xml
java net.sf.saxon.Transform  -s:temp\21-img-conlr.xml -xsl:xsls\22-img-class-define.xsl -o:temp\22-img-class-define.xml
java net.sf.saxon.Transform  -s:temp\22-img-class-define.xml -xsl:xsls\23-element-define.xsl  -o:temp\23-element-define.xml
java net.sf.saxon.Transform  -s:temp\23-element-define.xml -xsl:xsls\24-img_box_out.xsl  -o:temp\24-img_box_out.xml
java net.sf.saxon.Transform  -s:temp\24-img_box_out.xml -xsl:xsls\25-olul-class-define.xsl  -o:temp\25-olul-class-define.xml
java net.sf.saxon.Transform  -s:temp\25-olul-class-define.xml -xsl:xsls\25-1-grouping-toc.xsl  -o:temp\25-1-grouping-toc.xml
rem rem ------------------------------
java net.sf.saxon.Transform  -s:temp\25-1-grouping-toc.xml -xsl:xsls\26-mini-toc.xsl  -o:dummy.xml
java net.sf.saxon.Transform  -s:temp\25-olul-class-define.xml -xsl:xsls\27-index.xsl  -o:dummy.xml
java net.sf.saxon.Transform  -s:temp\25-olul-class-define.xml -xsl:xsls\28-split_html.xsl  -o:dummy.xml
pause

