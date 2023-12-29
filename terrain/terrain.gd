extends Node2D

@onready var _tile_map: TileMap = $TileMap
@onready var _agent: NavigationAgent2D = $Pawn/NavigationAgent2D
@onready var _camera: Camera2D = $Camera2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			#_agent.target_position = event.position
			_agent.target_position = get_global_mouse_position()


