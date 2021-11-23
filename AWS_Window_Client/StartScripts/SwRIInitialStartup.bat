REM This script will build and start the SwRI Tools (building up the docker images)
REM You must wait for the docker desktop to start before running this script
@echo off

:WAIT_JENKINS
netstat -q -n -p TCP | find "<linux server ip>:8080" >nul 2>nul
if %ERRORLEVEL% neq 0 goto WAIT_JENKINS
ping <linux server ip> -n 10 > nul

START C:\StartScripts\03loadJanusgraph.bat

TIMEOUT /T 60 /nobreak > nul
START C:\StartScripts\04startBigHoss

START C:\StartScripts\05openJenkins.bat