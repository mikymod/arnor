extends Node2D

export(Resource) var turn_manager_resource
export(Resource) var reward_area_resource

onready var _reward_area: Control = $RewardArea
#onready var _reward_area_pos: Vector2 = $RewardArea.global_position

func _ready() -> void:
	turn_manager_resource.connect("reward_phase_started", self, "_on_reward_phase_started")
	reward_area_resource.connect("reward_selected", self, "_on_reward_selected")
	# Disable reward area
	# The easiest way to stop processing a node is to remove it from the tree
	# (call remove_child() from its parent). This will make it invisible and stop
	# all processing, including physics.
	remove_child(_reward_area)

func _on_reward_phase_started() -> void:
	add_child(_reward_area)
#	_reward_area.global_position = _reward_area_pos
	_reward_area.visible = true

func _on_reward_selected(_card) -> void:
	remove_child(_reward_area)
