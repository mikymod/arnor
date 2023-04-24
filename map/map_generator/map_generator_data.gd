class_name MapGeneratorData
extends Node

var paths: Array[PackedInt64Array] = []
var nodes: Dictionary = {} # <PackedInt64Array, Vector2>

func set_paths(paths: Array[PackedInt64Array], points: Array[Vector2]) -> void:
	self.paths = paths
	
	for path in paths:
		for id in path:
			nodes[id] = points[id]
