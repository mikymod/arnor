class_name MapNodeData
extends Node

enum MapNodeType { encounter, market, miniboss, rest, boss }

var position: Vector2 = Vector2.ZERO
var type: MapNodeType = MapNodeType.encounter
var completed: bool = false

func to_json() -> Dictionary:
	return {
		"position": var_to_str(position),
		"type": type,
		"completed": completed,
	}

static func from_json(dict: Dictionary) -> MapNodeData:
	var map_node_data = MapNodeData.new()
	var tmp = dict["position"]
	map_node_data.position = str_to_var(tmp)
	map_node_data.type = dict["type"]
	map_node_data.completed = dict["completed"]
	return map_node_data
	
