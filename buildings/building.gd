class_name Building
extends Area2D

## Represents a faction's building.

## Emits when building is spawned
signal spawned(building: Building)
## Emits when building's health changed
signal health_changed(health)
## Emits when building is destroyed
signal destroyed()

@export_group("Stats")
## The maximum amount of health of the building.
@export var max_health: float = 1000

## The current health of the building
@onready var health: float = max_health

@onready var fires = $Fires.get_children()
@onready var health_bar: HealthBar = $HealthBar
@onready var _player_area: PlayerArea = get_parent()
@onready var _encounter: Encounter = _player_area.get_parent()

func _ready() -> void:
	spawned.emit(self)
	health_bar.change_style(_player_area.player_resource)
	add_to_group("buildings")

## Applies damage to building
func harm(amount: float) -> void:
	health -= amount
	health_changed.emit(health)
	if health <= 0:
		destroyed.emit()

## Repairs the building
func repair(amount: float) -> void:
	if health <= 0: return
	health += amount
	health_changed.emit(health)

func get_spawn_area_extents() -> Dictionary:
	var rect: RectangleShape2D = $Area2D/CollisionShape2D.shape 
	var offset = $Area2D.position
	var pos = global_position + offset
	
	var left = pos.x - rect.size.x / 2
	var bottom = pos.y + rect.size.y / 2
	
	var right = pos.x + rect.size.x / 2
	var top = pos.y - rect.size.y / 2
	
	return {"left": left, "top": top, "right": right, "bottom": bottom}
	
	
