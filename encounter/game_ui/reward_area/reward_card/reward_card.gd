extends Control

@export var reward_area_resource: RewardAreaResource
@export var card_resource: CardResource
@export var map_events: MapEvents

# The sprite in background
@onready var _background_frame: TextureRect = $BackgroundFrame
# The sprite in foreground
@onready var _foreground_frame: TextureRect = $ForegroundFrame
@onready var _name_frame: TextureRect = $NameFrame
@onready var _cost_frame: TextureRect = $CostFrame
@onready var _description_frame: TextureRect = $DescriptionFrame
@onready var _rarity_frame: TextureRect = $RarityFrame

# The label where card's name is displayed
@onready var _name_label: RichTextLabel = $NameFrame/NameLabel
# The label where card's cost is displayed
@onready var _cost_label: RichTextLabel = $CostFrame/CostLabel
# The label where card's description is displayed
@onready var _description_label: RichTextLabel = $DescriptionFrame/DescriptionLabel

func _ready() -> void:
	if card_resource != null:
		set_skin()
		set_data()

func set_card_resource(card_res: CardResource)-> void:
	card_resource = card_res

func _on_RewardCard_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			reward_area_resource.reward_selected.emit(card_resource)
			map_events.map_node_completed.emit()
			SceneManager.pop_scene()

func set_skin() -> void:
	_background_frame.texture = card_resource.background_frame
	_background_frame.modulate = card_resource.background_frame_color
	
	_foreground_frame.texture = card_resource.foreground_frame

	_cost_frame.texture = card_resource.cost_frame
	_cost_frame.modulate = card_resource.cost_frame_color
	
	_name_frame.texture = card_resource.name_frame
	_name_frame.modulate = card_resource.name_frame_color
	
	_description_frame.texture = card_resource.description_frame
	_description_frame.modulate = card_resource.description_frame_color
	
	_rarity_frame.texture = card_resource.rarity_frame
	_rarity_frame.modulate = card_resource.rarity_frame_color

func set_data() -> void:
	_name_label.text = card_resource.name
	_cost_label.text = str(card_resource.cost)
	
	_description_label.bbcode_enabled = true
	_description_label.text = "[center]"
	for effect in card_resource.effect_resources:
		_description_label.text += effect.description + "\n"
	_description_label.text += "[/center]"
