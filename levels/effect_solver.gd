extends Node

@export var card_events: CardEvents
@export var effect_events: EffectEvents
@export var effect_scene: PackedScene

var arrow_target

var card: Card
var effect_index: int = 0

func _ready() -> void:
	card_events.card_played.connect(_on_card_played)
	card_events.card_returned.connect(_on_card_returned)
	effect_events.effect_prepared.connect(_on_effect_prepared)

func _on_card_played(card: Card) -> void:
	self.card = card
	_enqueue_effects(card)
	_start_next_effect()

func _enqueue_effects(card) -> void:
	for effect_res in card.resource.effect_resources:
		var current_effect = effect_scene.instantiate()
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
	card_events.card_resolved.emit(card)
	_reset()

func _reset() -> void:
	card = null
	effect_index = 0

