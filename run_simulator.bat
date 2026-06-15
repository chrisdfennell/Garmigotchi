@echo off
echo Building and running Tamawatchi in the Garmin simulator...
powershell -ExecutionPolicy Bypass -File "%~dp0build.ps1" -Device fenix7 -Run
pause
