extends State

@export var pawn: Pawn
@export var nav_agent: NavigationAgent2D
@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("walk")
	#pawn.target = get_tree().get_first_node_in_group("targets")
	nav_agent.max_speed = 100
	nav_agent.target_position = pawn.target.global_position
	nav_agent.navigation_finished.connect(_on_navigation_finished)
	nav_agent.velocity_computed.connect(_on_velocity_computed)

func physics_update(_delta: float) -> void:
	#nav_agent.target_position = pawn.target.global_position
	var target_position = nav_agent.get_next_path_position()
	var direction = pawn.global_position.direction_to(target_position)
	var new_velocity = direction * 100
	if nav_agent.avoidance_enabled:
		nav_agent.velocity = new_velocity
		pawn.velocity = new_velocity
	else:
		_on_velocity_computed(new_velocity)

func exit() -> void:
	nav_agent.velocity_computed.disconnect(_on_velocity_computed)
	
func _on_navigation_finished() -> void:
	transitioned.emit("PawnIdleState")
	nav_agent.navigation_finished.disconnect(_on_navigation_finished)

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	pawn.velocity = safe_velocity
	var collided = pawn.move_and_slide()
	if collided:
		var collision = pawn.get_last_slide_collision()

