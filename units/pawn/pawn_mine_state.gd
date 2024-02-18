extends State

@export var _pawn: Pawn
@export var _animation_player: AnimationPlayer

func enter() -> void:
	_animation_player.play("gather")


