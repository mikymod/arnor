class_name CardIdle
extends State

## Card idle
##
## The idle state of Card's state machine.
## This is the state reached when this card is in hand.

@export var card_events: CardEvents

@export var card_path: NodePath
@onready var card: Node2D = get_node(card_path)

func handle_input(event: InputEvent) -> void:
	if not card.mouseover: return
	if not card.playable: return
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			state_machine.transition_to('Play')

func update(_delta: float) -> void:
	card.global_position = lerp(card.global_position, card.init_pos, 0.1);
	if abs(card.global_position.distance_to(card.init_pos)) <= 1:
		card.global_position = card.init_pos
