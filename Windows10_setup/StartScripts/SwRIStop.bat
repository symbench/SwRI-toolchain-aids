REM This script will stop the SwRI Tools
@echo off

START C:\StartScripts\01stopJenkins.bat
START C:\StartScripts\02stopJanusgraph.bat
START C:\StartScripts\06stopMinioDocker.bat
