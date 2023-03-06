class_name Effect
extends Node

signal target_selected(target)

export(Resource) var resource
export(Resource) var effect_events
export(Resource) var card_events
export(PackedScene) var target_arrow_scene

var card: Card
var arrow_target

func _ready() -> void:
	connect("target_selected", self, "_on_target_selected")
	card_events.connect("card_returned", self, "_on_card_returned")

func start(card, resource) -> void:
	self.card = card
	self.resource = resource
	if resource.collision_mask != 0:
		spawn_arrow_target()
	else:
		_prepare_effect(null)

func stop() -> void:
	queue_free()

func spawn_arrow_target() -> void:
	arrow_target = target_arrow_scene.instance()
	add_child(arrow_target)
	arrow_target.init(card, self, card.global_position, resource.collision_mask)

func dispose_arrow_target() -> void:
	remove_child(arrow_target)
	arrow_target.queue_free()
	arrow_target = null

func _on_target_selected(target) -> void:
	dispose_arrow_target()
	_prepare_effect(target)

func _on_card_returned(card: Card) -> void:
	stop()

func _prepare_effect(target) -> void:
	effect_events.emit_signal("effect_prepared", card, self, target)
