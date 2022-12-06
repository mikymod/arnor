class_name Hand
extends Node2D

var cards: Array = []

func _on_card_drawed(card):
	card.connect("card_played", self, "_on_card_played")
	cards.append(card)
	add_child(card)

	_reposition()

func _on_card_played(card):
	remove_child(card)
	cards.erase(card)
	card.disconnect("card_played", self, "_on_card_played")

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
	var positions = _generate_positions(global_position, 70, cards.size())
	for i in range(cards.size()):
		cards[i].init_pos = positions[i]
		cards[i].state_machine.transition_to('Return')
