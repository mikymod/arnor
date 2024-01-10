extends State

@export var pawn: Pawn
@export var animation_player: AnimationPlayer
@export var nav_agent: NavigationAgent2D

func enter() -> void:
	animation_player.play("idle")
	
func update(_delta: float) -> void:
	if pawn._target != null:
		transitioned.emit("PawnWalkState")

func handle_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			nav_agent.target_position = get_viewport().canvas_transform.affine_inverse().basis_xform(event.position)
			transitioned.emit("PawnWalkState")
