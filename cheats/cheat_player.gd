extends PanelContainer

@export var player_res: PlayerResource = preload("res://resources/player/player.tres")

var gold_amount: int = 0
var xp_amount: int = 0

func _process(delta: float) -> void:
	gold_amount = $VBoxContainer/Gold/HSlider.value
	xp_amount = $VBoxContainer/XP/HSlider.value
	$VBoxContainer/Gold/Label.text = str(gold_amount)
	$VBoxContainer/XP/Label.text = str(xp_amount)
	$VBoxContainer/PrevLevelThreshold.text = "Prev Level: %s" % player_res.prev_level_threshold()
	$VBoxContainer/NextLevelThreshold.text = "Next Level: %s" % player_res.next_level_threshold()
	$VBoxContainer/LevelThresholdDelta.text = "Delta: %s" % player_res.level_threshold_delta()
	$VBoxContainer/CurrentXP.text = "Current XP: %s" % player_res.xp

func add_gold() -> void:
	player_res.add_gold(gold_amount)

func reset_gold() -> void:
	player_res.reset_gold()

func add_xp() -> void:
	player_res.add_xp(xp_amount)

func reset_xp() -> void:
	player_res.reset_xp()
