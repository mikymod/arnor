extends KinematicBody2D
class_name Enemy

export var health: float = 10
export var speed: float = 10

func _physics_process(delta) -> void:
	var collision = move_and_collide(Vector2.LEFT * speed * delta)
	if (collision):
		if (collision.collider is Bullet):
			print("I collided with Bullet")

		if (collision.collider is Tower):
			print("I collided with Tower")
