class_name PowerResource
extends Resource

signal power_restored()
signal power_depleted()
signal max_power_changed(num_power)

export(int) var current_power = 5
export(int) var max_power = 5

func reset_power() -> void:
	current_power = max_power
	emit_signal("power_restored")

func decrease_power(variation: int) -> void:
	current_power -= variation
	if current_power <= 0:
		emit_signal("power_depleted")

func increase_power(variation: int) -> void:
	current_power += variation

func increase_max_power(variation: int) -> void:
	max_power += variation
	emit_signal("max_power_changed", max_power)

func decrease_max_power(variation: int) -> void:
	max_power -= variation
	emit_signal("max_power_changed", max_power)
