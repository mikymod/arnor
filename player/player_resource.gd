class_name PlayerResource
extends Resource

signal max_health_changed(max_health)
signal health_changed(health)
signal player_lost()

@export var max_health: int = 100
@export var health: int = 100

func change_max_health(value: int):
	max_health += value
	emit_signal("max_health_changed", max_health)

func change_health(value: int):
	health += value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("player_lost")
