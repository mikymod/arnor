class_name Enemy
extends RigidBody2D

export(Resource) var enemy_resource
export(Resource) var enemy_events

onready var state_machine = $StateMachine

var health: float = 1.0
var colliding_body

func _ready() -> void:
	health = enemy_resource.health

func hit(damage: float) -> void:
	if health > 0:
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
		colliding_body = body
		state_machine.transition_to("Attack")

func _on_Enemy_body_exited(body):
		colliding_body = null

func try_attack() -> void:
	var attack_area = $Sprites/AttackSprite/Attack
	var bodies = attack_area.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage"):
			body.take_damage(enemy_resource.damage)




