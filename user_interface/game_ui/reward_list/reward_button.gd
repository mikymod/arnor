class_name RewardButton
extends TextureButton

func init(icon: Texture2D, text: String) -> void:
	$HBoxContainer/TextureRect.texture = icon
	$HBoxContainer/Label.text = text
