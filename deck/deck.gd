class_name Deck
extends Node2D

export(Resource) var resource
export(PackedScene) var card_scene

func _ready() -> void:
	# Instantiates deck
	for card in resource.deck_list:
		var quantity = resource.deck_list[card]
		for _i in range(quantity):
			var instance = card_scene.instance()
			instance.resource = card
			add_child(instance)
			resource.deck.append(instance)

	resource.deck.shuffle()

func draw_card() -> void:
	resource.draw_card(self)

func _on_deck_restored():
	for _card in resource.deck:
		add_child(_card)
		_card.global_position = global_position
