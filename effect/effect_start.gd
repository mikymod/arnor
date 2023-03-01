extends State

export(NodePath) var effect_node_path
export(Resource) var effect_events

onready var effect = get_node(effect_node_path)

func enter(_msg := {}) -> void:
	effect_events.emit_signal("effect_started", effect.card, effect.resource)
	
	if effect.resource.has_condition(): 
		state_machine.transition_to("Prepare")
	else:
		state_machine.transition_to("Solve")

#func handle_input(_event: InputEvent) -> void:
#	pass
#
#func update(_delta: float) -> void:
#	pass
#
#func physics_update(_delta: float) -> void:
#	pass
#
#func exit() -> void:
#	pass
