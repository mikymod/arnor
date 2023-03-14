class_name DrawEffectResource
extends EffectResource

@export var cards_to_draw: int = 1
@export var deck_events: Resource = preload("res://deck/deck_events.tres")

func apply_effect(args: Dictionary) -> void:
	for i in cards_to_draw:
		deck_events.emit_signal("deck_draw_triggered")
