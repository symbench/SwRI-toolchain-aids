@echo off

START C:\tmp\graphData\01startJanus.bat

:WAIT_JANUS
netstat -q -n -p TCP | find ":8182" >nul 2>nul
if %ERRORLEVEL% neq 0 goto WAIT_JANUS

START C:\tmp\graphData\02startJenkins.bat

:WAIT_JENKINS
netstat -q -n -p TCP | find ":8080" >nul 2>nul
if %ERRORLEVEL% neq 0 goto WAIT_JENKINS
ping 127.0.0.1 -n 10 > nul

START C:\tmp\graphData\03startJenkinsAgent.bat
ping 127.0.0.1 -n 10 > nul

CD "C:\tmp\graphData"
PUSHD gc\bin
CMD /c gremlin.bat --verbose -i C:/tmp/graphData/Scripts/loadGraphData.groovy
POPD
ping 127.0.0.1 -n 6 > nul

START "" http://localhost:8080