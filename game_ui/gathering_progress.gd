class_name GatheringBar
extends Control

## A progress bar that shows the gathering progress.

## The signal emitted when gathering is started
signal gathering_started()
## The signal emitted when gathering is stopped
signal gathering_stopped()

## The time to perform gathering
@export var wait_time: float = 5 

@onready var _progress_bar: ProgressBar = $ProgressBar
@onready var _timer: Timer = $Timer

## Starts the progress
func start() -> void:
	_progress_bar.max_value = wait_time
	visible = true
	_timer.start(wait_time)
	gathering_started.emit()

## Stops the progress
func stop() -> void:
	visible = false
	_progress_bar.value = 0
	_timer.stop()
	gathering_stopped.emit()
	
func _process(delta: float) -> void:
	_progress_bar.value = _timer.wait_time - _timer.time_left
	
func _on_timer_timeout() -> void:
	stop()
