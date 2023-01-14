extends Control

export(Resource) var player_resource

func _ready() -> void:
	player_resource.connect("max_health_changed", self, "_on_max_health_changed")
	player_resource.connect("health_changed", self, "_on_health_changed")
	$HealthBar.max_value = player_resource.max_health
	$HealthBar.value = player_resource.health

func _on_max_health_changed(max_health: int) -> void:
	$HealthBar.max_value = player_resource.max_health

func _on_health_changed(health: int) -> void:
	$HealthBar.value = player_resource.health
