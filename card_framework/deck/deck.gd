class_name Deck
extends Node

## The deck

signal cards_drawed(cards)
signal deck_exhausted(deck: Deck)
signal deck_shuffled()

@export var state: CardBoardState = preload("res://card_framework/card_board_state.tres")
@export var card_scene: PackedScene = preload("res://card_framework/card/card.tscn")
@export var decklist: Dictionary = {}


func _ready() -> void:
	for card in decklist:
		var amount = decklist[card]
		for i in range(amount):
			var card_instance = card_scene.instantiate()
			card_instance.card_resource = card
			state.deck_cards.append(card_instance)


func start() -> void:
	draw_cards(3)

## Pops an amount of cards from top of deck
func draw_cards(amount: int = 1) -> void:
	var drawed_cards: Array[Card] = []
	for i in range(amount):
		if state.deck_cards.size() <= 0:
			break
		var card = state.deck_cards.pop_front()
		drawed_cards.append(card)
	cards_drawed.emit(drawed_cards)
	if state.deck_cards.size() <= 0:
		deck_exhausted.emit(self)
		
## Shuffles the deck
func shuffle() -> void:
	state.deck_cards.shuffle()
	deck_shuffled.emit()

## Restores the discard cards
func restore(discarded: Array[Card]) -> void:
	state.deck_cards.append_array(discarded)
