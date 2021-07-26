echo STARTING BIG HOSS ...
CD "Downloads\"
echo Need to manually start agent by open "C:\StartScripts\jenkins-agents"
echo by using the Java Web Start Launcher
java -jar "C:\StartScripts\jenkins-agent\agent.jar" -jnlpUrl http://127.0.0.1:8080/computer/BigHoss/jenkins-agent.jnlp -secret <place secret from Jenkins here> -workDir "C:\jwork\agents"
echo BIG HOSS STARTED
