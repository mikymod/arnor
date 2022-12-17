class_name EffectResource
extends Resource

enum Target { place, tower, none }

export(PackedScene) var effect_scene
export(String) var description
export(Target) var target
export(int, LAYERS_2D_PHYSICS) var layer_mask
