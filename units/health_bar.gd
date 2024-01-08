class_name HealthBar
extends Control

@onready var _progress_bar: ProgressBar = $ProgressBar

func init(health: int) -> void:
	_progress_bar.min_value = 0
	_progress_bar.max_value = health
	_progress_bar.value = health

func set_health(value: float) -> void:
	_progress_bar.value = value


