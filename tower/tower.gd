class_name Tower
extends KinematicBody2D

export var damage_per_hit : float = 1
export var shoot_rate: float = 1			# number of bullets per second
export var shoot_range: float = 200
export var max_target: int = 1
export var num_bullets: int = 10
export var bullet_res: PackedScene

onready var _timer: Timer = $ShootTimer
onready var _shoot_area: Area2D = $ShootTriggerArea

var weight: float = 0

func _ready() -> void:
	_timer.wait_time /= shoot_rate
	_timer.paused = true

func _fire_bullet() -> void:
	var bullet = bullet_res.instance()
	add_child(bullet)
	bullet.global_position = $ShootPoint.global_position

func _on_ShootArea_body_entered(_body: Node):
	if _timer.paused:
		_timer.paused = false
	
func _on_ShootTimer_timeout():
	var bodies = _shoot_area.get_overlapping_bodies()
	if (bodies.size() == 0):
		_timer.paused = true
	else:
		_fire_bullet()

