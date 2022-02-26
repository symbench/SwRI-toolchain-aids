:load /NewDeploy/docker/configDB.groovy
:remote close
:remote connect tinkerpop.server conf/remote.yaml
:remote console
:remote config timeout 120000
g.io('/opt/janusgraph/mydata/all_schema_uam.graphml').with(IO.reader, IO.graphml).read().iterate()
g.V().count()
