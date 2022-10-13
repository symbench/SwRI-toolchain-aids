REM This script will build and start the SwRI Tools (building up the docker images)
REM You must wait for the docker desktop to start before running this script
@echo off

TIMEOUT /T 60 /nobreak > nul
START C:\StartScripts\04startBigHoss

START C:\StartScripts\05openJenkins.bat

START C:\StartScripts\03symMapper.bat

START C:\StartScripts\03loadJanusgraph.bat
