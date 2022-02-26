echo on
echo LOAD GRAPH ...
pushd "C:\JWork\Agents\janusgraph\bin"
cmd /k gremlin.bat --verbose -i "C:\StartScripts\load_uam_graph.groovy"
popd
echo GRAPH LOAD COMPLETE
