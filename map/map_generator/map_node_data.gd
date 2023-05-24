class_name MapNodeData
extends Node

enum MapNodeType { encounter, market, miniboss, rest, boss }

var position: Vector2 = Vector2.ZERO
var type: MapNodeType = MapNodeType.encounter
var completed: bool = false

func serialize() -> Dictionary:
	return {
		"position": position,
		"type": type,
		"completed": completed,
	}
