class_name Unit
extends CharacterBody2D

enum UnitSpeed {
	SLOW,
	MEDIUM,
	FAST,
}

@export var health: float = 1000
@export var damage: float = 100
@export var attack_speed: float = 1
@export var speed: UnitSpeed = UnitSpeed.MEDIUM
@export var range: float = 0

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _anim_player: AnimationPlayer = $AnimationPlayer
@onready var _agent: NavigationAgent2D = $NavigationAgent2D
@onready var _health_bar: HealthBar = $HealthBar

func dps() -> float:
	return damage / attack_speed

func setup() -> void:
	_health_bar.init(health)
