class_name Barrel
extends Unit

@export var explosion_scene: PackedScene

func aoe_attack() -> void:
	super.aoe_attack()
	var explosion = explosion_scene.instantiate()
	queue_free()

func _on_interaction_body_entered(body: Node2D) -> void:
	add_to_units_in_range(body as Unit, UnitGroup.ENEMIES)

func _on_interaction_body_exited(body: Node2D) -> void:
	remove_from_units_in_range(body as Unit)

