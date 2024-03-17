# RewardButton is a custom class that extends TextureButton.
# It represents a button used for displaying rewards in the game UI.

class_name RewardButton
extends TextureButton

# Initializes the RewardButton with the specified icon and text.
# Parameters:
#   - icon: The icon texture to be displayed on the button.
#   - text: The text to be displayed on the button.
func init(icon: Texture2D, text: String) -> void:
	$HBoxContainer/TextureRect.texture = icon
	$HBoxContainer/Label.text = text
