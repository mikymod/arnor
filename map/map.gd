extends Node2D

@export var map_node_scene: PackedScene = preload("res://map/map_node.tscn")
@export var map_scale = 20.0

var nodes = {}

func _ready() -> void:
	var generator = MapGenerator.new()
	var map_data: MapData = generator.generate(40, 15, 5)
	
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
