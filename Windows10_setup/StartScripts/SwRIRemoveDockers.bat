REM This script will remove the SwRI Tool Dockers (so a fresh start is possible)
@echo off

START C:\StartScripts\01removeJenkins.bat
START C:\StartScripts\02removeJanusgraph.bat
START C:\StartScripts\06removeMinioDocker.bat

CMD /c "docker volume prune -f"
