extends Node2D

@onready var _tile_map: TileMap = $TileMap
@onready var _agent: NavigationAgent2D = $Pawn/NavigationAgent2D

var tile_map_layer_floor_level : int = 2
var tile_map_layer_first_level : int = 5
var tile_map_layer_second_level : int = 8

func enable_level(layer: int) -> void:
	var nav_map = _tile_map.get_navigation_map(layer)
	_agent.set_navigation_map(nav_map)

