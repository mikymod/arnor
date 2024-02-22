class_name PlayerArea
extends Node2D

## 

@export var target: Node2D
@export var encounter: Encounter
@export var color: Color = Color.WHITE

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
	var building = get_nearest_building()
	var extents = building.get_spawn_area_extents()
	var mouse_pos = get_global_mouse_position()
	var new_x = clampf(mouse_pos.x, extents["left"], extents["right"])
	var new_y = clampf(mouse_pos.y, extents["top"], extents['bottom'])
	return Vector2(new_x, new_y)

func get_owned_buildings() -> Array[Node]:
	var buildings = get_tree().get_nodes_in_group("buildings")
	var result = buildings.filter(func(building): return building.get_parent() == self)
	return result

func get_nearest_building() -> Building:
	var buildings = get_owned_buildings()
	var mouse_pos: Vector2 = get_global_mouse_position()
	var nearest_distance = INF
	var result = null
	for building in buildings:
		var distance = absf(mouse_pos.distance_to(building.global_position))
		if distance < nearest_distance:
			nearest_distance = distance
			result = building
	return result
		
