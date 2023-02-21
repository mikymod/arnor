class_name CardDraw
extends State

## Card return
##
## The draw state of Card's state machine 

export(Resource) var card_events

export var card_path: NodePath
onready var card: Node2D = get_node(card_path)

func update(_delta: float) -> void:
	card.global_position = lerp(card.global_position, card.init_pos, 0.1);
	if abs(card.global_position.distance_to(card.init_pos)) <= 1:
		card.global_position = card.init_pos
		state_machine.transition_to('Idle')
