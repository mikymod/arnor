class_name Discard
extends Area2D

export(Resource) var deck_resource
export(Resource) var hand_resource

var cards: Array = []

func _ready() -> void:
	hand_resource.connect('card_played', self, '_on_card_played')
	deck_resource.connect('deck_depleted', self, '_on_deck_depleted')

func _on_card_played(card):
	card.get_parent().remove_child(card)
	add_child(card)
	
	card.global_position = global_position
	
	cards.append(card)

func _on_deck_depleted():
	for card in cards:
		remove_child(card)
	deck_resource.restore_deck(cards)
	cards.clear()
