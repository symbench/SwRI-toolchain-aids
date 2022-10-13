echo on
echo LOAD GRAPH ...
pushd "C:\JWork\Agents\janusgraph\bin"
cmd /k gremlin.bat --verbose -i C:\StartScripts\load_all_graph.groovy
popd
echo GRAPH LOAD COMPLETE
