class_name Enemy
extends RigidBody2D

export(Resource) var resource;

var _health: float = 1.0

func _ready() -> void:
	_health = resource.health
	reset_speed()

func hit(damage: float) -> void:
	_health -= damage
	if (_health <= 0):
		queue_free()

func change_speed(new_speed: float) -> void:
	self.linear_velocity = new_speed * Vector2.LEFT

func change_speed_rate(rate: float) -> void:
	rate = clamp(rate, 0, 1.0)
	self.linear_velocity = resource.speed  * (1 - rate) * Vector2.LEFT

func reset_speed() -> void:
	self.linear_velocity = resource.speed * Vector2.LEFT

