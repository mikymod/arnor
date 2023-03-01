class_name BuffEffectResource
extends EffectResource

export(float) var damage: float = 1
export(float) var health: float = 1
export(float) var shoot_rate: float = 1
export(float) var armor: float = 0

export(Resource) var bullet_resource

export(Texture) var base
export(Texture) var body1
export(Texture) var body2
export(Texture) var roof

func apply_effect(args: Dictionary) -> void:
	var tower = args.target
	if tower.has_method("add_effect"):
		tower.add_effect(self)
	
	if tower.has_method("change_skin"):
		tower.change_skin(base, body1, body2, roof)
