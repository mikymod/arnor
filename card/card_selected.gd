class_name CardSelected
extends State

var mouse_pos: Vector2

func process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		mouse_pos = get_global_mouse_position()
		state_machine.root.global_position = mouse_pos
	else:
		if state_machine.place != null:
			state_machine.transition_to('Play')
			return

		state_machine.transition_to('Return')

