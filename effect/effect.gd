class_name Effect
extends Node

signal target_selected(target)

@export var resource: EffectResource
@export var effect_events: EffectEvents = preload("res://effect/effect_events.tres")
@export var card_events: CardEvents = preload("res://card/card_events.tres")
@export var target_arrow_scene: PackedScene 

var card: Card
var arrow_target
var target

func _ready() -> void:
	connect("target_selected",Callable(self,"_on_target_selected"))
	card_events.connect("card_returned",Callable(self,"_on_card_returned"))

func init(card, resource) -> void:
	self.card = card
	self.resource = resource

func start() -> void:
	effect_events.emit_signal("effect_started", card, self)
	if resource.collision_mask != 0:
		spawn_arrow_target()
	else:
		await get_tree().create_timer(0.1).timeout # wait untill all card_played Callbles are done
		_prepare_effect(null)

func stop() -> void:
	queue_free()

func spawn_arrow_target() -> void:
	arrow_target = target_arrow_scene.instantiate()
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
