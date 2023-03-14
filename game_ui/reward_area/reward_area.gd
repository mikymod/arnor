extends Control

@export var turn_manager_resource: Resource

@export var cards: Array[CardResource]

@onready var slots = [
	$CenterContainer/HBoxContainer/RewardSlot1,
	$CenterContainer/HBoxContainer/RewardSlot2,
	$CenterContainer/HBoxContainer/RewardSlot3,
]

var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	turn_manager_resource.connect("reward_phase_started",Callable(self,"_on_reward_phase_started"))

func _on_reward_phase_started() -> void:
	print("_on_reward_phase_started")
	for slot in slots:
		var index = _rng.randi_range(0, cards.size() - 1)
		slot.card_resource = cards[index]
		slot.set_skin()
		slot.set_data()
