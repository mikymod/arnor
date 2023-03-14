class_name BuffEffectResource
extends EffectResource

@export var damage: float = 1
@export var health: float = 1
@export var shoot_rate: float = 1
@export var armor: float = 0

@export var bullet_resource: Resource

@export var base: Texture2D
@export var body1: Texture2D
@export var body2: Texture2D
@export var roof: Texture2D

func apply_effect(args: Dictionary) -> void:
	var tower = args.target
	if tower.has_method("add_effect"):
		tower.add_effect(self)
	
	if tower.has_method("change_skin"):
		tower.change_skin(base, body1, body2, roof)
