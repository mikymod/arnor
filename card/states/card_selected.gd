class_name CardSelected
extends State

## Card selected
##
## The selected state of Card's state machine 

export var card_path: NodePath
onready var card: Node2D = get_node(card_path)

var mouse_pos: Vector2

func process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		mouse_pos = get_global_mouse_position()
		card.global_position = mouse_pos
	else:
		if state_machine.place != null:
			state_machine.transition_to('Play')
			return

		state_machine.transition_to('Return')

