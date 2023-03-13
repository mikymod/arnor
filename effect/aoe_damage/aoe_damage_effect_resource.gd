class_name AoeDamageEffectResource
extends EffectResource

export(float) var damage = 4
export(Resource) var enemy_events = preload("res://enemy/events/enemy_events.tres") 

func apply_effect(args: Dictionary) -> void:
	enemy_events.emit_signal("enemy_damaged", damage)
