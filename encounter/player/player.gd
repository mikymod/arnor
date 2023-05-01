extends Area2D

@export var player_resource: PlayerResource
@export var enemy_events: EnemyEvents

func _on_Player_body_entered(body):
	body.queue_free()
	player_resource.change_health(-5)
	enemy_events.enemy_dead.emit()
