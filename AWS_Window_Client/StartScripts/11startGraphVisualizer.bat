
echo STARTING GREMLIN-VISUALIZER ...
CD /D "C:\gremlin-visualizer"
cmd /c npm start
TIMEOUT /T 60 /nobreak > nul
START "" http://localhost:3000
REM TO start looking at graph, use gremlin query: g.V().has('VertexLabel','[avm]Design')
