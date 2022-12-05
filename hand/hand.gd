class_name Hand
extends Node2D

export var deck_path: NodePath
onready var deck: Node2D = get_node(deck_path)

var cards_in_hand: Array = []

func _ready():
	var _void = deck.connect("card_drawed", self, "_on_card_drawed")

	# TODO: this should be called in the manager
	deck.draw_card()
	deck.draw_card()
	deck.draw_card()
	deck.draw_card()

func _on_card_drawed(card):
	card.connect("card_played", self, "_on_card_played")
	cards_in_hand.append(card)
	add_child(card)

	_reposition()

func _on_card_played(card):
	card.disconnect("card_played", self, "_on_card_played")
	cards_in_hand.erase(card)
	remove_child(card)

	_reposition()

func _generate_positions(center: Vector2, offset: int, num_card: int) -> Array:
	var positions = []

	var first_pos_x = 0.0

	if num_card % 2 == 0:
		first_pos_x = center.x - offset * 0.5 - offset * (num_card - 1) / 2.0
	if num_card % 2 == 1:
		first_pos_x = center.x - (offset * (num_card - 1) / 2.0)
	
	for i in range(num_card):
		positions.append(Vector2(first_pos_x + offset * i, center.y));

	return positions

func _reposition():
	var positions = _generate_positions(global_position, 70, cards_in_hand.size())
	for i in range(cards_in_hand.size()):
		cards_in_hand[i].init_pos = positions[i]
		cards_in_hand[i].state_machine.transition_to('Return')
