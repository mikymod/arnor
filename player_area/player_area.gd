class_name PlayerArea
extends Node2D

## 

@export var target: Node2D
@export var encounter: Encounter
@export var color: Color = Color.WHITE

@export var building: Building


## Spawn a unit when a card is played.
## This function must be connected to a signal
func on_card_played(card: Card) -> void:
	var unit: Unit = card.card_resource.unit_scene.instantiate()
	#unit.global_position = get_global_mouse_position()
	unit.global_position = spawn_in_shape(unit)
	unit.target = target

	encounter.finished.connect(unit.encounter_finished)
	encounter.failed.connect(unit.die)
	add_child(unit)

func spawn_in_shape(unit: Unit) -> Vector2:
	var extents = building.get_spawn_area_extents()

	var mouse_pos = get_global_mouse_position()
	var new_x = clampf(mouse_pos.x, extents["left"], extents["right"])
	var new_y = clampf(mouse_pos.y, extents["top"], extents['bottom'])
	return Vector2(new_x, new_y)
	
	
