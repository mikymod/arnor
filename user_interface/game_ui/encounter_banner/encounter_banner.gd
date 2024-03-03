class_name EncounterBanner
extends Control

@onready var _text: RichTextLabel = $TextureRect/RichTextLabel

func set_text(value: String) -> void:
	_text.text = ""
	_text.push_bold()
	_text.push_color(Color.BLACK)
	_text.push_font_size(52)
	_text.push_outline_color(Color.WHITE)
	_text.push_outline_size(10)
	_text.append_text("[center]%s[/center]" % value)
	_text.pop()
	_text.pop()
	_text.pop()
	_text.pop()
	_text.pop()
	pass
