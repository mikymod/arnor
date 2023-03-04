class_name DrawEffectResource
extends EffectResource

export(int) var cards_to_draw = 1
export(Resource) var deck_events

func apply_effect(args: Dictionary) -> void:
	deck_events.emit_signal("deck_draw_triggered")

