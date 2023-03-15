class_name DiscardEffectResource
extends EffectResource

@export var card_events: CardEvents = preload("res://card/card_events.tres")
@export var hand: HandResource = preload("res://hand/hand.tres")

func apply_effect(args: Dictionary) -> void:
	var card = args.target
	card.get_parent().remove_child(card)
	hand.remove_card(card)
	card_events.card_discarded.emit(card)
