extends Node2D

@export var turn_manager_resource: TurnManagerResource
@export var reward_area_resource: RewardAreaResource

@onready var _reward_area: Control = $GameUI/RewardArea

func _enter_tree() -> void:
	turn_manager_resource.reward_phase_started.connect(_on_reward_phase_started)
	reward_area_resource.reward_selected.connect(_on_reward_selected)

func _exit_tree():
	turn_manager_resource.reward_phase_started.disconnect(_on_reward_phase_started)
	reward_area_resource.reward_selected.disconnect(_on_reward_selected)

func _ready() -> void:
	# Disable reward area
	# The easiest way to stop processing a node is to remove it from the tree
	# (call remove_child() from its parent). This will make it invisible and stop
	# all processing, including physics.
	$GameUI.remove_child(_reward_area)

func _on_reward_phase_started() -> void:
	$GameUI.add_child(_reward_area)
#	_reward_area.global_position = _reward_area_pos
	_reward_area.visible = true

func _on_reward_selected(_card) -> void:
	$GameUI.remove_child(_reward_area)
