class_name PlayerResource
extends Resource

signal gold_changed()
signal exp_changed()
signal level_reached()

const base_xp: int = 25
const exponent: float = 1.5

@export var name: String = "Tav"

var max_level: int = 10:
	get: return max_level
	set(value): max_level = value

var xp: int = 0
var level: int = 1
var gold: int = 0

func add_gold(amount: int) -> void:
	gold += amount
	gold_changed.emit()

func reset_gold() -> void:
	gold = 0
	gold_changed.emit()

func add_xp(amount: int) -> void:
	if level == max_level:
		return
	xp += amount
	exp_changed.emit()
	while xp - next_level_threshold() >= 0:
		level += 1
		level_reached.emit()
		if level == max_level:
			break

func reset_xp() -> void:
	xp = 0
	level = 1
	exp_changed.emit()

func next_level_threshold() -> int:
	if level >= max_level: return 0
	return floor(base_xp * (pow(level ,exponent)))

func prev_level_threshold() -> int:
	if level <= 1: return 0
	return floor(base_xp * (pow(level - 1 ,exponent)))

func level_threshold_delta() -> int:
	return next_level_threshold() - prev_level_threshold()
