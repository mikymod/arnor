class_name CardPlay
extends State

## Card play
##
## The play state of Card's state machine

export(Resource) var card_events

export(NodePath) var root_path
onready var card: Node2D = get_node(root_path)

func enter(_msg := {}) -> void:
	card_events.emit_signal("card_played", card)

