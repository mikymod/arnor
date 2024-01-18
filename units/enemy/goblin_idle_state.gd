extends State

@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("idle")

