
:remote connect tinkerpop.server conf/remote.yaml session
:remote console
:remote config timeout 2500000
g.V().drop()


import org.janusgraph.core.Cardinality

println "\n\n-------------------------------Loading Vertex Scheme -----------------\n"

mgmt = graph.openManagement()
[
    'EXTERNAL',
    'BLANK',
    'CHARS',
    'COMMENT',
    'description',
    '[]',
    '[]AnalysisConstruct',
    '[]AssignedValue',
    '[]Author',
    '[]Classifications',
    '[]ComponentInstance',
    '[]CompoundProperty',
    '[]Connector',
    '[]ConnectorFeature',
    '[]ConnectorInstance',
    '[]Container',
    '[]ContainerFeature',
    '[]DataSource',
    '[]DataType',
    '[]Datum',
    '[]DatumName',
    '[]Default',
    '[]DefaultJoin',
    '[]Definition',
    '[]DimensionType',
    '[]Dimensions',
    '[]DistributionRestriction',
    '[]DomainFeature',
    '[]DomainMapping',
    '[]DomainModel',
    '[]Enum',
    '[]Format',
    '[]Formula',
    '[]Hash',
    '[]JoinData',
    '[]Locator',
    '[]Maximum',
    '[]Mean',
    '[]Metric',
    '[]Minimum',
    '[]ModelMetric',
    '[]Name',
    '[]Operand',
    '[]Parameter',
    '[]Path',
    '[]Port',
    '[]PortInstance',
    '[]PrimitiveProperty',
    '[]PrimitivePropertyInstance',
    '[]Property',
    '[]Resource',
    '[]ResourceDependency',
    '[]Role',
    '[]RootContainer',
    '[]SchemaVersion',
    '[]Settings',
    '[]StandardDeviation',
    '[]Supercedes',
    '[]Supersedes',
    '[]SurfaceReverseMap',
    '[]Task',
    '[]TestComponent',
    '[]TestInjectionPoint',
    '[]TestStructure',
    '[]TopLevelSystemUnderTest',
    '[]Unit',
    '[]Value',
    '[]ValueExpression',
    '[]ValueFlowMux',
    '[]Version',
    '[]Workflow',
    '[avm]Component',
    '[avm]Design',
].forEach {labelName ->
    if (!mgmt.containsVertexLabel(labelName)) {
        mgmt.makeVertexLabel(labelName).make()
    }
}
mgmt.commit()

mgmt = graph.openManagement()
['inside', 'root'].forEach {labelName ->
    if (!mgmt.containsEdgeLabel(labelName)) {
        mgmt.makeEdgeLabel(labelName).multiplicity(MANY2ONE).make()
    }
}
mgmt.commit()

println "\n\n-------------------------------Loading Edge Scheme -----------------\n"

mgmt = graph.openManagement()
[
    'apply_join_data',
    'assembly_root_component_instance',
    'component_id',
    'component_instance',
    'connector_composition',
    'connector_instance',
    'design_id',
    'from_resource',
    'id_in_component_model',
    'id_in_source_model',
    'operand',
    'port_map',
    'property_instance',
    'source',
    'uses_resource',
	'copy',
	'clone',
    'value_source',
].forEach {labelName ->
    if (!mgmt.containsEdgeLabel(labelName)) {
        mgmt.makeEdgeLabel(labelName).multiplicity(MULTI).make()
    }
}
mgmt.commit()

