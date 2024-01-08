extends State

@export var _pawn: Pawn
@export var _animation_player: AnimationPlayer
@export var _gathering_progress: GatheringProgress

func enter() -> void:
	_gathering_progress.start()
	_animation_player.play("gather")
	_gathering_progress.gathering_stopped.connect(on_gathering_timeout)

func on_gathering_timeout():
	transitioned.emit("PawnIdleState")
	_pawn.gold_mine.pop_resource()
	_gathering_progress.gathering_stopped.disconnect(on_gathering_timeout)
