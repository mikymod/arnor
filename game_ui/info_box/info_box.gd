extends Control

@export var card_events: CardEvents
@export var effect_events: EffectEvents

func _ready() -> void:
	effect_events.connect("effect_started",Callable(self,"_on_effect_started"))
	effect_events.connect("effect_prepared",Callable(self,"_on_effect_prepared"))
	card_events.connect("card_returned",Callable(self,"_on_card_returned"))
	visible = false

func _on_effect_started(card, effect) -> void:
	visible = true
	$ColorRect/RichTextLabel.text = "[center]{hint}[/center]".format({"hint": effect.resource.hint})

func _on_effect_prepared(_card, effect, _target) -> void:
	visible = false

func _on_card_returned(card) -> void:
	visible = false

