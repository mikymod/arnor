class_name EffectResource
extends Resource

export(String) var description
export(int, LAYERS_2D_PHYSICS) var collision_mask

func has_condition() -> bool:
	return collision_mask != 0
