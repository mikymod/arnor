## A place where a tower can be built
class_name Place
extends Area2D

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _collision_shape: CollisionShape2D = $CollisionShape2D
@onready var _material = preload("res://encounter/place/place_targetted_material.tres")

var mouse_over: bool = false
var available: bool = true
var _start_child_count: int

func _ready() -> void:
	_start_child_count = get_child_count()

func _process(_delta: float) -> void:
	if get_child_count() > _start_child_count:
		_collision_shape.disabled = true
	else:
		_collision_shape.disabled = false
		
	if mouse_over:
		_sprite.modulate.a = 1
	else:
		_sprite.modulate.a = 0.5

func set_targetted(value: bool) -> void:
	if value:
		_collision_shape.disabled = true
		_sprite.material = _material
	else:
		_collision_shape.disabled = false
		_sprite.material = null

#func disable_collision() -> void:
#	_collision_shape.disabled = true
#	_sprite.material = _material
#
#func enable_collision() -> void:
#	_collision_shape.disabled = false
#	_sprite.material = null
	
func _on_Place_mouse_entered():
	mouse_over = true
	
func _on_Place_mouse_exited():
	mouse_over = false

	
