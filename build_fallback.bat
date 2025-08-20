@echo off
setlocal enabledelayedexpansion
set "SCRIPT_DIR=%~dp0"
set "API_JAR=%SCRIPT_DIR%libs\spigot-api-1.21.8-R0.1-SNAPSHOT.jar"
set "OUT_JAR=%SCRIPT_DIR%build\StackMod-Spigot-1.21.8.jar"

rem --- Checks ---
if not exist "%API_JAR%" (
  echo [ERROR] Spigot-API nicht gefunden: "%API_JAR%"
  echo        Lege die API-JAR in libs\ und nenne sie spigot-api-1.21.8-R0.1-SNAPSHOT.jar
  exit /b 1
)

echo [1/3] Kompiliere mit JDK 21...
mkdir "%SCRIPT_DIR%build\classes" 2>nul
dir /b /s "%SCRIPT_DIR%src\*.java" > "%SCRIPT_DIR%build\sources.txt"
javac --release 21 -encoding UTF-8 -cp "%API_JAR%" -d "%SCRIPT_DIR%build\classes" @"%SCRIPT_DIR%build\sources.txt" || exit /b 1

echo [2/3] Bereite Inhalte fuer das JAR vor...
copy /y "%SCRIPT_DIR%plugin.yml" "%SCRIPT_DIR%build\classes\plugin.yml" >nul

echo [3/3] Erzeuge Plugin-JAR...
where jar >nul 2>&1
if %errorlevel%==0 (
  echo    jar.exe gefunden – verwende jar
  pushd "%SCRIPT_DIR%build\classes"
  jar --create --file "..\StackMod-Spigot-1.21.8.jar" -C . .
  popd
) else (
  echo    jar.exe NICHT gefunden – weiche auf PowerShell Compress-Archive aus
  powershell -NoProfile -Command ^
    "$ErrorActionPreference='Stop';" ^
    "$out = '%OUT_JAR%';" ^
    "$zip = [System.IO.Path]::ChangeExtension($out,'zip');" ^
    "if (Test-Path $zip) { Remove-Item $zip -Force };" ^
    "Compress-Archive -Path '%SCRIPT_DIR%build\classes\*' -DestinationPath $zip -Force;" ^
    "if (Test-Path $out) { Remove-Item $out -Force };" ^
    "Rename-Item -Path $zip -NewName (Split-Path -Leaf $out);"
)
