class_name LoseLifeEffectResource
extends EffectResource

@export var life: int
@export var player_resource: Resource = preload("res://encounter/player/player_resource.tres")

func apply_effect(args: Dictionary) -> void:
	player_resource.change_health(-life)
