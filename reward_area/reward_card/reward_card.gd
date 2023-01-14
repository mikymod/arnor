extends TextureRect

export(Resource) var reward_area_resource
export(Resource) var card_resource

func _ready() -> void:
	if card_resource != null:
		change_skin()

func set_card_resource(card_res: CardResource)-> void:
	card_resource = card_res

func _on_RewardCard_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			reward_area_resource.emit_signal("reward_selected", card_resource)

func change_skin():
	texture = card_resource.background
	$NameLabel.text = card_resource.name
	$CostLabel.text = str(card_resource.cost)
