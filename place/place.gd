class_name Place
extends Area2D

## A place where a tower can be built

onready var _sprite: Sprite = $Sprite

var mouse_over: bool = false
var available: bool = true

func _process(_delta: float) -> void:
	if mouse_over:
		_sprite.modulate.a = 1
	else:
		_sprite.modulate.a = 0.5

func _on_Place_mouse_entered():
	mouse_over = true
	
func _on_Place_mouse_exited():
	mouse_over = false

func _on_Place_input_event(_viewport: Node, event:InputEvent, _shape_idx: int):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			print('event')	
