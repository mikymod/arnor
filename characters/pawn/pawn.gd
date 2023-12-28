extends CharacterBody2D

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _anim_player: AnimationPlayer = $AnimationPlayer
@onready var _agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	_anim_player.play("idle")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			_agent.target_position = event.position

func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		_anim_player.play("walk")
		_sprite.flip_h = velocity.x < 0
	else:
		_anim_player.play("idle")


func _physics_process(delta: float) -> void:
	if _agent.is_navigation_finished():
		return

	var target_position = _agent.get_next_path_position()
	var direction = global_position.direction_to(target_position)
	velocity = direction * _agent.max_speed
	_agent.set_velocity_forced(velocity)
	move_and_slide()


