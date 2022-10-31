echo on
echo LOAD GRAPH ...
pushd "C:\jwork\Agents"
CMD /c "python .\workspace\UAM_Workflows\ModelAuthoring\runComponentTest.py localhost .\uam-uav-models\ACM\ .\symcps-mapper\ --adm .\uam-uav-models\ADM\ --graphml .\uam-uav-models\.tmp --clear"
pushd "C:\jwork\Agents\janusgraph\bin"
CMD /k gremlin.bat --verbose -i C:\StartScripts\load_gremlin_connect.groovy
popd
echo GRAPH LOAD COMPLETE
