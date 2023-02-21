class_name CardStateMachine
extends StateMachine

## The state machine of Card

var mouse_over: bool = false

func _on_Card_mouse_entered() -> void:
	mouse_over = true

func _on_Card_mouse_exited() -> void:
	mouse_over = false
