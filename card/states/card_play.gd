class_name CardPlay
extends State

## Card play
##
## The play state of Card's state machine

export var root_path: NodePath
onready var card: Node2D = get_node(root_path)

func enter(_msg := {}) -> void:
	for resource in card.resource.effect_resources:
		var instance = resource.effect_scene.instance()
		instance.parent = state_machine.place
		instance.apply_effect()

	card.emit_signal("card_played", card)
	state_machine.transition_to("Inactive")
