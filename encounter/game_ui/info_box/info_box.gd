extends Control

@export var card_events: CardEvents
@export var effect_events: EffectEvents

func _ready() -> void:
	effect_events.effect_started.connect(_on_effect_started)
	effect_events.effect_prepared.connect(_on_effect_prepared)
	card_events.card_returned.connect(_on_card_returned)
	visible = false

func _on_effect_started(card, effect) -> void:
	visible = true
	$ColorRect/RichTextLabel.text = "[center]{hint}[/center]".format({"hint": effect.resource.hint})

func _on_effect_prepared(_card, effect, _target) -> void:
	visible = false

func _on_card_returned(card) -> void:
	visible = false

