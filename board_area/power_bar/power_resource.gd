class_name PowerResource
extends Resource

signal power_depleted()

export(int) var current_power = 5
export(int) var max_power = 5

func reset_power() -> void:
	current_power = max_power

func decrease_power(variation: int) -> void:
	current_power -= variation
	if current_power <= 0:
		emit_signal("power_depleted")
		# TODO: remove this after 
		reset_power()

func increase_max_power(variation: int) -> void:
	max_power += variation

func decrease_max_power(variation: int) -> void:
	max_power -= variation
