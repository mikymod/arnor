class_name Tower
extends KinematicBody2D

export var damage_per_hit : float = 1
export var shoot_rate: float = 1			# number of bullets per second
export var shoot_range: float = 200
export var max_target: int = 1
export var num_bullets: int = 10
export var bullet_res: PackedScene

onready var _timer: Timer = $ShootTimer

var _bullets_pool: Array
var _current_index: int = 0

var weight: float = 0

func _ready() -> void:
	_spawn_bullets()
			
func _spawn_bullets() -> void:
	for _i in range(num_bullets):
		var bullet = bullet_res.instance()
		_bullets_pool.append(bullet)
		add_child(bullet)

func _fire_bullet() -> void:
	var bullet = _bullets_pool[_current_index % num_bullets]
	bullet.call('shoot', $ShootPoint.global_position)
	_current_index += 1

func _on_ShootArea_body_entered(_body: Node):
	_timer.wait_time /= shoot_rate
	_timer.start()
	
func _on_ShootTimer_timeout():
	_fire_bullet()
