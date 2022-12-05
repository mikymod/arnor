class_name CardPlay
extends State	

export var root_path: NodePath
onready var card: Node2D = get_node(root_path)

func enter(_msg := {}) -> void:
	var new_tower = card.data.object.instance()
	state_machine.place.add_child(new_tower)
	new_tower.global_position = state_machine.place.global_position
	card.emit_signal("card_played", card)
	# # TODO: should be placed in the discard pile
	# root.queue_free()
