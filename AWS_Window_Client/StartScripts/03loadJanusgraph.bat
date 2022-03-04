echo on
echo LOAD GRAPH ...
set wfsdir=%CD%
pushd "C:\JWork\Agents\janusgraph\bin"
cmd /k gremlin.bat --verbose -i %WFSDIR%\..\..\StartScripts\load_uam_graph.groovy
popd
echo GRAPH LOAD COMPLETE
