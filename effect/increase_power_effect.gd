class_name IncreasePowerEffect
extends EffectResource

@export var num_power: int = 1
@export var power_resource: PowerResource = preload("res://power_bar/power_resource.tres")

func apply_effect(args: Dictionary) -> void:
	power_resource.increase_max_power(num_power)
