class_name CardSelected
extends State

export var root_path: NodePath
onready var root: Node2D = get_node(root_path)

var mouse_pos: Vector2

func process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		mouse_pos = get_global_mouse_position()
		root.global_position = mouse_pos
	else:
		if state_machine.place != null:
			state_machine.transition_to('Play')
			return

		state_machine.transition_to('Return')

