extends Node2D

func apply_effect(tower: Node) -> void:
	tower.queue_free()
