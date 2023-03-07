class_name EffectResource
extends Resource

export(int, LAYERS_2D_PHYSICS) var collision_mask
export(String) var description
export(String) var hint

func has_condition() -> bool:
	return collision_mask != 0
