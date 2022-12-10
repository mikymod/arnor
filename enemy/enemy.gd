class_name Enemy
extends RigidBody2D

export(Resource) var resource;

var _health: float = 1.0
var _speed: float = 1.0

func _ready() -> void:
	print('enemy ready called')
	_health = resource.health
	self.linear_velocity = resource.speed * Vector2.LEFT

func hit(damage: float) -> void:
	print("I collided with Bullet")
	_health -= damage
	if (_health <= 0):
		queue_free()

	# if (body is Tower):
	# 	print("I collided with Tower")
