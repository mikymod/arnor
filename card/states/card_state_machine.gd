class_name CardStateMachine
extends StateMachine

## The state machine of Card

var mouse_over: bool = false
var place: Area2D

func _on_Card_mouse_entered() -> void:
	mouse_over = true

func _on_Card_mouse_exited() -> void:
	mouse_over = false

func _on_Card_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if mouse_over and (state is CardIdle or state is CardReturn):
		state._on_Card_input_event(event)

