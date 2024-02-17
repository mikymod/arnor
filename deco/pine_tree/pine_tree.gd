class_name PineTree
extends SupplySource

## A source for wood


@onready var _animation_player: AnimationPlayer = $AnimationPlayer


func get_cut_position() -> Node2D:
	return $CutPosition


func hit() -> void:
	_animation_player.play("hit")
	_animation_player.animation_finished.connect(_on_animation_finished)


func _on_animation_finished(anim_name: String) -> void:
	_animation_player.play("idle")
	_animation_player.animation_finished.disconnect(_on_animation_finished)
