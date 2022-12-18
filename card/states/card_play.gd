class_name CardPlay
extends State

## Card play
##
## The play state of Card's state machine

export(Resource) var hand_resource

export(NodePath) var root_path
onready var card: Node2D = get_node(root_path)

func enter(_msg := {}) -> void:
	hand_resource.play_card(card)
	state_machine.transition_to("Inactive")
