class_name MapData
extends Node

var paths: Array[PackedInt64Array] = []
var nodes: Dictionary = {} # <int, MapNodeData>

func set_paths(paths: Array[PackedInt64Array], points: Array[Vector2]) -> void:
	self.paths = paths
	for path in paths:
		for id in path:
			var node = MapNodeData.new()
			node.position = points[id]
			nodes[id] = node

func serialize() -> Dictionary:
	var nodes_array: Array[Dictionary] = []
	for key in nodes:
		var serialized_node: Dictionary = nodes[key].serialize()
		nodes_array.append(serialized_node)
		
	var dict: Dictionary = {
		"paths": paths,
		"nodes": nodes_array
	}
	return dict

func save() -> void:
	var serialized: Dictionary = serialize()
	var json_string: String = JSON.stringify(serialized)
	var map_file = FileAccess.open("user://current_map.save", FileAccess.WRITE)
	map_file.store_line(json_string)

func load() -> void:
	# TODO: load data from file
	pass

