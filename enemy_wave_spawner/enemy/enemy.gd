class_name Enemy
extends RigidBody2D

export(Resource) var enemy_resource;

onready var state_machine = $StateMachine

var health: float = 1.0

func _ready() -> void:
	health = enemy_resource.health

func hit(damage: float) -> void:
	state_machine.transition_to("Hit", {"damage": damage})

func deal_damage(damage: float) -> void:
	health -= damage

func change_speed(new_speed: float) -> void:
	self.linear_velocity = new_speed * Vector2.LEFT

func change_speed_rate(rate: float) -> void:
	rate = clamp(rate, 0, 1.0)
	self.linear_velocity = enemy_resource.speed  * (1 - rate) * Vector2.LEFT

func reset_speed() -> void:
	self.linear_velocity = enemy_resource.speed * Vector2.LEFT

func _on_Enemy_body_entered(body):
	if body is Tower:
		state_machine.transition_to("Attack")

