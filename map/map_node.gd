class_name MapNode
extends Node2D

enum NodeType { COMBAT, MARKET, MINIBOSS, PUZZLE, REST, STORY }

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

var children: Array[Node] = []
const margin = 10

func _ready() -> void:
	var type = nodes_dict[randi_range(0, len(NodeType) - 1)]
	$Sprite2D.texture = type['texture']

func add_child_node(child):
	if !children.has(child):
		children.append(child)
		queue_redraw()

func _draw():
	draw_circle(Vector2.ZERO, 4, Color.WHITE_SMOKE)
	
	for child in children:
		var line = child.position - position
		var normal = line.normalized()
		line -= margin * normal
		var color = Color.GRAY
		draw_line(normal * margin, line, color, 2, true)

