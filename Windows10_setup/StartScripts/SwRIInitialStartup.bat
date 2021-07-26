REM This script will build and start the SwRI Tools (building up the docker images)
REM You must wait for the docker desktop to start before running this script
@echo off

START C:\StartScripts\01startJenkins.bat
:WAIT_JENKINS
netstat -q -n -p TCP | find ":8080" >nul 2>nul
if %ERRORLEVEL% neq 0 goto WAIT_JENKINS
ping 127.0.0.1 -n 10 > nul

START C:\StartScripts\02startJanusgraph.bat
TIMEOUT /T 60 /nobreak > nul

START C:\StartScripts\03loadJanusgraph.bat

TIMEOUT /T 60 /nobreak > nul
START C:\StartScripts\04startBigHoss

START C:\StartScripts\05openJenkins.bat

START C:\StartScripts\06createMinioDocker.bat
