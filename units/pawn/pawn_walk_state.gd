extends State

@export var pawn: Pawn
@export var nav_agent: NavigationAgent2D
@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("walk")
	pawn.set_target()
	nav_agent.target_position = pawn._target.global_position
	nav_agent.navigation_finished.connect(_on_navigation_finished)

func physics_update(_delta: float) -> void:
	var target_position = nav_agent.get_next_path_position()
	var direction = pawn.global_position.direction_to(target_position)
	pawn.velocity = direction * nav_agent.max_speed
	nav_agent.set_velocity_forced(pawn.velocity)
	pawn.move_and_slide()
	
func _on_navigation_finished() -> void:
	transitioned.emit("PawnIdleState")
	pawn._target = null
	nav_agent.navigation_finished.disconnect(_on_navigation_finished)
