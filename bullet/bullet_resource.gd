class_name BulletResource
extends Resource

@export var texture: Texture2D
@export var velocity: float = 1
@export var damage: float = 1

func set_damage(new_damage: float) -> void:
	damage += new_damage

func increase_damage(variation: float) -> void:
	damage += variation

func set_velocity(new_velocity: float) -> void:
	velocity = new_velocity

func increase_velocity(variation: float) -> void:
	velocity += variation
