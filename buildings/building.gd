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

func _ready() -> void:
	spawned.emit(self)
	health_bar.change_style(_player_area)

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
