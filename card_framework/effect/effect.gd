class_name Effect
extends Node

signal target_selected(target)

@export var resource: EffectResource
@export var effect_events: EffectEvents = preload("res://card_framework/effect/effect_events.tres")
@export var card_events: CardEvents = preload("res://card_framework/card/card_events.tres")
@export var target_arrow_scene: PackedScene 

var card: Card
var arrow_target
var target

func _ready() -> void:
	self.target_selected.connect(_on_target_selected)
	card_events.card_returned.connect(_on_card_returned)

func init(card, resource) -> void:
	self.card = card
	self.resource = resource

func start() -> void:
	effect_events.effect_started.emit(card, self)
	if resource.collision_mask != 0:
		spawn_arrow_target()
	else:
		await get_tree().create_timer(0.1).timeout # wait untill all card_played Callbles are done
		_prepare_effect(null)

func stop() -> void:
	if target and target.has_method("set_targetted"):
		target.set_targetted(false)
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
	if target.collider.has_method("set_targetted"):
		target.collider.set_targetted(true)
	dispose_arrow_target()
	_prepare_effect(target)

func _on_card_returned(card: Card) -> void:
	stop()

func _prepare_effect(target) -> void:
	effect_events.effect_prepared.emit(card, self, target)
