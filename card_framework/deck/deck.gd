class_name Deck
extends Node

## The deck

signal cards_drawed(cards)

@export var card_scene: PackedScene = preload("res://card_framework/card/card.tscn")
@export var deck_resource: DeckResource

func start() -> void:
	draw_cards(3)

## Pops an amount of cards from top of deck
func draw_cards(amount: int = 1) -> void:
	var drawed_cards: Array[Card] = []
	for i in range(amount):
		var card_resource = deck_resource.get_random()
		var card = card_scene.instantiate()
		card.card_resource = card_resource
		drawed_cards.append(card)
	cards_drawed.emit(drawed_cards)
