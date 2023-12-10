class_name CardHand
extends Node2D

@export var card_scene: PackedScene = preload("res://card_framework/card/card.tscn")

@export var interpolation_speed: float = 1000
@export var card_angle: float = 0
@export var card_spacing: float = 150
@export var peek_x_displacement: float = 100
@export var peek_y_displacement: float = -100

@onready var origin_y = $Origin.global_position.y

var cards: Array[Card] = []

var hovered_card: Card
var dragged_card: Card

func _ready() -> void:
	for i in 3:
		add_card()
	_reposition()

func add_card() -> void:
	var new_card = card_scene.instantiate()
	new_card.hover_started.connect(_on_card_hover_started)
	new_card.hover_stopped.connect(_on_card_hover_stopped)
	new_card.drag_started.connect(_on_card_drag_started)
	new_card.drag_stopped.connect(_on_card_drag_stopped)
	new_card.drag_canceled.connect(_on_card_drag_canceled)
	add_child(new_card)
	cards.append(new_card)

func remove_card(card: Card) -> void:
	card.hover_started.disconnect(_on_card_hover_started)
	card.hover_stopped.disconnect(_on_card_hover_stopped)
	card.drag_started.disconnect(_on_card_drag_started)
	card.drag_stopped.disconnect(_on_card_drag_stopped)
	card.drag_canceled.disconnect(_on_card_drag_canceled)
	remove_child(card)
	cards.erase(card)

func _reposition():
	var positions = _generate_positions()
	for i in range(cards.size()):
		cards[i].global_position = positions[i]

func _generate_positions() -> Array:
	var center = $Origin.global_position
	var offset = card_spacing
	var num_card = cards.size()
	var positions = []
	var first_pos_x = 0.0
	if num_card % 2 == 0:
		first_pos_x = center.x - offset * 0.5 - offset * (num_card - 1) / 2.0
	if num_card % 2 == 1:
		first_pos_x = center.x - (offset * (num_card - 1) / 2.0)
	for i in range(num_card):
		positions.append(Vector2(first_pos_x + offset * i, center.y))
	return positions

func _on_card_hover_started(card: Card) -> void:
	hovered_card = card
	var pos = Vector2(card.position.x, card.position.y + peek_y_displacement)
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", pos, abs(peek_y_displacement / interpolation_speed))
	
func _on_card_hover_stopped(card: Card) -> void:
	var pos = Vector2(card.position.x, origin_y)
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", pos, abs(peek_y_displacement / interpolation_speed))
	hovered_card = null

func _on_card_drag_started(card: Card) -> void:
	print("card drag started")
	dragged_card = card

func _on_card_drag_stopped(card: Card) -> void:
	print("card drag stopped")
	dragged_card = null

func _on_card_drag_canceled(card: Card) -> void:
	print("card drag canceled")
	dragged_card = null
