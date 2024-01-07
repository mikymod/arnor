class_name PineTree
extends Supply

@export var wood_resource: GatherResource = preload("res://resources/wood.tres")

@onready var _animation_player: AnimationPlayer = $AnimationPlayer


func get_cut_position() -> Node2D:
	return $CutPosition


func pop_resource() -> void:
	amount -= pop_amount
	_animation_player.play("hit")
	_animation_player.animation_finished.connect(_on_animation_finished)
	wood_resource.add(pop_amount)


func _on_animation_finished(anim_name: String) -> void:
	_animation_player.play("idle")
	_animation_player.animation_finished.disconnect(_on_animation_finished)
