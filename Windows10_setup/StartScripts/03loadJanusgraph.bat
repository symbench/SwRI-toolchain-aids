echo on
echo LOAD GRAPH ...
set wfsdir=%CD%
set wsdir=%wfsdir:\=\\%
set wbsdir=%wfsdir:\=/%
CMD /k "C:\NewDeploy\docker\upload_corpus.bat"
echo UPLOADED GRAPH TO jce-jg DOCKER
pushd "C:\jwork\Agents\janusgraph\bin"
CMD /k gremlin.bat --verbose -i %WFSDIR%\..\..\StartScripts\load_UAV_graph.groovy
popd
echo GRAPH LOAD COMPLETE
