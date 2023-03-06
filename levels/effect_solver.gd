extends Node

export(Resource) var card_events
export(Resource) var effect_events
export(PackedScene) var effect_scene

var arrow_target

var card: Card
var effects: Array = []
var effect_index = 0

func _ready() -> void:
	card_events.connect("card_played", self, "_on_card_played")
	card_events.connect("card_returned", self, "_on_card_returned")
	effect_events.connect("effect_prepared", self, "_on_effect_prepared")

func _on_card_played(card: Card) -> void:
	self.card = card
	_enqueue_effects(card)
	_start_next_effect()

func _enqueue_effects(card) -> void:
	for effect_res in card.resource.effect_resources:
		var current_effect = effect_scene.instance()
		current_effect.init(card, effect_res)
		add_child(current_effect)
		
func _start_next_effect() -> void:
	get_children()[effect_index].start()

func _on_card_returned(played_card: Card) -> void:
	_reset()

func _on_effect_prepared(card, effect, target) -> void:
	var children = get_children()
	children[effect_index].target = target.collider if target != null else null
	effect_index += 1
	if effect_index >= children.size():
		_resolve_effects()
	else:
		_start_next_effect()

func _resolve_effects() -> void:
	for effect in get_children():
		effect.resource.apply_effect({"target": effect.target})
		remove_child(effect)
		effect.stop()
	card_events.emit_signal("card_resolved", card)
	_reset()

func _reset() -> void:
	card = null
	effect_index = 0
	effects.clear()
