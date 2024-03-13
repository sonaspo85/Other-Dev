@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\

set JAVA_HOME=.\jre
@REM set JAVA_HOME=%ScriptDir%\functions\openjdk18
set Path=%JAVA_HOME%\bin;%Path%
echo Java 1.8 activated.
java -version

java -jar "H:/Dev_tool/_MA/Satisfy-Tool/satisfyTool.jar"


pause
