class_name CardHand
extends Node2D

## The Card Hand
## 
## This script provides all the logic for positing cards in hand.
##
## Hover logic:
##
## A card is hovered when the mouse pointer enters the card area.
## Mouse pointer can enter more than one card area (card overlapping) 
## at the same time but we need to have always a single hovered card.
## To resolve this:
## - every time the signal `hover_started(card)` is received we append the card 
##   to the queue
## - every time the signal `hover_stopped(card)` is received we erase that card
##   from the queue
## - The hovered card is always the card at queue's front
##
## Drag logic:
##
## The current hovered card can be dragged and dropped in the space.
## Whenever a card leaves the hand area, it becomes invisible and the 
## relative unit scene is spawned and dragged.
## If the drag is stopped outside the hand area, the card is played 
## and the unit scene doesn't belong to hand anymore.
## If the drag is cancelled, the card becomes visible again and returns
## to the right position in hand.

@export var card_scene: PackedScene = preload("res://card_framework/card/card.tscn")

@export var interpolation_speed: float = 0.1
@export var card_angle: float = 5
@export var card_spacing: float = 200
@export var arc_height: float = 0
@export var peek_x_displacement: float = 50
@export var peek_y_displacement: float = -100

var cards: Array[Card] = []

var _hover_queue: Array[Card]
var _hovered_card: Card
var _hovered_card_index: int = -1

var _dragged_card: Card
var _dragging: bool = false
var _unit_instance: Node = null


func _ready() -> void:
	#for i in 5:
		#add_card()
	#_reposition()
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if _hovered_card == null:
			return
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			_start_drag()
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			_stop_drag()
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			_cancel_drag()


func _process(delta: float) -> void:
	if _dragged_card != null:
		_dragged_card.global_position = get_viewport().get_mouse_position()
	if _unit_instance != null:
		_unit_instance.global_position = get_viewport().get_mouse_position()

## Adds a card to hand
func add_card() -> void:
	var new_card = card_scene.instantiate()
	new_card.hover_started.connect(_on_card_hover_started)
	new_card.hover_stopped.connect(_on_card_hover_stopped)
	add_child(new_card)
	cards.append(new_card)

## Removes a card from hand
func remove_card(card: Card) -> void:
	card.hover_started.disconnect(_on_card_hover_started)
	card.hover_stopped.disconnect(_on_card_hover_stopped)
	remove_child(card)
	cards.erase(card)

## Reposition all cards in hand
func _reposition():
	var tween = get_tree().create_tween()
	var positions = _generate_positions()
	for i in range(cards.size()):
		tween.tween_property(cards[i], "position", positions[i], interpolation_speed) 
		cards[i].rotation_degrees = _get_card_angle(i)

## Retrieves the card x position 
func _get_card_x_pos(index: int) -> float:
	var center = _get_center()
	var num_cards = cards.size()
	var x_displacement = _get_x_displacement(index)
	return (index - num_cards / 2) * card_spacing + position.x + center.x + x_displacement

## Retrieves the card y position
func _get_card_y_pos(index: int) -> float:
	var center = _get_center()
	var y_displacement = _get_y_displacement(index)
	return center.y + index * arc_height + y_displacement

## Retrieves the center of the hand
func _get_center() -> Vector2:
	return $Hand.position

## Retrieves the card angle in hand
func _get_card_angle(index: int) -> float:
	return _get_index_from_center(index) * card_angle

## Retrieves the index starting from center
func _get_index_from_center(index: int) -> int:
	var index_from_center: float = index - (cards.size() - 1) / 2
	if (index_from_center < 0):
		index_from_center -= 0.5
	return round(index_from_center)

func _get_x_displacement(index: int) -> float:
	return peek_x_displacement if _hovered_card_index >= 0 and index > _hovered_card_index else 0

func _get_y_displacement(index: int) -> float:
	return peek_y_displacement if index == _hovered_card_index else 0

func _generate_positions() -> Array:
	var positions = []
	for i in range(cards.size()):
		var pos_x = _get_card_x_pos(i)
		var pos_y = _get_card_y_pos(i)
		positions.append(Vector2(pos_x, pos_y))
	return positions

## Callback called when a card is hovered
func _on_card_hover_started(card: Card) -> void:
	if _dragging: return;
	_hover_queue.append(card)
	_set_hovered_card()
	_reposition()

## Callback called when a card is unhovered
func _on_card_hover_stopped(card: Card) -> void:
	if _dragging: return;
	_hover_queue.erase(card)
	_set_hovered_card()
	_reposition()

## Sets the current hovered card
func _set_hovered_card() -> void:
	# TODO: investigate this below
	#cards.all(func (element): element.unhover())
	for card in cards:
		card.unhover()
	
	if (_hover_queue.size() <= 0):
		_hovered_card = null
		_hovered_card_index = -1
		return
		
	_hovered_card = _hover_queue.front()
	_hovered_card_index = cards.find(_hovered_card)
	_hovered_card.hover()

## Start card dragging
func _start_drag() -> void:
	_dragged_card = _hovered_card
	_dragged_card.rotation_degrees = 0
	_dragging = true

## 
func _stop_drag() -> void:
	_dragged_card = null
	_dragging = false

##
func _cancel_drag() -> void:
	_dragged_card = null
	_dragging = false
	_reposition()

## Callback invoked when a card enters the hand area
func _on_hand_area_entered(area: Area2D) -> void:
	var card = area as Card
	card.change_opacity(1)
	if _unit_instance != null:
		_unit_instance.queue_free()

## Callback invoked when a card leaves the hand area
func _on_hand_area_exited(area: Area2D) -> void:
	var card = area as Card
	card.change_opacity(0)
	_unit_instance = card.unit_scene.instantiate()
	call_deferred("add_child", _unit_instance)


## Callback invoked when cards are drawed
func _on_cards_drawed(drawed_cards: Array[Card]) -> void:
	for new_card in drawed_cards:
		new_card.hover_started.connect(_on_card_hover_started)
		new_card.hover_stopped.connect(_on_card_hover_stopped)
		add_child(new_card)
		cards.append(new_card)
	_reposition()
