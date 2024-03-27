class_name CardPileResource
extends Resource

# A resource that contains a collection of cards

signal card_already_collected(card)

@export var cards: Dictionary # (CardResource, bool)

var owned_cards: Array[CardResource]:
	get:
		var owned: Array[CardResource] = []
		for key in cards:
			if cards[key]:
				owned.append(key)
		return owned

var unowned_cards: Array[CardResource]:
	get:
		var owned: Array[CardResource] = []
		for key in cards:
			if not cards[key]:
				owned.append(key)
		return owned
		
func add_card(card: CardResource) -> void:
	if cards[card] == true:
		card_already_collected.emit(card)
	cards[card] = true
