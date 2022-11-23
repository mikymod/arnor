class_name Hand
extends Node2D

export var deck_path: NodePath
onready var deck: Node2D = get_node(deck_path)

var cards_in_hand: Array = []

func _ready():
	print("ready hand")

	var _void = deck.connect("card_drawed", self, "_on_card_drawed")

	# TODO: this should be called in the manager
	deck.draw_card()
	deck.draw_card()
	deck.draw_card()
	deck.draw_card()

func _on_card_drawed(card):
	cards_in_hand.append(card)
	add_child(card)
	card.init_pos = global_position


