class_name Fire
extends Node2D

@export var building: Building
@export var threshold: int = 0

var active: bool:
	get:
		return visible == true


func _on_building_health_changed(health: float) -> void:
	if health < threshold:
		start()
	else:
		stop()


func _on_building_destroyed() -> void:
	stop()

func start() -> void:
	if active: return
	visible = true
	var scale_factor = randf_range(0.5, 1.2)
	scale = Vector2(scale_factor, scale_factor)
	$AnimatedSprite2D.play("default")

func stop() -> void:
	$AnimatedSprite2D.stop()
	visible = false

