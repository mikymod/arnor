class_name Discard
extends Area2D



export(Resource) var deck_resource

var cards: Array = []

func _ready() -> void:
	deck_resource.connect('card_drawed', self, '_on_card_drawed')
	deck_resource.connect('deck_depleted', self, '_on_deck_depleted')

# Only used to connects card_played events to this script 
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
	deck_resource.restore_deck(cards)
	cards.clear()
