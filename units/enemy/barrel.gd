class_name Barrel
extends Unit

@export var explosion_scene: PackedScene = preload("res://units/enemy/explosion.tscn")
@export var explosion_time: float = 3.0

func aoe_attack() -> void:
	super.aoe_attack()
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	get_tree().root.add_child(explosion)
	queue_free()

func _on_interaction_body_entered(body: Node2D) -> void:
	add_to_units_in_range(body as Unit, UnitGroup.ALLIES)

func _on_interaction_body_exited(body: Node2D) -> void:
	remove_from_units_in_range(body as Unit)

