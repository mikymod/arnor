class_name BoardArea
extends Node2D

onready var deck: Deck = $Deck
onready var hand: Hand = $Hand

#func _ready() -> void:
#	deck.draw_card()
#	deck.draw_card()
#	deck.draw_card()
#	deck.draw_card()
#
#func _process(_delta: float) -> void:
#	if hand.hand_resource.cards.size() == 0:
#		var num_cards_to_draw = min(deck.resource.deck_list.size(), 4)
#		for _i in range(num_cards_to_draw):
#			deck.draw_card()
