class_name CardHand
extends Node2D

@export var card_scene: PackedScene = preload("res://card_framework/card/card.tscn")

@export var interpolation_speed: float = 0.1
@export var card_angle: float = 5
@export var card_spacing: float = 200
@export var arc_height: float = 0
@export var peek_x_displacement: float = 100
@export var peek_y_displacement: float = -100

@onready var origin_y = $Origin.global_position.y

var cards: Array[Card] = []

var _hover_queue: Array[Card]
var hovered_card: Card
var hovered_card_index: int = -1

var dragged_card: Card

func _ready() -> void:
	for i in 5:
		add_card()
	_reposition()

func add_card() -> void:
	var new_card = card_scene.instantiate()
	new_card.hover_started.connect(_on_card_hover_started)
	new_card.hover_stopped.connect(_on_card_hover_stopped)
	#new_card.drag_started.connect(_on_card_drag_started)
	#new_card.drag_stopped.connect(_on_card_drag_stopped)
	#new_card.drag_canceled.connect(_on_card_drag_canceled)
	add_child(new_card)
	cards.append(new_card)

func remove_card(card: Card) -> void:
	card.hover_started.disconnect(_on_card_hover_started)
	card.hover_stopped.disconnect(_on_card_hover_stopped)
	#card.drag_started.disconnect(_on_card_drag_started)
	#card.drag_stopped.disconnect(_on_card_drag_stopped)
	#card.drag_canceled.disconnect(_on_card_drag_canceled)
	remove_child(card)
	cards.erase(card)

func _reposition():
	var tween = get_tree().create_tween()
	var positions = _generate_positions()
	for i in range(cards.size()):
		tween.tween_property(cards[i], "position", positions[i], interpolation_speed) 
		cards[i].rotation_degrees = _get_card_angle(i)

func _get_card_x_pos(index: int) -> float:
	var center = $Origin.position
	var num_cards = cards.size()
	var x_displacement = _get_x_displacement(index)
	return (index - num_cards / 2) * card_spacing + position.x + center.x + x_displacement

func _get_card_y_pos(index: int) -> float:
	var center = $Origin.position
	var y_displacement = _get_y_displacement(index)
	return center.y + index * arc_height + y_displacement

func _get_card_angle(index: int) -> float:
	return _get_index_from_center(index) * card_angle

func _get_index_from_center(index: int) -> int:
	var index_from_center: float = index - (cards.size() - 1) / 2
	if (index_from_center < 0):
		index_from_center -= 0.5
	return round(index_from_center)

func _get_x_displacement(index: int) -> float:
	return peek_x_displacement if hovered_card_index >= 0 and index > hovered_card_index else 0

func _get_y_displacement(index: int) -> float:
	return peek_y_displacement if index == hovered_card_index else 0

func _generate_positions() -> Array:
	var positions = []
	for i in range(cards.size()):
		var pos_x = _get_card_x_pos(i)
		var pos_y = _get_card_y_pos(i)
		positions.append(Vector2(pos_x, pos_y))
	return positions

func _on_card_hover_started(card: Card) -> void:
	_hover_queue.append(card)
	_set_hovered_card()
	_reposition()

func _on_card_hover_stopped(card: Card) -> void:
	_hover_queue.erase(card)
	_set_hovered_card()
	_reposition()

func _set_hovered_card() -> void:
	# TODO: investigate this below
	#cards.all(func (element): element.unhover())
	for card in cards:
		card.unhover()
	
	if (_hover_queue.size() <= 0):
		hovered_card = null
		hovered_card_index = -1
		return
		
	hovered_card = _hover_queue.front()
	hovered_card_index = cards.find(hovered_card)
	hovered_card.hover()

func _on_card_drag_started(card: Card) -> void:
	print("card drag started")
	dragged_card = card

func _on_card_drag_stopped(card: Card) -> void:
	print("card drag stopped")
	dragged_card = null

func _on_card_drag_canceled(card: Card) -> void:
	print("card drag canceled")
	dragged_card = null
