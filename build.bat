@echo off
setlocal enabledelayedexpansion
set SCRIPT_DIR=%~dp0
set API_JAR=%SCRIPT_DIR%libs\spigot-api-1.21.8-R0.1-SNAPSHOT.jar
if not exist "%API_JAR%" (
  echo Missing: %API_JAR%
  echo Place the Spigot API JAR (exact or close version) into libs\ and name it spigot-api-1.21.8-R0.1-SNAPSHOT.jar
  exit /b 1
)
echo Compiling with JDK 21...
mkdir "%SCRIPT_DIR%build\classes" 2>nul
dir /b /s "%SCRIPT_DIR%src\*.java" > "%SCRIPT_DIR%build\sources.txt"
javac --release 21 -encoding UTF-8 -cp "%API_JAR%" -d "%SCRIPT_DIR%build\classes" @"%SCRIPT_DIR%build\sources.txt"
echo Creating JAR...
pushd "%SCRIPT_DIR%build\classes"
jar --create --file "..\StackMod-Spigot-1.21.8.jar" -C . .
popd
jar --update --file "%SCRIPT_DIR%build\StackMod-Spigot-1.21.8.jar" -C "%SCRIPT_DIR%" plugin.yml
echo Done: %SCRIPT_DIR%build\StackMod-Spigot-1.21.8.jar
