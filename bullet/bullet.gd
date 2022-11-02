class_name Bullet
extends Area2D

export var velocity: float = 1
export var damage: float = 1

func _ready() -> void:
	global_position = Vector2.INF
	$CollisionShape2D.disabled = true
	set_process(false)
	hide()

func _process(delta: float) -> void:
	global_position += Vector2.RIGHT * velocity * delta;

func shoot(initial_position: Vector2) -> void:
	global_position = initial_position
	$CollisionShape2D.disabled = false
	set_process(true)
	show()

func _on_Bullet_body_entered(body: Node):
	$CollisionShape2D.disabled = true
	set_process(false)
	hide()

	if (body.is_in_group("enemies")):
		body.hit(damage)

	