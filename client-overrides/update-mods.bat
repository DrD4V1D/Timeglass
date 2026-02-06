@echo off
setlocal

REM Run from instance directory (Modrinth sets working dir to instance, but we enforce anyway)
cd /d "%~dp0"

REM Nuke mods folder
if exist "mods" rmdir /s /q "mods"

REM Re-sync mods from pack.toml
java -Djava.awt.headless=true ^
  -jar "packwiz-installer-bootstrap.jar" ^
  -g ^
  "https://raw.githubusercontent.com/DrD4V1D/Timeglass/master/pack.toml"

endlocal
exit /b %errorlevel%
