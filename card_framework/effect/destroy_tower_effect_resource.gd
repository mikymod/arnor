class_name DestroyTowerEffectResource
extends EffectResource

func apply_effect(args: Dictionary):
	var tower = args.target
	tower.queue_free()
