extends State

@export var unit: Unit
@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("idle")


func _on_walk_area_body_entered(body: Node2D) -> void:
	if unit != null:
		unit.target = body
		transitioned.emit("Walk")
