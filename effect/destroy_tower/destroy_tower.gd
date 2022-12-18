extends Node2D

func apply_effect(args: Dictionary) -> void:
	var tower = args.target
	tower.queue_free()
	queue_free()
