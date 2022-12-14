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
export(String) var description = ''
export(Texture) var background
export(Texture) var foreground

export(Array, Resource) var effect_resources
