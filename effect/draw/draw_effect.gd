extends Node2D

func apply_effect(_args: Dictionary) -> void:
	# TODO: 
	# i had to replace `export(Resource) deck_res` because cyclic dependencies.
	# load(res) does not cause cyclic deps. why?
	var deck_resource = load('res://deck/resources/start_deck.tres') 
	deck_resource.draw_card()
