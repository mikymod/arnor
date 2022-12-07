class_name CardIdle
extends State

## Card idle
##
## The idle state of Card's state machine.
## This is the first state reached when this card is in hand.

func _on_Card_input_event(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			state_machine.transition_to('Selected')
