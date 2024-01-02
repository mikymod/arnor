class_name Pawn
extends Character

#@onready var _sprite: Sprite2D = $Sprite2D
#@onready var _anim_player: AnimationPlayer = $AnimationPlayer
#@onready var _agent: NavigationAgent2D = $NavigationAgent2D
@onready var _state_machine: StateMachine = $StateMachine

#func _ready() -> void:
	#_anim_player.play("idle")

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			#_agent.target_position = event.position

func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		_sprite.flip_h = velocity.x < 0

func cut() -> void:
	_state_machine.transition_to("PawnCutState")


