class_name CardPlay
extends State

func enter(_msg := {}) -> void:
	var new_tower = state_machine.root.card_data.object.instance()
	state_machine.place.add_child(new_tower)
	new_tower.global_position = state_machine.place.global_position
	state_machine.root.queue_free()
