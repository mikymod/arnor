class_name HealthBar
extends ProgressBar

@export var unit: Unit


func _ready():
	min_value = 0
	max_value = unit.health
	value = unit.health


func _process(delta):
	value = unit.health
