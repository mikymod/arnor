class_name Tower
extends KinematicBody2D

export(Resource) var resource # TowerResource
export(PackedScene) var bullet_scene

onready var _timer: Timer = $ShootTimer
onready var _shoot_area: Area2D = $ShootTriggerArea

func _ready() -> void:
	_timer.wait_time /= resource.shoot_rate
	_timer.paused = true
	$Base.texture = resource.base
	$Base/Body1.texture = resource.body1
	$Base/Body1/Body2.texture = resource.body2
	$Base/Body1/Body2/Roof.texture = resource.roof

func _fire_bullet() -> void:
	var bullet = bullet_scene.instance()
	bullet.resource = resource.bullet_resource
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

