extends Node2D

@export var map_events: MapEvents
@export var map_node_scene: PackedScene = preload("res://map/map_node/map_node.tscn")
@export var map_scale = 20.0

@export var encounter_resource: MapNodeResource = preload("res://map/map_node/resources/encounter.tres")
@export var market_resource: MapNodeResource = preload("res://map/map_node/resources/market.tres")
@export var rest_resource: MapNodeResource = preload("res://map/map_node/resources/rest.tres")
@export var miniboss_resource: MapNodeResource = preload("res://map/map_node/resources/miniboss.tres")

var nodes: Dictionary = {}
var _current_map_node: MapNode = null

func _ready() -> void:
	map_events.map_node_selected.connect(_on_map_node_selected)
	
	var generator = MapGenerator.new()
	var map_data: MapData = generator.create(50, 15, 5)
	map_data.save()
	var tmp: MapData = generator.create_from_file("user://current_map.save")
	var map_node_resources = _random_map_node_resources(map_data.nodes.size())
	
	for k in map_data.nodes.keys():
		var map_node_data = map_data.nodes[k]
		var map_node = map_node_scene.instantiate()
#		map_node.position = map_node_data.position * map_scale + Vector2(200, 0)
		map_node.map_node_data = map_node_data
		map_node.map_node_resource = map_node_resources.pop_front()
		add_child(map_node)
		nodes[k] = map_node 

	for path in map_data.paths:
		for i in range(path.size() - 1):
			var index1 = path[i]
			var index2 = path[i + 1]
			nodes[index1].add_child_node(nodes[index2])
	
	nodes[0].selectable = true

func _random_map_node_resources(num_nodes: int) -> Array[MapNodeResource]:
	var result: Array[MapNodeResource] = []
	for i in num_nodes:
		var value = randi_range(0, 100)
		if value > 90 && value <= 95:
			result.append(rest_resource)
		elif value > 95 && value <= 100:
			result.append(market_resource)
		else:
			result.append(encounter_resource)
	
	if not result.any(contains_any_market):
		print('Do not contain market')
	if not result.any(contains_any_rest):
		print('Do not contain rest')
		
	return result

func contains_any_market(map_node_resource: MapNodeResource):
	return map_node_resource == market_resource

func contains_any_rest(map_node_resource: MapNodeResource):
	return map_node_resource == rest_resource

func _on_map_node_selected(map_node: MapNode) -> void:
	print("Change scene %s" % map_node)
	var level = map_node.scene().instantiate()
	SceneManager.push_scene(level)
	_current_map_node = map_node

	_current_map_node.complete()
	for node in nodes.values():
		node.selectable = false
	for child in _current_map_node.children:
		child.selectable = true

func _draw() -> void:
	# draw paths
	for node in nodes.values():
		var children = node.children
		for child in children:
			draw_line(node.position, child.position, Color.GRAY, 2, true)
