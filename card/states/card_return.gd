class_name CardReturn
extends State

## Card return
##
## The return state of Card's state machine 

@export var card_events: CardEvents

@export var card_path: NodePath
@onready var card: Node2D = get_node(card_path)

func enter(_msg := {}) -> void:
	card_events.card_returned.emit(card)
	state_machine.transition_to('Idle')
