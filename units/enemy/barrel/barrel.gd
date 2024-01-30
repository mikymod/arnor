class_name Barrel
extends Unit

@export var explosion_scene: PackedScene = preload("res://units/enemy/explosion/explosion.tscn")
@export var explosion_time: float = 3.0

func aoe_attack() -> void:
	super.aoe_attack()
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	get_tree().root.add_child(explosion)
	queue_free()
