class_name Player
extends Resource

signal gold_changed()
signal exp_changed()
signal level_reached()

const max_level: int = 10
const level_progress: Dictionary = {
	1: 0,
	2: 300,
	3: 900,
	4: 2700,
	5: 6500,
	6: 14000,
	7: 23000,
	8: 34000,
	9: 48000,
	10: 64000,
}

@export var name: String = "Tav"

var gold: int = 0
var exp: int = 0
var level: int = 1

func add_gold(amount: int) -> void:
	gold += amount
	gold_changed.emit()

func add_exp(amount: int) -> void:
	if level == max_level:
		return
		
	exp += amount
	exp_changed.emit()
	
	while exp - level_progress[level + 1] >= 0:
		level += 1
		level_reached.emit()
		if level == max_level:
			break
		
	
	
	

