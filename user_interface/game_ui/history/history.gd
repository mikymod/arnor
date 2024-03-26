extends Control

@export var frame_scene: PackedScene
@export var max_items: int = 6
var _items: Array[HistoryFrame] = []

func on_card_played(card: Card) -> void:
	# Instantiate new item
	var frame = frame_scene.instantiate()
	frame.set_thumb(card.card_resource.unit_thumb)
	_items.append(frame)

	# Clears old child
	for child in $NinePatchRect/VBoxContainer.get_children():
		$NinePatchRect/VBoxContainer.remove_child(child)

	# Adds new child
	var item_added: int = 0
	var item_counted: int = _items.size() - 1
	while item_counted >= 0:
		var new_child = _items[item_counted]
		$NinePatchRect/VBoxContainer.add_child(new_child)
		item_counted -= 1
		item_added += 1
		if item_added == max_items:
			break
		
