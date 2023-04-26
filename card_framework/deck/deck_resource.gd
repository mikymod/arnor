# A resource to store a deck
class_name DeckResource
extends Resource

@export var deck_list: Dictionary

func add_card(card: CardResource) -> void:
	if deck_list.has(card):
		deck_list[card] = deck_list[card] + 1
	else:
		deck_list[card] = 1

func remove_card(card: CardResource) -> void:
	if deck_list.has(card):
		deck_list[card] = deck_list[card] - 1
