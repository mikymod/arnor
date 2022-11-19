class_name CardIdle
extends State

func _on_Card_input_event(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			state_machine.transition_to('Selected')
