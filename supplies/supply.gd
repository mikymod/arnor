class_name Supply
extends Resource

## A supply resource.

signal resource_changed()

@export var value: int = 0

## Adds the amount to the supply
func add(amount: int) -> void:
	value += amount
	resource_changed.emit()
