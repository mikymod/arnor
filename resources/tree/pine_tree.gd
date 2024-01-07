class_name PineTree
extends Node2D

@export var wood_resource: GatherResource = preload("res://resources/wood.tres")

@export var resource_amount: int = 10
@export var resource_delta: int = 2

@onready var _animation_player: AnimationPlayer = $AnimationPlayer


func get_cut_position() -> Node2D:
	return $CutPosition

func pop_resource() -> void:
	resource_amount -= resource_delta
	_animation_player.play("hit")
	_animation_player.animation_finished.connect(_on_animation_finished)
	wood_resource.add(resource_delta)

func _on_animation_finished(anim_name: String) -> void:
	_animation_player.play("idle")
	_animation_player.animation_finished.disconnect(_on_animation_finished)
