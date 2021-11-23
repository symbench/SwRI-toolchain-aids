REM This script will restart the SwRI Tools
@echo off

START C:\StartScripts\03loadJanusgraph.bat

TIMEOUT /T 60 /nobreak > nul
START C:\StartScripts\04startBigHoss

START C:\StartScripts\05openJenkins.bat

