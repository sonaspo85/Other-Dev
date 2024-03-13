@echo off
set JAVA_HOME=C:\Program Files\Java\openjdk-18.0.1
set Path=%JAVA_HOME%\bin;%Path%
echo Java 18 activated.
java -version
java -jar SEA_converter.jar
pause