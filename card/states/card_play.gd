class_name CardPlay
extends State

## Card play
##
## The play state of Card's state machine

@export var card_events: CardEvents

@export var root_path: NodePath
@onready var card: Node2D = get_node(root_path)

func enter(_msg := {}) -> void:
	card_events.card_played.emit(card)

func update(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		state_machine.transition_to("Return")
