class_name MapData
extends Node

var paths: Array[PackedInt64Array] = []
var nodes: Dictionary = {}

func _init(paths: Array[PackedInt64Array], nodes: Dictionary):
	self.paths = paths
	self.nodes = nodes

func to_json() -> Dictionary:
	var dict: Dictionary = {
		"paths": var_to_str(paths),
		"nodes": var_to_str(nodes)
	}
	
	return dict

static func from_json(dict: Dictionary) -> MapData:
	var paths = str_to_var(dict["paths"])
	var nodes = str_to_var(dict["nodes"])
	return MapData.new(paths, nodes)

func save() -> void:
	var serialized: Dictionary = self.to_json()
	var json_string: String = JSON.stringify(serialized)
	var map_file = FileAccess.open("user://current_map.save", FileAccess.WRITE)
	map_file.store_line(json_string)

func load() -> void:
	# TODO: load data from file
	pass

