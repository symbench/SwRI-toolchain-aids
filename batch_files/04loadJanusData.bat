cd "C:\tmp\graphData"
pushd gc\bin
cmd /c gremlin.bat --verbose -i C:/tmp/graphData/Scripts/loadGraphData.groovy
popd