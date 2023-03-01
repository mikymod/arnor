class_name DiscardEffectResource
extends EffectResource

export(Resource) var card_events
export(Resource) var hand

func apply_effect(args: Dictionary) -> void:
	var card = args.target
	card.get_parent().remove_child(card)
	hand.remove_card(card)
	card_events.emit_signal("card_discarded", card)
	
