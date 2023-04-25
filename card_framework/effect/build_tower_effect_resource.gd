class_name BuildTowerEffectResource
extends EffectResource

@export var tower_resource: TowerResource = preload("res://encounter/tower/resources/basic_tower.tres")
@export var tower: PackedScene = preload("res://encounter/tower/tower.tscn")

func apply_effect(args: Dictionary) -> void:
	var place = args.target
	var instance = tower.instantiate()
	instance.resource = tower_resource
	place.add_child(instance)
	instance.global_position = place.global_position

