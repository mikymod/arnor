extends Node2D

@export var map_events: MapEvents
@export var map_node_scene: PackedScene = preload("res://map/map_node.tscn")
@export var map_scale = 20.0

var nodes = {}
var _current_map_node: MapNode = null

func _ready() -> void:
	map_events.map_node_highlight.connect(_on_map_node_highlight)
	map_events.map_node_selected.connect(_on_map_node_selected)
	map_events.map_node_completed.connect(_on_map_node_completed)
	var generator = MapGenerator.new()
	var map_data: MapGeneratorData = generator.generate(50, 15, 5)
	
	for k in map_data.nodes.keys():
		var point = map_data.nodes[k]
		var node = map_node_scene.instantiate()
		node.position = point * map_scale + Vector2(200, 0)
		add_child(node)
		nodes[k] = node 

	for path in map_data.paths:
		for i in range(path.size() - 1):
			var index1 = path[i]
			var index2 = path[i + 1]
			nodes[index1].add_child_node(nodes[index2])
	
	nodes[0].set_selectable(true)

func _on_map_node_highlight(map_node: MapNode) -> void:
	for node in nodes.values():
		node.set_highlight(false)
	map_node.set_highlight(true)

func _on_map_node_selected(map_node: MapNode) -> void:
	print("Change scene %s" % map_node)
	var level = map_node.scene().instantiate()
	SceneManager.push_scene(level)
	_current_map_node = map_node

func _on_map_node_completed() -> void:
	_current_map_node.completed = true
	for node in nodes.values():
		node.set_selectable(false)
	for child in _current_map_node.children:
		child.set_selectable(true)

func _draw() -> void:
	# draw paths
	for node in nodes.values():
		var children = node.children
		for child in children:
			draw_line(node.position, child.position, Color.GRAY, 2, true)
