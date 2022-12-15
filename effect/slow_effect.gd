extends Node

export(float) var slow_time
export(int) var slow_rate

var target: Node = null

func apply_effect() -> void:
	$Timer.wait_time = slow_time
	$Timer.one_shot = true
	$Timer.start()
	
	if target.has_method('change_speed_rate'):
		target.change_speed_rate(slow_rate)

func _on_timer_timeout():
	if target.has_method('reset_speed'):
		target.reset_speed()

