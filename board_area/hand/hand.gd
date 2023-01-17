class_name Hand
extends Node2D

export(Resource) var hand_resource
export(Resource) var deck_resource

var effect_solver: EffectSolver

func _ready() -> void:
	effect_solver = get_node('/root/Level/EffectSolver')
	
	if effect_solver != null:
		effect_solver.connect("card_solved", self, "_on_card_solved")
	deck_resource.connect('card_drawed', self, '_on_card_drawed')
	hand_resource.connect('card_played', self, '_on_card_played')

func _on_card_drawed(card):
	hand_resource.cards.append(card)
	add_child(card)
	card.set_skin()
	card.set_data()
	_reposition()

func _on_card_played(_card):
	_reposition()
	for card in hand_resource.cards:
		card.disable_collision()
	remove_child(_card)

func _on_card_solved(card: Card):
	print('Card Solved')
	for card in hand_resource.cards:
		card.enable_collision()

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
	var positions = _generate_positions(global_position, 214, hand_resource.cards.size())
	for i in range(hand_resource.cards.size()):
		hand_resource.cards[i].init_pos = positions[i]
		hand_resource.cards[i].state_machine.transition_to('Return')

func _on_Hand_area_entered(area):
	if area is Card:
		area.playable = false

func _on_Hand_area_exited(area):
	if area is Card:
		area.playable = true
