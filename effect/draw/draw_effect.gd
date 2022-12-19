extends Node2D

var deck_resource

func apply_effect(args: Dictionary) -> void:
	deck_resource.draw_card()
	queue_free()
