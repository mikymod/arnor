extends Control

export(Resource) var hand_resource
export(NodePath) var target_selector_path
var target_selector

func _ready() -> void:
	hand_resource.connect("card_played", self, "_on_card_played")
	if not target_selector_path.is_empty():
		target_selector = get_node(target_selector_path)
		target_selector.connect("target_selected", self, "_on_target_selected")
		
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
