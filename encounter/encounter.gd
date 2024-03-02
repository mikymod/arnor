class_name Encounter
extends Node

signal started()
signal finished()
signal failed()

func start() -> void:
	started.emit()

func finish() -> void:
	finished.emit()

func game_over() -> void:
	failed.emit()
