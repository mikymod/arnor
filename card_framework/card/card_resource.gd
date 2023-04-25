class_name CardResource
extends Resource

## Data container for cards.
##
## Each CardResource instance represents a different card.

enum Rarity {
	common,
	uncommon,
	rare,
}

@export var name: String = ''
@export var cost: int = 0
@export var rarity: Rarity = Rarity.common

@export var background_frame: Texture2D = preload("res://card_framework/card/textures/background_frame.png")
@export var background_frame_color: Color = Color("848484")

@export var foreground_frame: Texture2D = preload("res://card_framework/card/textures/foreground_frame.png")

@export var name_frame: Texture2D = preload("res://card_framework/card/textures/name_frame.png")
@export var name_frame_color: Color = Color("ffe8a1")

@export var cost_frame: Texture2D = preload("res://card_framework/card/textures/cost_frame.png")
@export var cost_frame_color: Color = Color("848484")

@export var description_frame: Texture2D = preload("res://card_framework/card/textures/description_frame.png")
@export var description_frame_color: Color = Color("ffe8a1")

@export var rarity_frame: Texture2D = preload("res://card_framework/card/textures/rarity_frame.png")
@export var rarity_frame_color: Color = Color("848484")

@export var effect_resources: Array[EffectResource]
@export var exhaust: bool = false
