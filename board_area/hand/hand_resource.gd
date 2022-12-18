class_name HandResource
extends Resource

signal card_played(card)

var cards: Array = []

func play_card(card: Card) -> void:
	cards.erase(card)
	emit_signal('card_played', card)
	
