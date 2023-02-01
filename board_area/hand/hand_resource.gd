class_name HandResource
extends Resource

export(Resource) var power_resource
export(Resource) var card_events

var cards: Array = []

func play_card(card: Card) -> void:
	if power_resource.current_power < card.resource.cost:
		card.state_machine.transition_to("Return")
		return; # TODO: emit signal
		
	cards.erase(card)
	card.state_machine.transition_to("Inactive")
	card_events.emit_signal("card_played", card)
