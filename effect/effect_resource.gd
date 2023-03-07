class_name EffectResource
extends Resource

# The layer that interact with the effect
export(int, LAYERS_2D_PHYSICS) var collision_mask
# The description of the effect
export(String) var description
# The hint of the effect showed on infobox
export(String) var hint

func has_condition() -> bool:
	return collision_mask != 0
