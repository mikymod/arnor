class_name Archer
extends Unit

@export var arrow_scene: PackedScene = preload("res://units/archer/arrow.tscn")

func attack() -> void:
	super.attack()
	var arrow = arrow_scene.instantiate()
	arrow.target = get_hostile_unit()
	add_child(arrow)

func _on_interaction_body_entered(body: Node2D) -> void:
	add_to_units_in_range(body as Unit, UnitGroup.ENEMIES)


func _on_interaction_body_exited(body: Node2D) -> void:
	remove_from_units_in_range(body as Unit)
