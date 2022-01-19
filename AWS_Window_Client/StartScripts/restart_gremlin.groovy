:remote connect tinkerpop.server conf/remote.yaml
:remote console
:remote config timeout 120000
g.V().count()
