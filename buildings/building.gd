class_name Building
extends Area2D

## Represents a faction's building.

signal building_harmed()
signal building_destroyed()

@export_group("Stats")
## The health of the building.
@export var health: float = 1000

@onready var fires = $Fires.get_children()
var fires_index = 0

var harm_step: int = health / fires.size()
# fires_index = fmod(health, harm_step)

func harm(amount: float) -> void:
	health -= amount
	building_harmed.emit()
	if health <= 0:
		destroy()

## Spawns a fire
func spawn_fire() -> void:
	var fire: Fire = fires[fires_index]
	fire.start()
	if fires_index < fires.size() - 1:
		fires_index += 1

## Extinguish a fire
func extinguish_fire() -> void:
	if fires_index >= 0:
		var fire: Fire = fires[fires_index]
		fire.stop()
		fires_index -= 1

## Destroy the building
func destroy() -> void:
	building_destroyed.emit()
	print ("building destroyed")



