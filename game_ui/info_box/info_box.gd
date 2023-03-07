extends Control

export(Resource) var card_events
export(Resource) var effect_events

func _ready() -> void:
	effect_events.connect("effect_started", self, "_on_effect_started")
	effect_events.connect("effect_prepared", self, "_on_effect_prepared")
	card_events.connect("card_returned", self, "_on_card_returned")
	visible = false

func _on_effect_started(card, effect) -> void:
	visible = true
	$ColorRect/RichTextLabel.bbcode_text = "[center]{hint}[/center]".format({"hint": effect.resource.hint})

func _on_effect_prepared(_card, effect, _target) -> void:
	visible = false

func _on_card_returned(card) -> void:
	visible = false

