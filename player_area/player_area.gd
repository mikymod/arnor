class_name PlayerArea
extends Node2D

## 

@export var target: Node2D
@export var encounter: Encounter
@export var color: Color = Color.WHITE

## Spawn a unit when a card is played.
## This function must be connected to a signal
func on_card_played(card: Card) -> void:
	spawn_unit(card.card_resource, get_nearest_position_in_shape())

func spawn_unit(card: CardResource, spawn_position: Vector2) -> void:
	var unit: Unit = card.unit_scene.instantiate()
	unit.global_position = spawn_position
	unit.target = target
	encounter.finished.connect(unit.encounter_finished)
	encounter.failed.connect(unit.die)
	add_child(unit)

func get_nearest_position_in_shape() -> Vector2:
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
		
