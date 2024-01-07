class_name GatheringProgress
extends Control

signal gathering_started()
signal gathering_stopped()

@export var wait_time: float = 5

@onready var _progress_bar: ProgressBar = $ProgressBar
@onready var _timer: Timer = $Timer

func start() -> void:
	_progress_bar.max_value = wait_time
	visible = true
	_timer.start(wait_time)
	gathering_started.emit()

func stop() -> void:
	visible = false
	_progress_bar.value = 0
	_timer.stop()
	gathering_stopped.emit()
	
func _process(delta: float) -> void:
	_progress_bar.value = _timer.wait_time - _timer.time_left
	
func _on_timer_timeout() -> void:
	stop()
