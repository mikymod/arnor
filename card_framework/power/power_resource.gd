class_name PowerResource
extends Resource

signal power_restored()
signal power_depleted()
signal max_power_changed(num_power)

@export var current_power: int = 5
@export var max_power: int = 5

func reset_power() -> void:
	current_power = max_power
	power_restored.emit()

func decrease_power(variation: int) -> void:
	current_power -= variation
	if current_power <= 0:
		power_depleted.emit()

func increase_power(variation: int) -> void:
	current_power += variation

func increase_max_power(variation: int) -> void:
	max_power += variation
	max_power_changed.emit(max_power)

func decrease_max_power(variation: int) -> void:
	max_power -= variation
	max_power_changed.emit(max_power)
