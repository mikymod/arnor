extends KinematicBody2D
class_name Bullet

export var velocity: float = 1

func _ready() -> void:
	global_position = Vector2.INF
	# set_deferred("disabled", true)
	$CollisionShape2D.disabled = true
	set_physics_process(false)
	hide()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(Vector2.RIGHT * velocity * delta)
	if (collision):
		print("I collided with Enemy")
		# set_deferred("disabled", true)
		$CollisionShape2D.disabled = true
		set_physics_process(false)
		hide()


func fire(initial_position: Vector2) -> void:
	global_position = initial_position
	# set_deferred("disabled", false)
	$CollisionShape2D.disabled = false
	set_physics_process(true)
	show()
