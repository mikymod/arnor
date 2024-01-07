extends State

@export var _pawn: Pawn
@export var _animation_player: AnimationPlayer
@export var _gathering_progress: GatheringProgress

func enter() -> void:
	_gathering_progress.start()
	_animation_player.play("cut")
	_animation_player.animation_finished.connect(_on_cut_finished)
	_gathering_progress.gathering_stopped.connect(on_gathering_timeout)

func on_gathering_timeout():
	transitioned.emit("PawnIdleState")
	_animation_player.animation_finished.disconnect(_on_cut_finished)
	_gathering_progress.gathering_stopped.disconnect(on_gathering_timeout)

func _on_cut_finished(name: String) -> void:
	_pawn.pine_tree.pop_resource()
	_animation_player.play("cut")
	
