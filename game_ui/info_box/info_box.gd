extends Control

export(Resource) var card_events

func _ready() -> void:
	card_events.connect("card_played", self, "_on_card_played")
	card_events.connect("target_selected", self, "_on_target_selected")
	visible = false

func _on_card_played(card) -> void:
	visible = true
	var effects_res = card.resource.effect_resources
	for effect in effects_res:
		if effect.collision_mask != 0:
			$ColorRect/RichTextLabel.bbcode_text = "[center]Select a target[/center]"

func _on_target_selected(target) -> void:
	visible = false
	$ColorRect/RichTextLabel.bbcode_text = ""
