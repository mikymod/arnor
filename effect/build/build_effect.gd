class_name BuildEffect
extends Node2D

export(Resource) var tower_resource
export(PackedScene) var tower

var parent: Node

func apply_effect() -> void:
	var instance = tower.instance()
	parent.add_child(instance)
	instance.resource = tower_resource
	instance.global_position = parent.global_position
	queue_free()
