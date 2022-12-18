class_name BuildEffect
extends Node2D

export(Resource) var tower_resource
export(PackedScene) var tower

func apply_effect(args: Dictionary) -> void:
	var parent = args.target
	var instance = tower.instance()
	instance.resource = tower_resource
	parent.add_child(instance)
	instance.global_position = parent.global_position
	queue_free()
