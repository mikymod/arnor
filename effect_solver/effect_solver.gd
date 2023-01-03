class_name EffectSolver
extends Node2D

signal effect_solved()
signal card_solved(card)

export(Resource) var hand_resource

func _ready() -> void:
	hand_resource.connect('card_played', self, '_on_card_played')
	$TargetSelector.set_physics_process(false)

func _on_card_played(card) -> void:
	var args = {}
	for effect_resource in card.resource.effect_resources:
		if effect_resource.collision_mask != 0x00000000:
			$TargetSelector.collision_mask = effect_resource.collision_mask
			$TargetSelector.set_physics_process(true)
			var state = yield($TargetSelector, "target_selected")
			$TargetSelector.set_physics_process(false)
			args.target = state.collider

		if effect_resource.has_method("apply_effect"):
			effect_resource.apply_effect(args)
		emit_signal("effect_solved")
	emit_signal("card_solved", card)
