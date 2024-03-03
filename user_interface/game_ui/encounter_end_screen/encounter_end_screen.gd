extends Control

@onready var _banner: EncounterBanner = $EncounterBanner
@onready var _button_text: RichTextLabel = $TextureButton/RichTextLabel

func show_victory() -> void:
	_show_screen("You Won", "Continue")

func show_gameover() -> void:
	_show_screen("Game Over", "Restart")

func _show_screen(banner_text: String, button_text: String) -> void:
	visible = true
	_banner.set_text(banner_text)
	
	_button_text.push_bold()
	_button_text.push_color(Color.BLACK)
	_button_text.push_font_size(22)
	_button_text.push_outline_color(Color.WHITE)
	_button_text.push_outline_size(10)
	_button_text.append_text("[center]%s[/center]" % button_text)
	_button_text.pop()
	_button_text.pop()
	_button_text.pop()
	_button_text.pop()
	_button_text.pop()
