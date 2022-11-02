class_name Enemy
extends RigidBody2D

export var health: float = 10
export var speed: float = 10

# func _physics_process(delta) -> void:
# 	global_position += Vector2.LEFT * speed * delta

func hit(damage: float) -> void:
	print("I collided with Bullet")
	health -= damage
	if (health <= 0):
		queue_free()

	# if (body is Tower):
	# 	print("I collided with Tower")
