extends Node2D

export(Resource) var power_resource
export(PackedScene) var power_scene

export(Resource) var hand_resource

var items: Array = []

func _ready() -> void:
	hand_resource.connect('card_played', self, '_on_card_played')
	power_resource.connect("power_restored", self, "_on_power_restored")
	
	for i in range(power_resource.max_power):
		var instance = power_scene.instance()
		add_child(instance)
		instance.position = Vector2(i * 48, 0)
		items.append(instance)

func _on_card_played(card: Card) -> void:
	var cost = card.resource.cost
	power_resource.decrease_power(cost)
	
	for i in range(power_resource.max_power):
		if i < power_resource.current_power:
			items[i].set_enabled(true)
		else:
			items[i].set_enabled(false)

func _on_power_restored() -> void:
	for item in items:
		item.set_enabled(true)
	
