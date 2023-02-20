echo on
echo LOAD GRAPH ...
pushd "C:\jwork\Agents"
CMD /c "python .\workspace\UAM_Workflows\ModelAuthoring\runComponentTest.py <IP ADDRESS> .\uam-uav-models\ACM\ .\symcps-mapper\ --adm .\uam-uav-models\ADM\ --graphml .\uam-uav-models\.tmp --clear"
pushd "C:\JWork\Agents\janusgraph\bin"
cmd /k gremlin.bat --verbose -i C:\StartScripts\restart_gremlin.groovy
popd
echo GRAPH LOAD COMPLETE
