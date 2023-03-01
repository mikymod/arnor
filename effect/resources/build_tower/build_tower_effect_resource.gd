class_name BuildTowerEffectResource
extends EffectResource

export(Resource) var tower_resource
export(PackedScene) var tower

func apply_effect(args: Dictionary) -> void:
	var place = args.target
	var instance = tower.instance()
	instance.resource = tower_resource
	place.get_parent().add_child(instance)
	instance.global_position = place.global_position
	place.queue_free()
