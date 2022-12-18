extends Node2D

func apply_effect(_parent) -> void:
	var deck_resource = load('res://deck/resources/start_deck.tres')
	deck_resource.draw_card()
