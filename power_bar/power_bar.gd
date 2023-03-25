extends Node2D

@export var power_resource: PowerResource
@export var card_events: CardEvents
@export var turn_manager_resource: TurnManagerResource
@export var power_scene: PackedScene

var items: Array = []

func _ready() -> void:
	card_events.card_played.connect(_on_card_played)
	card_events.card_returned.connect(_on_card_returned)
	turn_manager_resource.restore_phase_started.connect(_on_restore_phase_started)
	power_resource.max_power_changed.connect(_on_max_power_changed)
	
	for i in range(power_resource.max_power):
		var instance = power_scene.instantiate()
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
			
func _on_card_returned(card: Card) -> void:
	var cost = card.resource.cost
	power_resource.increase_power(cost)
	for i in range(power_resource.max_power):
		if i < power_resource.current_power:
			items[i].set_enabled(true)
		else:
			items[i].set_enabled(false)	
	
func _on_restore_phase_started() -> void:
	power_resource.reset_power()
	for item in items:
		item.set_enabled(true)

func _on_max_power_changed(num_power):
	for i in range(items.size(), num_power):
		var instance = power_scene.instantiate()
		add_child(instance)
		instance.position = Vector2(i * 48, 0)
		instance.set_enabled(false)
		items.append(instance)
	
