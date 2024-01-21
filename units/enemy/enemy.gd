class_name Enemy
extends Unit


func _on_interaction_area_2d_body_entered(body: Node2D):
	add_to_units_in_range(body as Unit, UnitGroup.ALLIES)


func _on_interaction_area_2d_body_exited(body: Node2D):
	remove_from_units_in_range(body as Unit)
