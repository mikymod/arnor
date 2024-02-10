extends Node2D

@export var speed: float = 500
@export var target: Node2D

var _target_pos: Vector2

func _ready() -> void:
	if target != null:
		_target_pos = target.global_position

func _process(delta: float) -> void:
	var angle = get_angle_to(_target_pos)
	var direction = global_position.direction_to(_target_pos)
	rotate(angle)
	global_position += direction * delta * speed
	if abs(global_position.distance_to(_target_pos)) < 50:
		queue_free()

