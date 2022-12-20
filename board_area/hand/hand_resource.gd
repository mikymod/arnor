class_name HandResource
extends Resource

signal card_played(card)

export(Resource) var power_resource

var cards: Array = []

func play_card(card: Card) -> void:
	if power_resource.current_power < card.resource.cost:
		card.state_machine.transition_to("Return")
		return; # TODO: emit signal
		
	cards.erase(card)
	card.state_machine.transition_to("Inactive")
	emit_signal('card_played', card)
	
