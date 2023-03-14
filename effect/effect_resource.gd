class_name EffectResource
extends Resource

# The layer that interact with the effect
@export_flags_2d_physics var collision_mask: int = 0
# The description of the effect
@export var description: String = ""
# The hint of the effect showed on infobox
@export var hint: String = ""


func has_condition() -> bool:
	return collision_mask != 0
