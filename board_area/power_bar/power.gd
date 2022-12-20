tool

extends Node2D

export(Texture) var tex_enabled
export(Texture) var tex_disabled

export var enabled: bool = true

func _ready():
	$Sprite.texture = tex_enabled

func set_enabled(value: bool) -> void:
	enabled = value
	$Sprite.texture = tex_enabled if enabled else tex_disabled


