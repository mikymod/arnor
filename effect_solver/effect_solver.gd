class_name EffectSolver
extends Node2D

export(Resource) var hand_resource

var stack: Array = []

func _ready() -> void:
	hand_resource.connect('card_played', self, '_on_card_played')
	$TargetSelector.set_physics_process(false)

func _on_card_played(card) -> void:
	for effect_resource in card.resource.effect_resources:
		$TargetSelector.set_physics_process(true)
		var state = yield($TargetSelector, "target_selected")
		$TargetSelector.set_physics_process(false)
		var target = state.collider
		var effect = effect_resource.effect_scene.instance()
		if effect.has_method('apply_effect'):
			effect.apply_effect(target)

func wait_for_target() -> void:
	pass
