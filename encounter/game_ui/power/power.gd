extends Control

@export var power_resource: PowerResource
@export var card_events: CardEvents
@export var turn_manager_resource: TurnManagerResource

@onready var _label: Label = $TextureRect/CenterContainer/Label

func _ready() -> void:
	card_events.card_played.connect(_on_card_played)
	card_events.card_returned.connect(_on_card_returned)
	turn_manager_resource.restore_phase_started.connect(_on_restore_phase_started)
	power_resource.max_power_changed.connect(_on_max_power_changed)

func _process(delta: float) -> void:
	_label.text = "%s/%s" % [power_resource.current_power, power_resource.max_power]

func _on_card_played(card: Card) -> void:
	var cost = card.card_resource.cost
	power_resource.decrease_power(cost)

func _on_card_returned(card: Card) -> void:
	var cost = card.card_resource.cost
	power_resource.increase_power(cost)

func _on_restore_phase_started() -> void:
	power_resource.reset_power()

func _on_max_power_changed(num_power):
	pass
