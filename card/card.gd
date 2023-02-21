class_name Card
extends Area2D

## A Card instance
##
## - instanciated in the deck,
## - placed in hand when it's drawed
## - placed in discard when it's played
## - replaced in deck when the deck is depleted

export(Resource) var resource # CardResource

# The sprite in background
onready var _background_frame: Sprite = $BackgroundFrame
# The sprite in foreground
onready var _foreground_frame: Sprite = $ForegroundFrame
onready var _name_frame: Sprite = $NameFrame
onready var _cost_frame: Sprite = $CostFrame
onready var _description_frame: Sprite = $DescriptionFrame
onready var _rarity_frame: Sprite = $RarityFrame

# The label where card's name is displayed
onready var _name_label: RichTextLabel = $NameFrame/NameLabel
# The label where card's cost is displayed
onready var _cost_label: RichTextLabel = $CostFrame/CostLabel
# The label where card's description is displayed
onready var _description_label: RichTextLabel = $DescriptionFrame/DescriptionLabel
# The initial position of this node
onready var init_pos: Vector2 = global_position

onready var state_machine: StateMachine = $StateMachine

var playable = false
var mouseover = false

func _ready() -> void:
	set_skin()
	set_data()

func enable_collision() -> void:
	$CollisionShape2D.disabled = false

func disable_collision() -> void:
	$CollisionShape2D.disabled = true

func set_skin() -> void:
	_background_frame.texture = resource.background_frame
	_background_frame.modulate = resource.background_frame_color
	
	_foreground_frame.texture = resource.foreground_frame

	_cost_frame.texture = resource.cost_frame
	_cost_frame.modulate = resource.cost_frame_color
	
	_name_frame.texture = resource.name_frame
	_name_frame.modulate = resource.name_frame_color
	
	_description_frame.texture = resource.description_frame
	_description_frame.modulate = resource.description_frame_color
	
	_rarity_frame.texture = resource.rarity_frame
	_rarity_frame.modulate = resource.rarity_frame_color

func set_data() -> void:
	_name_label.text = resource.name
	
	_cost_label.bbcode_enabled = true
	_cost_label.bbcode_text = "[center]" + str(resource.cost) + "[/center]"

	_description_label.bbcode_enabled = true
	_description_label.bbcode_text = "[center]"
	for effect in resource.effect_resources:
		_description_label.bbcode_text += effect.description + "\n"
	_description_label.bbcode_text += "[/center]"


func _on_Card_mouse_entered():
	mouseover = true

func _on_Card_mouse_exited():
	mouseover = false
