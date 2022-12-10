class_name Deck
extends Node2D

signal card_drawed(card)
signal deck_depleted()

export var deck_list: Dictionary
export var card_scene: PackedScene

var deck: Array = []

func _ready() -> void:
	for resource in deck_list:
		var quantity = deck_list[resource]
		for _i in range(quantity):
			var instance = card_scene.instance()
			instance.resource = resource
			add_child(instance)
			deck.append(instance)

	deck.shuffle()

func draw_card() -> void:
	var current = deck.pop_back()
	remove_child(current)
	emit_signal('card_drawed', current)
	if deck.size() == 0:
		emit_signal('deck_depleted')

func _on_deck_restored(cards_to_restore:Array):
	deck.append_array(cards_to_restore)
	for _card in deck:
		add_child(_card)
		_card.global_position = global_position
	deck.shuffle()
