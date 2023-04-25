class_name HandResource
extends Resource

@export var power_resource: Resource

var cards: Array[Card] = []

func append_card(card: Card) -> void:
	cards.append(card)

func remove_card(card: Card) -> void:
	cards.erase(card)
