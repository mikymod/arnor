class_name Tower
extends StaticBody2D

export(Resource) var resource # TowerResource
export(PackedScene) var bullet_scene

var _effects: Array = []

onready var _timer: Timer = $ShootTimer
onready var _shoot_area: Area2D = $ShootTriggerArea

var _damage: float = 0
var _health: float = 0
var _shoot_rate: float = 0
var _armor: float = 0

func _ready() -> void:
	change_stats(resource.damage, resource.health, resource.shoot_rate, resource.armor)
	change_skin(resource.base, resource.body1, resource.body2, resource.roof)
	_timer.wait_time = 1 / _shoot_rate
	_timer.paused = true
	
func _fire_bullet() -> void:
	var bullet = bullet_scene.instance()
	bullet.resource = resource.bullet_resource
	add_child(bullet)
	
	bullet.global_position = $ShootPoint.global_position
	bullet.damage = _damage

func _on_ShootArea_body_entered(_body: Node):
	_timer.wait_time = 1 / _shoot_rate
	if _timer.paused:
		_timer.paused = false

func _on_ShootTimer_timeout():
	var bodies = _shoot_area.get_overlapping_bodies()
	if (bodies.size() == 0):
		_timer.paused = true
	else:
		_fire_bullet()

func add_effect(effect: Resource) -> void:
	if effect == null:
		return
		
	_effects.append(effect)
	if effect.damage > 0:
		_damage += effect.damage
	if effect.health > 0:
		_health += effect.health
	if effect.shoot_rate > 0:
		_shoot_rate += effect.shoot_rate
	if effect.armor > 0:
		_armor += effect.armor

func change_stats(damage, health, shoot_rate, armor) -> void:
	_damage = damage
	_health = health
	_shoot_rate = shoot_rate
	_armor = armor

func change_skin(base: Texture, body1: Texture, body2: Texture, roof: Texture) -> void:
	if base != null: $Base.texture = base 
	if body1 != null: $Base/Body1.texture = body1
	if body2 != null: $Base/Body1/Body2.texture = body2
	if roof != null: $Base/Body1/Body2/Roof.texture = roof

func take_damage(damage: float) -> void:
	_health -= damage
	if (_health <= 0):
		queue_free()
		# TODO: state machine
