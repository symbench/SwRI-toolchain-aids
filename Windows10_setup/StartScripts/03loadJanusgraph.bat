echo on
echo LOAD GRAPH ...
CMD /c "copy /y /v C:\jwork\Agents\uam-uav-models\ExportedGraphML\*.graphml C:\NewDeploy\graph_ml\."
CMD /c "C:\NewDeploy\docker\upload_corpus.bat"
echo UPLOADED GRAPH TO jce-jg DOCKER
pushd "C:\jwork\Agents\janusgraph\bin"
CMD /k gremlin.bat -i C:\StartScripts\load_all_graph.groovy --verbose 
popd
echo GRAPH LOAD COMPLETE
