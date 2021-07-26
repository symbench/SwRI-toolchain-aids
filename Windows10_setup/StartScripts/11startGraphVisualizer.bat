
echo STARTING GREMLIN-VISUALIZER ...
cd "C:\Tools\gremlin-visualizer"
cmd /c npm start
:WAIT_GREMLIN_VIZ
netstat -q -n -p TCP | find ":3000" >nul 2>nul
if %ERRORLEVEL% neq 0 goto WAIT_GREMLIN_VIZ
ping 127.0.0.1 -n 10 > nul
START "" http://localhost:3000
REM TO start looking at graph, use gremlin query: g.V().hasLabel('[avm]Design')
