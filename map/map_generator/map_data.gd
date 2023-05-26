class_name MapData
extends Node

var paths: Array[PackedInt64Array] = []
var nodes: Dictionary = {} # <int, MapNodeData>

func _init(paths: Array[PackedInt64Array], nodes: Array[MapNodeData]):
	self.paths = paths
	for path in paths:
		for id in path:
			self.nodes[id] = nodes[id]
	pass

func to_json() -> Dictionary:
	var nodes_array = []
	for key in nodes:
		var map_node_json = nodes[key].to_json()
		nodes_array.append(map_node_json)
		
	var dict: Dictionary = {
		"paths": var_to_str(paths),
		"nodes": nodes_array
	}
	return dict

static func from_json(dict: Dictionary) -> MapData:
	var nodes: Array[MapNodeData]
	var paths = str_to_var(dict["paths"])
	for node_dict in str_to_var(dict["nodes"]):
		var map_node_data = MapNodeData.from_json(node_dict)
		nodes.push_back(map_node_data)
	return MapData.new(paths, nodes)

func save() -> void:
	var serialized: Dictionary = self.to_json()
	var json_string: String = JSON.stringify(serialized)
	var map_file = FileAccess.open("user://current_map.save", FileAccess.WRITE)
	map_file.store_line(json_string)

func load() -> void:
	# TODO: load data from file
	pass

