class_name CardResource
extends Resource

## Data container for cards.
##
## Each CardResource instance represents a different card.

signal cost_changed(cost)

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

export(Resource) var tower_resource
export(PackedScene) var tower

export(Array) var effect_resources

func change_cost(new_cost: int) -> void:
	cost = new_cost
	emit_signal('cost_changed', new_cost)

func apply_effect() -> void:
	pass
