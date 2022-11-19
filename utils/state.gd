# Virtual base class for all states.
class_name State
extends Node2D

var state_machine = null

func enter(_msg := {}) -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass
