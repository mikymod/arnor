extends State

export(NodePath) var effect_node_path
export(Resource) var effect_events
export(PackedScene) var target_arrow_scene

var arrow_target
onready var effect = get_node(effect_node_path)

func enter(_msg := {}) -> void:
	effect_events.connect("target_selected", self, "_on_target_selected")
	_spawn_arrow_target(effect)

func _on_target_selected(target) -> void:
	effect_events.emit_signal("effect_prepared", effect.card, effect.resource, target)
	state_machine.transition_to("Solve")

func exit() -> void:
	_dispose_arrow_target()

func _spawn_arrow_target(effect: Effect) -> void:
	arrow_target = target_arrow_scene.instance()
	add_child(arrow_target)
	arrow_target.init(effect.card, effect.card.global_position, effect.resource.collision_mask)

func _dispose_arrow_target() -> void:
	if not arrow_target: return
	remove_child(arrow_target)
	arrow_target.queue_free()
	arrow_target = null
