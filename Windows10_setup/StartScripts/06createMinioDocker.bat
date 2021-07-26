echo STARTING MINIO SERVER ...
CMD /c "docker run -d --name minio-server -p 9000:9000 -p 9001:9001 -v c:\NewDeploy\minioData:/data --env MINIO_ACCESS_KEY="symcps" --env MINIO_SECRET_KEY="symcps2021" minio/minio server /data --console-address ":9001""
CMD /c "docker start minio-server"
echo MINIO SERVER STARTED
