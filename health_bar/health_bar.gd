class_name HealthBar
extends ProgressBar

##
func on_health_init(entity: Node2D) -> void:
	min_value = 0
	max_value = entity.health
	value = entity.health

##
func on_health_changed(health: float) -> void:
	value = health
