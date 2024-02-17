class_name Supply
extends Resource

## A supply resource.

signal supply_changed()
signal supply_depleted()

@export var value: float = 50
@export var max_value: int = 100
const min_value: int = 0

## Increases the amount of the supply
func increase(amount: float) -> void:
	value += amount if value <= max_value else max_value
	supply_changed.emit()

## Decreases the amount of the supply
func decrease(amount: float) -> void:
	value -= amount
	supply_changed.emit()
	if value <= min_value:
		value = min_value
		supply_depleted.emit()
