class_name Fire
extends Node2D


func start() -> void:
	visible = true
	var scale_factor = randf_range(0.5, 1.2)
	scale = Vector2(scale_factor, scale_factor)
	$AnimatedSprite2D.play("default")

func stop() -> void:
	$AnimatedSprite2D.stop()
	visible = false

