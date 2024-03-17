class_name RewardArea
extends Control

@export var encounter: EncounterResource
@export var player: PlayerResource

@export var button_scene: PackedScene

const gold_reward_text: String = "%s gold"
var gold_reward_icon: Texture2D = preload("res://user_interface/textures/icons/Regular_01.png")

const exp_reward_text: String = "%s exp."
var exp_reward_icon: Texture2D = preload("res://user_interface/textures/icons/Regular_01.png")


func _ready() -> void:
	# FIXME: test, should be removed
	add_gold_reward(139)
	add_exp_reward(650)

func calculate_exp_reward(player_level: int, encounter_difficulty: int, max_level: int, base_reward: int) -> float:
	#var leveling_speed = 0.5
	#var difficulty_modifier = encounter_difficulty
	## Find the player's current level threshold and next level threshold
	#var current_threshold = player.level_progress[player_level]
	#var next_threshold = player.level_progress[player_level + 1] if player_level < max_level else current_threshold
	## Calculate the player's progress within their current level
	#var progress_within_level = next_threshold - current_threshold
	## Calculate the proportion of progress towards the next level
	#var progress_ratio = progress_within_level / (next_threshold - current_threshold) if player_level < max_level else 1.0
	## Calculate the level modifier using the progress ratio
	#var level_modifier = 1 - progress_ratio
	#var reward = base_reward * difficulty_modifier * level_modifier
	var reward = 0
	var exponent = 1.5
	reward = floor(base_reward * (pow(player_level ,exponent)))
	print("exp: %s" % reward)
	return reward

func calculate_gold_reward(player_level: int, encounter_difficulty: int, max_level: int, base_reward: int) -> float:
	var difficulty_modifier = encounter_difficulty
	var level_modifier = 1 + (max_level - player_level) / max_level
	var reward = ceil(base_reward * difficulty_modifier * level_modifier)
	print("gold: %s" % reward)
	return reward

func add_gold_reward(amount: int) -> void:
	var button = button_scene.instantiate() as RewardButton
	button.init(gold_reward_icon, gold_reward_text % amount)
	$RewardList/VBoxContainer.add_child(button)

func add_exp_reward(amount: int) -> void:
	var button = button_scene.instantiate() as RewardButton
	button.init(exp_reward_icon, exp_reward_text % amount)
	$RewardList/VBoxContainer.add_child(button)
