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

export(String) var name = ''
export(int) var cost = 0
export(Rarity) var rarity = Rarity.common

export(Texture) var background_frame = preload("res://card/textures/background_frame.png")
export(Color) var background_frame_color = Color("848484")

export(Texture) var foreground_frame = preload("res://card/textures/foreground_frame.png")

export(Texture) var name_frame = preload("res://card/textures/name_frame.png")
export(Color) var name_frame_color = Color("ffe8a1")

export(Texture) var cost_frame = preload("res://card/textures/cost_frame.png")
export(Color) var cost_frame_color = Color("848484")

export(Texture) var description_frame = preload("res://card/textures/description_frame.png")
export(Color) var description_frame_color = Color("ffe8a1")

export(Texture) var rarity_frame = preload("res://card/textures/rarity_frame.png")
export(Color) var rarity_frame_color = Color("848484")

export(Array, Resource) var effect_resources
