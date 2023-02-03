extends State

## Card solve state
##
## The solve state of Card's state machine

export(Resource) var card_events

export var card_path: NodePath
onready var card: Node2D = get_node(card_path)

func enter(_msg := {}) -> void:
	var args = {}
	for effect_resource in card.resource.effect_resources:
		if effect_resource.collision_mask != 0x00000000:
			$TargetSelector.collision_mask = effect_resource.collision_mask
			$TargetSelector.set_physics_process(true)
			var state = yield(card_events, "target_selected")
			$TargetSelector.set_physics_process(false)
			args.target = state.collider

		if effect_resource.has_method("apply_effect"):
			effect_resource.apply_effect(args)
	card_events.emit_signal("card_solved", card)
	if (card.resource.exhaust):
		card_events.emit_signal("card_exhausted", card)
	else:
		card_events.emit_signal("card_discarded", card)
