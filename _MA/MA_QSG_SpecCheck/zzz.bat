@echo off
set JAVA_HOME=%cd%\jre
rem set JAVA_HOME=C:\Program Files\Java\openjdk-18.0.1
set Path=%JAVA_HOME%\bin;%Path%
echo Java 1.8 activated.
java -version

java -jar SpecChecker-5.3.2.jar
pause
