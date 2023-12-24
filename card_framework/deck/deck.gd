class_name Deck
extends Node

## The deck

signal cards_drawed(cards)
signal deck_exhausted(deck: Deck)
signal deck_shuffled()

@export var card_scene: PackedScene = preload("res://card_framework/card/card.tscn")
@export var decklist: Dictionary = {}

## The array of cards
var _cards: Array[Card] = []


func _ready() -> void:
	for card in decklist:
		var amount = decklist[card]
		for i in range(amount):
			var card_instance = card_scene.instantiate()
			card_instance.card_resource = card
			_cards.append(card_instance)
	# TODO: test, must be removed
	draw_cards(3)


## Pops an amount of cards from top of deck
func draw_cards(amount: int) -> void:
	var drawed_cards: Array[Card] = []
	for i in range(amount):
		if _cards.size() <= 0:
			break
		var card = _cards.pop_front()
		drawed_cards.append(card)
	cards_drawed.emit(drawed_cards)
	if _cards.size() <= 0:
		deck_exhausted.emit(self)
		
## Shuffles the deck
func shuffle() -> void:
	_cards.shuffle()
	deck_shuffled.emit()

## Restores the discard cards
func restore(discarded: Array[Card]) -> void:
	_cards.append_array(discarded)
