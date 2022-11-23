"""
Data container for cards.
Each CardResource instance represents a different card
"""
class_name CardResource
extends Resource

enum Rarity { common, uncommon, rare }

export var cost: int = 0
export(Rarity) var rarity = Rarity.common
export var name: String = ''
export var description: String = ''
export var background: Texture
export var foreground: Texture

export var object: PackedScene