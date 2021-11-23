echo on
echo LOAD GRAPH ...
set wfsdir=%CD%
set wsdir=%wfsdir:\=\\%
set wbsdir=%wfsdir:\=/%
pushd "C:\jwork\Agents\janusgraph\bin"
cmd /k gremlin.bat --verbose -i %WFSDIR%\..\..\StartScripts\load_UAV_graph.groovy
popd
echo GRAPH LOAD COMPLETE
