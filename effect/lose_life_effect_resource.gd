class_name LoseLifeEffectResource
extends EffectResource

export(int) var life
export(Resource) var player_resource = preload("res://player/player_resource.tres")

func apply_effect(args: Dictionary) -> void:
	player_resource.change_health(-life)
