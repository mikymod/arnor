extends State

@export var _animation_player: AnimationPlayer
@export var _gathering_progress: GatheringProgress

func enter() -> void:
	_gathering_progress.start()
	_animation_player.play("cut")

#func exit() -> void:
	#_animation_player.play("idle")

func _on_timer_timeout():
	transitioned.emit("PawnIdleState")
