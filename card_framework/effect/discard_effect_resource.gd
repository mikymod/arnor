class_name DiscardEffectResource
extends EffectResource

@export var card_events: CardEvents = preload("res://card_framework/card/card_events.tres")


func apply_effect(args: Dictionary) -> void:
	var card = args.target
	card_events.card_discarded.emit(card)
