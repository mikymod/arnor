extends Node

export(Resource) var card_events
export(PackedScene) var target_arrow_scene

var card: Card
var arrow_target

var effects: Array = []

func _ready() -> void:
	card_events.connect("card_played", self, "_on_card_played")
	card_events.connect("card_returned", self, "_on_card_returned")

func _on_card_played(played_card: Card) -> void:
	card = played_card
	_enqueue_effect(card.resource.effect_resources)

func _on_card_returned(played_card: Card) -> void:
	card = null
	effects.clear()
	_dispose_arrow_target()

func _enqueue_effect(effect_list) -> void:
	var args = {}
	for effect in effect_list:
		var target
		if effect.collision_mask != 0:
			_spawn_arrow_target(effect)
			target = yield(card_events, "target_selected")
			_dispose_arrow_target()
		effects.append({"effect": effect, "target": target.collider if target != null else null})
	_resolve_effects()

func _resolve_effects() -> void:
	for effect in effects:
		var e = effect.effect
		if e.has_method("apply_effect"):
			e.apply_effect({"target": effect.target})
	
	card_events.emit_signal("card_resolved", card)
	if card.resource.exhaust:
		card_events.emit_signal("card_exhausted", card)
	else:
		card_events.emit_signal("card_discarded", card)
	effects.clear()

func _spawn_arrow_target(effect) -> void:
	arrow_target = target_arrow_scene.instance()
	add_child(arrow_target)
	arrow_target.init(card, card.global_position, effect.collision_mask)

func _dispose_arrow_target() -> void:
	if not arrow_target: return
	remove_child(arrow_target)
	arrow_target.queue_free()
	arrow_target = null
