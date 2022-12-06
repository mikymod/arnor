class_name Deck
extends Node2D

signal card_drawed(card)
signal deck_depleted()

export var cards: Dictionary
export var card: PackedScene

var deck: Array = []

func _ready() -> void:
	for entry in cards:
		var quantity = cards[entry]
		for _i in range(quantity):
			var instance = card.instance()
			add_child(instance)
			instance.setup(entry)
			deck.append(instance)
			
	deck.shuffle()

func draw_card() -> void:
	var current = deck.pop_back()
	remove_child(current)
	emit_signal('card_drawed', current)
	if deck.size() == 0:
		emit_signal('deck_depleted')

func _on_deck_restored(cards_to_restore:Array):
	print('Deck restored')
	deck.append_array(cards_to_restore)
	for _card in deck:
		add_child(_card)
		_card.global_position = global_position
	deck.shuffle()
