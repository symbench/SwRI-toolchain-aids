echo REPLACING SERVER IP ADDRESS
echo From: %AWS_AMI_SERVER_IP%
echo To: %1

sed -i "s/%AWS_AMI_SERVER_IP%/%1/g" C:\StartScripts\05openJenkins.bat
sed -i "s/%AWS_AMI_SERVER_IP%/%1/g" C:\StartScripts\04startBigHoss.bat
sed -i "s/%AWS_AMI_SERVER_IP%/%1/g" C:\gremlin-visualizer\package.json
del sed*
