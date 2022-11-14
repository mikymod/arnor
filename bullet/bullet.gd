class_name Bullet
extends Area2D

export var velocity: float = 1
export var damage: float = 1

func _process(delta: float) -> void:
	global_position += Vector2.RIGHT * velocity * delta;

func _on_Bullet_body_entered(body: Node):
	if (body.is_in_group("enemies")):
		body.hit(damage)
	queue_free()


	