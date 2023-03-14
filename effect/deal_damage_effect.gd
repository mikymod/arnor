class_name DealDamageEffectResource
extends EffectResource

@export var damage: int = 1

func apply_effect(args: Dictionary) -> void:
	var target = args.target
	if target.has_method("hit"):
		target.hit(damage)
