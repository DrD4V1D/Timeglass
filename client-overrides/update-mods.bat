@echo off
setlocal enabledelayedexpansion

REM Move to instance root (parent of client-overrides)
cd /d "%~dp0.."

REM Find Modrinth-bundled Java (pick newest folder under meta\java_versions)
set "JAVA_DIR="
for /f "delims=" %%D in ('dir /b /ad "%APPDATA%\ModrinthApp\meta\java_versions" 2^>nul') do (
  set "JAVA_DIR=%%D"
)

if not defined JAVA_DIR (
  echo ERROR: Could not find Modrinth Java at "%APPDATA%\ModrinthApp\meta\java_versions".
  exit /b 1
)

set "JAVA=%APPDATA%\ModrinthApp\meta\java_versions\%JAVA_DIR%\bin\java.exe"

if not exist "%JAVA%" (
  echo ERROR: Java executable not found: "%JAVA%"
  exit /b 1
)

REM Nuke mods
if exist "mods" rmdir /s /q "mods"

REM Re-sync mods from pack.toml
"%JAVA%" -Djava.awt.headless=true ^
  -jar "client-overrides\packwiz-installer-bootstrap.jar" ^
  -g ^
  "https://raw.githubusercontent.com/DrD4V1D/Timeglass/master/pack.toml"

endlocal
exit /b %errorlevel%
