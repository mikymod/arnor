class_name Warrior
extends Unit


func _on_interaction_body_entered(body: Node2D) -> void:
	add_to_units_in_range(body as Unit, UnitGroup.ENEMIES)


func _on_interaction_body_exited(body: Node2D) -> void:
	remove_from_units_in_range(body as Unit)

