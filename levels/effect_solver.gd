extends Node

export(Resource) var card_events
export(Resource) var effect_events
export(PackedScene) var effect_scene

var arrow_target

var card: Card
var effects_to_solve: Array = []
var effect_index = 0

func _ready() -> void:
	card_events.connect("card_played", self, "_on_card_played")
	card_events.connect("card_returned", self, "_on_card_returned")
	effect_events.connect("effect_prepared", self, "_on_effect_prepared")

func _on_card_played(card: Card) -> void:
	self.card = card
	_enqueue_effect(card, card.resource.effect_resources[effect_index])

func _on_card_returned(played_card: Card) -> void:
	_reset()

func _on_effect_prepared(card, effect, target) -> void:
	effects_to_solve.append({"effect": effect, "target": target.collider if target != null else null})
	effect_index += 1
	if effect_index >= card.resource.effect_resources.size():
		_resolve_effects()
	else:
		_enqueue_effect(card, card.resource.effect_resources[effect_index])
		
func _enqueue_effect(card, effect_res) -> void:
	var current_effect = effect_scene.instance()
	current_effect.start(card, effect_res)
	add_child(current_effect)

func _resolve_effects() -> void:
	for element in effects_to_solve:
		var effect = element.effect
		effect.resource.apply_effect({"target": element.target})
		remove_child(effect)
		effect.stop()
	
	card_events.emit_signal("card_resolved", card)
	_reset()

func _reset() -> void:
	card = null
	effect_index = 0
	effects_to_solve.clear()
	
