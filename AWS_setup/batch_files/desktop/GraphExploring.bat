@echo off

START C:\tmp\graphData\01startJanus.bat

:WAIT_JANUS
netstat -q -n -p TCP | find ":8182" >nul 2>nul
if %ERRORLEVEL% neq 0 goto WAIT_JANUS

ping 127.0.0.1 -n 15 > nul
START C:\tmp\graphData\10startGremlin.bat
ping 127.0.0.1 -n 10 > nul

WAIT_GRAPH_VISUALIZER
START C:\tmp\graphData\11startGraphVisualizer.bat
ping 127.0.0.1 -n 20 > nul
netstat -q -n -p TCP | find ":3000" >nul 2>nul
if %ERRORLEVEL% neq 0 goto WAIT_GRAPH_VISUALIZER

REM: The initial graph query to see the whole graph is 'g.E().hasLabel('root').bothV()
REM: Select a node and 'Traverse In Edges' to go down a level
REM: Typically change Settings for the node labels based on the node information 
REM: (found under 'Information: Node') to '[]Names', if available
