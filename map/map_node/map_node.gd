class_name MapNode
extends Node2D

@export var map_node_resource: MapNodeResource

@export var map_events: MapEvents

var children: Array[MapNode] = []

var selectable: bool = false # A MapNode is selectable if the previous nodes in the path are completed
var completed: bool = false

func scene() -> PackedScene:
	return map_node_resource.scene 

func add_child_node(child):
	if !children.has(child):
		children.append(child)

func _ready() -> void:
	$Sprite2D.texture = map_node_resource.texture

func _process(delta: float) -> void:
	if (completed):
		$Sprite2D.modulate = Color.BLACK
		return

func _on_area_2d_input_event(viewport, event, shape_idx):
	if not selectable:
		return
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			map_events.map_node_selected.emit(self)

func _on_area_2d_mouse_entered():
	scale = Vector2(1.5, 1.5)

func _on_area_2d_mouse_exited():
	scale = Vector2(1, 1)
