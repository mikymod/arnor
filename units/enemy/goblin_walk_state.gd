extends State

@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("walk")


func _on_interaction_area_2d_body_entered(body):
	if body is Unit:
		var unit = body as Unit
	transitioned.emit("Attack")
