class_name Card
extends Area2D

export var tmp: PackedScene

onready var mouse_over: bool = false
onready var selected: bool = false
onready var init_pos: Vector2 = global_position

var mouse_pos: Vector2



func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		mouse_pos = get_global_mouse_position()

	if selected:
		global_position = mouse_pos
	else:
		global_position = init_pos


func _on_Card_mouse_entered():
	mouse_over = true

func _on_Card_mouse_exited():
	mouse_over = false

func _on_Card_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			selected = true
		else:
			selected = false

func _on_Card_area_entered(area: Area2D):
	if area is Place:
		var new_tower = tmp.instance()
		area.add_child(new_tower)
		new_tower.global_position = area.global_position
		queue_free()
