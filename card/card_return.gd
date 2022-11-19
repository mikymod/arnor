class_name CardReturn
extends State


func process(_delta: float) -> void:
	state_machine.root.global_position = lerp(state_machine.root.global_position, state_machine.init_pos, 0.1);
	if state_machine.root.global_position.distance_to(state_machine.init_pos) <= 0.01:
		state_machine.transition_to('Idle')

func _on_Card_input_event(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			state_machine.transition_to('Selected')
