extends State

@export var character_body: CharacterBody2D
@export var nav_agent: NavigationAgent2D
@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("walk")

func handle_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			#get_viewport().canvas_transform.affine_inverse().basis_xform(event.position)
			nav_agent.target_position = get_viewport().canvas_transform.affine_inverse().basis_xform(event.position)
			transitioned.emit("PawnWalkState")

func physics_update(_delta: float) -> void:
	if nav_agent.is_navigation_finished():
		return

	var target_position = nav_agent.get_next_path_position()
	var direction = character_body.global_position.direction_to(target_position)
	character_body.velocity = direction * nav_agent.max_speed
	nav_agent.set_velocity_forced(character_body.velocity)
	character_body.move_and_slide()
