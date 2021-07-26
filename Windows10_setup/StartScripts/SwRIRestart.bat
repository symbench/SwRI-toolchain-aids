REM This script will restart the SwRI Tools
@echo off

START C:\StartScripts\01restartJenkins.bat
:WAIT_JENKINS
netstat -q -n -p TCP | find ":8080" >nul 2>nul
if %ERRORLEVEL% neq 0 goto WAIT_JENKINS
ping 127.0.0.1 -n 10 > nul

START C:\StartScripts\02restartJanusgraph.bat
TIMEOUT /T 30 /nobreak > nul

START C:\StartScripts\03loadJanusgraph.bat

TIMEOUT /T 60 /nobreak > nul
START C:\StartScripts\04startBigHoss

START C:\StartScripts\05openJenkins.bat

START C:\StartScripts\06restartMinioDocker.bat
