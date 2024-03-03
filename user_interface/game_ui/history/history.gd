extends Control

@export var frame_scene: PackedScene

func on_card_played(card: Card) -> void:
	# TODO: manage this logic inside array
	var frame = frame_scene.instantiate()
	frame.set_thumb(card.card_resource.unit_thumb_ui)
	$NinePatchRect/VBoxContainer.add_child(frame)
