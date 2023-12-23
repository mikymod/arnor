class_name Deck
extends Node

##
##
##

signal cards_drawed(cards: Array[Card])


@export var card_scene: PackedScene = preload("res://card_framework/card/card.tscn")
@export var decklist: Dictionary = {}


var cards: Array[Card] = []


#
func _ready() -> void:
	for card in decklist:
		var amount = decklist[card]
		for i in range(amount):
			var card_instance = card_scene.instantiate()
			card_instance.card_resource = card
			cards.append(card_instance)
	draw_cards(3)

func draw_card() -> void:
	var drawed_cards: Array[Card] = []
	if cards.size() == 0:
		return
	var card: Card = cards.pop_front()
	drawed_cards.append(card)
	cards_drawed.emit(drawed_cards)


#
func draw_cards(amount: int) -> void:
	var drawed_cards: Array[Card] = []
	for i in range(amount):
		var card = cards.pop_front()
		drawed_cards.append(card)
	cards_drawed.emit(drawed_cards)
