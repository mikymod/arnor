@tool

extends Node2D

@export var tex_enabled: Texture2D
@export var tex_disabled: Texture2D

@export var enabled: bool = true

func _ready():
	$Sprite2D.texture = tex_enabled

func set_enabled(value: bool) -> void:
	enabled = value
	$Sprite2D.texture = tex_enabled if enabled else tex_disabled
