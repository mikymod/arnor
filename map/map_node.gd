class_name MapNode
extends Node2D

enum NodeType { COMBAT, MARKET, MINIBOSS, PUZZLE, REST, STORY }

@export var map_events: MapEvents
@export var nodes_dict: Dictionary = {
	NodeType.COMBAT: {
		'texture': preload("res://map/textures/combat.png"),
		'scene': preload("res://levels/cards_playground.tscn"),
		'probability': 0.8,
	},
	NodeType.MARKET: {
		'texture': preload("res://map/textures/market.png"),
		'scene': preload("res://levels/cards_playground.tscn"),
		'probability': 0.3,
	},
	NodeType.MINIBOSS: {
		'texture': preload("res://map/textures/miniboss.png"),
		'scene': preload("res://levels/cards_playground.tscn"),
		'probability': 0.1,
	},
	NodeType.PUZZLE: {
		'texture': preload("res://map/textures/puzzle.png"),
		'scene': preload("res://levels/cards_playground.tscn"),
		'probability': 0.2,
	},
	NodeType.REST: {
		'texture': preload("res://map/textures/rest.png"),
		'scene': preload("res://levels/cards_playground.tscn"),
		'probability': 0.2,
	},
	NodeType.STORY: {
		'texture': preload("res://map/textures/story.png"),
		'scene': preload("res://levels/cards_playground.tscn"),
		'probability': 0.2,
	},
}

var type: NodeType
var children: Array[MapNode] = []
const margin: int = 10
var _highlight: bool = false
var _selectable: bool = false

func scene() -> Resource:
	return nodes_dict[type]['scene']

func add_child_node(child):
	if !children.has(child):
		children.append(child)

func set_selectable(value: bool) -> void:
	_selectable = value

func set_highlight(value: bool) -> void:
	_highlight = value

func _ready() -> void:
	type = randi_range(0, len(NodeType) - 1)
	$Sprite2D.texture = nodes_dict[type]['texture']

func _process(delta: float) -> void:
	if (_highlight && _selectable):
		scale = Vector2(1.5, 1.5)
	else:
		scale = Vector2(1, 1)

func _on_area_2d_mouse_entered():
	map_events.map_node_highlight.emit(self)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if (!_highlight): return
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			map_events.map_node_selected.emit(self)
