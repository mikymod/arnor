class_name DiscardEffectResource
extends EffectResource

export(Resource) var card_events

func apply_effect(args: Dictionary) -> void:
	var card = args.target
	card_events.emit_signal("card_discarded", card)
	
