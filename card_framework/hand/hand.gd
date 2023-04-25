class_name Hand
extends Node2D

@export var hand_resource: HandResource
@export var card_events: CardEvents

func _ready() -> void:
	card_events.card_drawed.connect(_on_card_drawed)
	card_events.card_resolved.connect(_on_card_resolved)

func _on_card_drawed(card: Card):
	hand_resource.append_card(card)
	add_child(card)
	card.set_skin()
	card.set_data()
	card.state_machine.transition_to("Draw")
	_reposition()

func _on_card_resolved(card: Card):
	hand_resource.remove_card(card)
	_reposition()
	remove_child(card)

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

