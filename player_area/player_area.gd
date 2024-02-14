class_name PlayerArea
extends Node2D

## 

@export var target: Node2D
@export var encounter: Encounter

## Spawn a unit when a card is played.
## This function must be connected to a signal
func on_card_played(card: Card) -> void:
	var unit = card.card_resource.unit_scene.instantiate()
	print(card.global_position)
	unit.global_position = get_global_mouse_position()
	unit.target = target
	encounter.finished.connect(unit.encounter_finished)
	encounter.failed.connect(unit.die)
	add_child(unit)

