class_name HandResource
extends Resource

export(Resource) var power_resource

var cards: Array = []

func append_card(card: Card) -> void:
	cards.append(card)

func remove_card(card: Card) -> void:
	if power_resource.current_power < card.resource.cost:
		card.state_machine.transition_to("Return")
		return; # TODO: emit signal
	cards.erase(card)