mgmt = graph.openManagement()
[
    'Created_Using_Template',
    'Template_Configuration',
].forEach {propName ->
    if (!mgmt.containsPropertyKey(propName)) {
        mgmt.makePropertyKey(propName).dataType(Boolean.class).cardinality(org.janusgraph.core.Cardinality.SINGLE).make()
    }
}
mgmt.commit()
println "\n\n-------------------------------Loading Property Scheme -----------------\n"
mgmt = graph.openManagement()
[
    '[]Author',
	'VertexLabel',
	'ArrowLabel',
    '[]CName',
    '[]Class',
    '[]DataType',
    '[]DatumName',
    '[]Definition',
    '[]DesignID',
    '[]DimensionType',
    '[]Dimensions',
    '[]Format',
    '[]Hash',
    '[]ID',
    '[]Locator',
    '[]Name',
    '[]Notes',
    '[]OnDataSheet',
    '[]Path',
    '[]SchemaVersion',
    '[]SurfaceReverseMap',
    '[]Unit',
    '[]Version',
    '[]XPosition',
    '[]YPosition',
    '[http://www.w3.org/2001/XMLSchema-instance]type',
    '_partition',
    'description',
    'graph.graphname',
	'value',
	'_tbd_',
	'_duptag_',
    'status',

].forEach {propName ->
    if (!mgmt.containsPropertyKey(propName)) {
        pk = mgmt.makePropertyKey(propName).dataType(String.class).cardinality(org.janusgraph.core.Cardinality.SINGLE).make()
        if(propName == '[]Name') {
			println "\n\n-------------------------------Index idxName -----------------\n"
			mgmt.buildIndex("idxName", Vertex.class).addKey(pk).buildCompositeIndex()
		}
        if(propName == '[]ID') {
			println "\n\n-------------------------------Index idxID -----------------\n"
			mgmt.buildIndex("idxID", Vertex.class).addKey(pk).buildCompositeIndex()
		}
        if(propName == 'VertexLabel') {
			println "\n\n-------------------------------Index idxLabel -----------------\n"
			mgmt.buildIndex("idxLabel", Vertex.class).addKey(pk).buildCompositeIndex()
		}
        if(propName == '_duptag_') {
			println "\n\n-------------------------------Index idxduptag -----------------\n"
			mgmt.buildIndex("idxduptag", Vertex.class).addKey(pk).buildCompositeIndex()
		}
        if(propName == '_tbd_') {
			println "\n\n-------------------------------Index idxtbdtag -----------------\n"
			mgmt.buildIndex("idxtbdtag", Vertex.class).addKey(pk).buildCompositeIndex()
		}
		if(propName == '_partition') {
			println "\n\n-------------------------------Index idxtbdtag -----------------\n"
			mgmt.buildIndex("idxpartition", Vertex.class).addKey(pk).buildCompositeIndex()
		}
    }
}

mgmt.commit()

println "\n\n-------------------------------Wait for the indices-----------------\n"

mgmt = graph.openManagement()

print "-------------------------- Await registered---------------------------------\n"

print ".......................... Yeah,,,,,No ---------------------------------\n"
//:remote config timeout 9999999
//ManagementSystem.awaitGraphIndexStatus(graph, 'idxName').call()
// ManagementSystem.awaitGraphIndexStatus(graph, 'idxID').call()
//ManagementSystem.awaitGraphIndexStatus(graph, 'idxLabel').call()
// ManagementSystem.awaitGraphIndexStatus(graph, 'idxduptag').call()

mgmt.commit()

mgmt = graph.openManagement()
mgmt.printIndexes()
mgmt.commit()

mgmt = graph.openManagement()
mgmt.printSchema()
mgmt.commit()

print "-------------------------- Read Corpus ---------------------------------\n"

// g.with('evaluationTimeout',86500).io('/opt/janusgraph/corpus/all_schema_UAV.graphml').with(IO.reader, IO.graphml).read().iterate()
// g.tx().commit()
print "-------------------------- Read Corpus Complete  ---------------------------------\n"
print "-------------------------- g.tx().commit()  ---------------------------------\n"
// g.tx().commit()
print "-------------------------- schema/index/load Complete  ---------------------------------\n"
print "-------------------------- schema/index/load Complete  ---------------------------------\n"
print "-------------------------- schema/index/load Complete  ---------------------------------\n"

:remote console
