class_name Unit
extends CharacterBody2D

signal target_changed(target: Node2D)

enum UnitSpeed {
	SLOW = 50,
	MEDIUM = 100,
	FAST = 200,
}

@export var health: float = 1000
@export var damage: float = 100
@export var attack_speed: float = 1
@export var speed: UnitSpeed = UnitSpeed.MEDIUM
@export var range: float = 0

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _anim_player: AnimationPlayer = $AnimationPlayer
@onready var _agent: NavigationAgent2D = $NavigationAgent2D
@onready var _health_bar: ProgressBar = $HealthBar

var _target: Node2D

func dps() -> float:
	return damage / attack_speed

func _ready() -> void:
	_health_bar.min_value = 0
	_health_bar.max_value = health
	_health_bar.value = health
	set_target()

func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		_sprite.flip_h = velocity.x < 0

func set_target() -> void:
	_target = get_tree().get_first_node_in_group("targets")
	_agent.max_speed = speed
	
