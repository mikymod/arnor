class_name HistoryFrame
extends TextureRect


func set_thumb(thumb: Texture2D) -> void:
	$Thumb.texture = thumb
	$Thumb.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	$Thumb.flip_h = true
