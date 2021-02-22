Title "Interactive Gremlin Session"
cd "C:\tmp\graphData"
pushd gc\bin
cmd /k gremlin.bat --verbose -i C:/tmp/graphData/Scripts/10-loadGraphData.groovy 
popd