class_name CardReturn
extends State

## Card return
##
## The return state of Card's state machine 

@export var card_events: CardEvents

@export var card_path: NodePath
@onready var card: Node2D = get_node(card_path)

func enter(_msg := {}) -> void:
	card_events.emit_signal("card_returned", card)
	state_machine.transition_to('Idle')

#func handle_input(event: InputEvent) -> void:
#	if event is InputEventMouseButton:
#		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
#			state_machine.transition_to('Selected')

func update(_delta: float) -> void:
#	card.global_position = lerp(card.global_position, card.init_pos, 0.1);
#	if abs(card.global_position.distance_to(card.init_pos)) <= 1:
#		card.global_position = card.init_pos
#		state_machine.transition_to('Idle')
	pass

