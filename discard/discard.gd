class_name Discard
extends Area2D

signal deck_restored(cards)

var cards: Array = []

func _on_card_drawed(card:Card):
	card.connect("card_played", self, "_on_card_played")
	
func _on_card_played(card:Card):
	card.disconnect("card_played", self, "_on_card_played")
	cards.append(card)
	add_child(card)
	card.global_position = global_position

func _on_deck_depleted():
	for card in cards:
		remove_child(card)
		
	emit_signal('deck_restored', cards)
	cards.clear()
