extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_animated_sprite_2d_animation_finished():
	queue_free()
