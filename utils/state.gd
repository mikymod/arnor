class_name State
extends Node

# Virtual base class for all states.

signal transitioned(new_state_name: String)

func enter() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass
