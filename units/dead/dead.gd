class_name Dead
extends Node2D

@export_range(0, 5) var fade_time: float = 1.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.play("dead")

func _on_dead_animation_finished():
	timer.wait_time = fade_time
	timer.start()


func _on_fade_timer_timeout():
	queue_free()
