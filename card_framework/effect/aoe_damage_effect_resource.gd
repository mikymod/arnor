class_name AoeDamageEffectResource
extends EffectResource

@export var damage: float = 4
@export var enemy_events: Resource = preload("res://encounter/enemy/enemy_events.tres") 

func apply_effect(args: Dictionary) -> void:
	enemy_events.enemy_damaged.emit(damage)
