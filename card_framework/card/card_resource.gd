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
@export var description: String = ''
@export var cost: int = 0
@export var rarity: Rarity = Rarity.common
@export var color: Color = Color.WHITE

