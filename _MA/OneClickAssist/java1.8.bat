@echo off
rem set JAVA_HOME=C:\Program Files\Java\openjdk-18.0.1
set JAVA_HOME=.\jre\
set Path=%JAVA_HOME%\bin;%Path%
echo Java 18 activated.
java -version
java -jar oneClickAssist.jar
pause
