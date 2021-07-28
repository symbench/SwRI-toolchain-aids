CMD /c "docker stop jce-jg jce-es jce-cql"
CMD /c "docker volume prune -f"
echo STOPPED JANUSGRAPH
