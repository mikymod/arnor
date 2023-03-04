extends State

export(NodePath) var effect_node_path
export(Resource) var effect_events

onready var effect = get_node(effect_node_path)

func enter(_msg := {}) -> void:
	effect_events.emit_signal("effect_solved", effect.card, effect.resource)
	effect.queue_free()
