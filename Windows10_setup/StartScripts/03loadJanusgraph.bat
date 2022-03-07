echo on
echo LOAD GRAPH ...
set wfsdir=%CD%
set wsdir=%wfsdir:\=\\%
set wbsdir=%wfsdir:\=/%
CMD /c "copy /y /v C:\jwork\Agents\workspace\UAM_Workflows\ExportedGraphML\*.graphml C:\NewDeploy\graph_ml\."
CMD /c "C:\NewDeploy\docker\upload_corpus.bat"
echo UPLOADED GRAPH TO jce-jg DOCKER
pushd "C:\jwork\Agents\janusgraph\bin"
CMD /k gremlin.bat --verbose -i %WFSDIR%\..\..\StartScripts\load_UAV_graph.groovy
popd
echo GRAPH LOAD COMPLETE
