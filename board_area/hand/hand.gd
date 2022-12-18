class_name Hand
extends Node2D

export(Resource) var hand_resource
export(Resource) var deck_resource

func _ready() -> void:
	deck_resource.connect('card_drawed', self, '_on_card_drawed')
	hand_resource.connect('card_played', self, '_on_card_played')

func _on_card_drawed(card):
	hand_resource.cards.append(card)
	card.get_parent().remove_child(card)
	add_child(card)
	_reposition()

func _on_card_played(_card):
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
	var positions = _generate_positions(global_position, 70, hand_resource.cards.size())
	for i in range(hand_resource.cards.size()):
		hand_resource.cards[i].init_pos = positions[i]
		hand_resource.cards[i].state_machine.transition_to('Return')
