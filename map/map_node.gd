class_name MapNode
extends Node2D

enum NodeType { COMBAT, MARKET, MINIBOSS, PUZZLE, REST, STORY }

@export var map_events: MapEvents
@export var nodes_dict: Dictionary = {
	NodeType.COMBAT: {
		'texture': preload("res://map/textures/combat.png"),
		'probability': 0.8,
	},
	NodeType.MARKET: {
		'texture': preload("res://map/textures/market.png"),
		'probability': 0.3,
	},
	NodeType.MINIBOSS: {
		'texture': preload("res://map/textures/miniboss.png"),
		'probability': 0.1,
	},
	NodeType.PUZZLE: {
		'texture': preload("res://map/textures/puzzle.png"),
		'probability': 0.2,
	},
	NodeType.REST: {
		'texture': preload("res://map/textures/rest.png"),
		'probability': 0.2,
	},
	NodeType.STORY: {
		'texture': preload("res://map/textures/story.png"),
		'probability': 0.2,
	},
}

var children: Array[MapNode] = []
const margin = 10
var _highlight: bool = false

func _ready() -> void:
	var type = nodes_dict[randi_range(0, len(NodeType) - 1)]
	$Sprite2D.texture = type['texture']

func add_child_node(child):
	if !children.has(child):
		children.append(child)

func set_highlight(value: bool) -> void:
	_highlight = value

func _process(delta: float) -> void:
	if (_highlight):
		scale = Vector2(1.5, 1.5)
	else:
		scale = Vector2(1, 1)

func _on_area_2d_mouse_entered():
	map_events.map_node_highlight.emit(self)
