class_name GatherResource
extends Resource

signal resource_changed()

@export var value: int = 0

func add(amount: int) -> void:
	value += amount
	resource_changed.emit()
