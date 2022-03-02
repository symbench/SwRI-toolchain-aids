:load /NewDeploy/docker/configDB.groovy
:remote close
:remote connect tinkerpop.server conf/remote.yaml
:remote console
:remote config timeout 250000
g.io('/opt/janusgraph/corpus/all_schema_uam.graphml').with(IO.reader, IO.graphml).read().iterate()
g.V().count()
