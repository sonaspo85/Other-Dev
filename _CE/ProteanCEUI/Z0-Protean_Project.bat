rem echo I'm processing %lvname%
@echo off
set SAXON_DIR=C:\Saxonica\
set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9ee.jar;%CLASSPATH%
rem set CLASSPATH=%SAXON_DIR%lib\saxon9-sql.jar;%CLASSPATH%

set dita="C:/ProteanCEUI/dita-ot/bin"
REM set AXF_OPT=%cd%\pdf-settings.xml

rem set lang_code=
rem set LV_name=
rem set filter=
setlocal EnableDelayedExpansion
for /f "delims=, tokens=1-3" %%a in (C:/ProteanCEUI/resources/24-TV-KOR/frame.txt) do (
    set lang_code=%%a
    set LV_name=%%b
    set filter=%%c
)

set lang_code=!lang_code!
set LV_name=!LV_name!
set filter=!filter!

echo --------------
echo lang_code: %lang_code%
echo LV_name: %LV_name%
echo filter: %filter%

REM ditaval을 사용할 경우 아래 경로는 변경하세요.
set srcFilter="C:/ProteanCEUI/resources/24-TV-KOR"
set ditavalDIR=%srcFilter%/_filter



rem set fileName="C:/ProteanCEUI/resources/24-TV-KOR/BASIC/000_BN81-25561B-010_EUG_ROPATSCD_KR.ditamap"

rem java net.sf.saxon.Transform  -s:%fileName%  -o:dummy.xml  -xsl:_reference\xsls\00-identity.xsl  lang_code=%lang_code%  LV_name=%LV_name%

set CLASSPATH=
REM ditaval을 사용하지 않을 경우
rem call dita.bat --input=BASIC\NIKATSCT_EM_NIKE_USA.ditamap --format=custpdf_html5 -DLV_name=%lvname%

REM ditaval을 사용할 경우
set fileName="C:/ProteanCEUI/resources/24-TV-KOR/BASIC/BN81-25561B-010_EUG_ROPATSCD_KR.ditamap"

call %dita%/dita.bat  --input=%fileName%  --output=H:/TEST/ddd/23-TV-USA/out  --format=custpdf_html5  -DLV_name=%LV_name%  --args.filter=%ditavalDIR%/%filter%

pause
