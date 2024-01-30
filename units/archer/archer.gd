class_name Archer
extends Unit

@export var arrow_scene: PackedScene = preload("res://units/archer/arrow.tscn")

func attack() -> void:
	super.attack()
	var arrow = arrow_scene.instantiate()
	arrow.target = get_hostile_unit()
	add_child(arrow)
