class_name HandResource
extends Resource

export(Resource) var power_resource

var cards: Array = []

func append_card(card: Card) -> void:
	cards.append(card)

func remove_card(card: Card) -> void:
	cards.erase(card)
