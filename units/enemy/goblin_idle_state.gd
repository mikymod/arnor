extends State

@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("idle")


func _on_interaction_area_2d_body_entered(body):
	transitioned.emit("Attack")
