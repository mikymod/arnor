class_name PlayerArea
extends Node2D

## 

@export var target: Node2D

## Spawn a unit when a card is played.
## This function must be connected to a signal
func on_card_played(card: Card) -> void:
	var unit = card.unit_scene.instantiate()
	print(card.global_position)
	unit.global_position = get_global_mouse_position()
	unit.target = target
	add_child(unit)

