class_name DrawEffectResource
extends EffectResource

export(int) var cards_to_draw = 1

func apply_effect(args: Dictionary) -> void:
	var deck_resource = load("res://board_area/deck/deck.tres")
	if deck_resource.has_method("draw_card"):
		deck_resource.draw_card()
