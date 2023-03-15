extends Control

@export var player_resource: Resource

func _ready() -> void:
	player_resource.max_health_changed.connect(_on_max_health_changed)
	player_resource.health_changed.connect(_on_health_changed)
	$HealthBar.max_value = player_resource.max_health
	$HealthBar.value = player_resource.health

func _on_max_health_changed(max_health: int) -> void:
	$HealthBar.max_value = player_resource.max_health

func _on_health_changed(health: int) -> void:
	$HealthBar.value = player_resource.health
