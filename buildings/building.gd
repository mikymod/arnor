class_name Building
extends Area2D

## Represents a faction's building.

signal health_changed(health)
signal destroyed()

@export_group("Stats")
## The health of the building.
@export var max_health: float = 1000
@export var health: float = max_health

@onready var fires = $Fires.get_children()
var fires_index = 0

func harm(amount: float) -> void:
	health -= amount
	health_changed.emit(health)
	print(health)
	if health <= 0:
		destroyed.emit()
		$DestroyedSprite2D.visible = true
		$AnimatedSprite2D.visible = false
