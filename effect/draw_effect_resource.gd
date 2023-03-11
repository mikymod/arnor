class_name DrawEffectResource
extends EffectResource

export(int) var cards_to_draw = 1
export(Resource) var deck_events = preload("res://deck/deck_events.tres")

func apply_effect(args: Dictionary) -> void:
	for i in cards_to_draw:
		deck_events.emit_signal("deck_draw_triggered")

