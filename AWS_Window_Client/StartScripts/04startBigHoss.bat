echo STARTING BIG HOSS ...
CD "Downloads\"
echo Need to manually start agent by open "C:\StartScripts\jenkins-agents"
echo by using the Java Web Start Launcher
java -jar "C:\StartScripts\jenkins-agent\agent.jar" -jnlpUrl http://<linux server IP>:8080/computer/BigHoss/jenkins-agent.jnlp -secret <insert secret key> -workDir "C:\jwork\agents"
echo BIG HOSS STARTED
