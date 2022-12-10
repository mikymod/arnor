class_name CardPlay
extends State	

## Card play
##
## The play state of Card's state machine

export var root_path: NodePath
onready var card: Node2D = get_node(root_path)

func enter(_msg := {}) -> void:
	var new_tower = card.resource.tower.instance()
	new_tower.resource = card.resource.tower_resource
	state_machine.place.add_child(new_tower)
	new_tower.global_position = state_machine.place.global_position
	card.emit_signal("card_played", card)
	state_machine.transition_to("Inactive")

