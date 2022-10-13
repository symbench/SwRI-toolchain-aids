:load /StartScripts/configDB.groovy
:remote close
:remote connect tinkerpop.server conf/remote.yaml
:remote console
:remote config timeout 25000000
g.io('/opt/janusgraph/corpus/all_schema.graphml').with(IO.reader, IO.graphml).read().iterate()
g.V().count()
