class_name Card
extends Area2D

## A Card instance
##
## - instanciated in the deck,
## - placed in hand when it's drawed
## - placed in discard when it's played
## - replaced in deck when the deck is depleted

@export var resource: CardResource # CardResource
@export var card_events: CardEvents

# The sprite in background
@onready var _background_frame: Sprite2D = $BackgroundFrame
# The sprite in foreground
@onready var _foreground_frame: Sprite2D = $ForegroundFrame
@onready var _name_frame: Sprite2D = $NameFrame
@onready var _cost_frame: Sprite2D = $CostFrame
@onready var _description_frame: Sprite2D = $DescriptionFrame
@onready var _rarity_frame: Sprite2D = $RarityFrame
@onready var _selected_frame: Sprite2D = $Selected

# The label where card's name is displayed
@onready var _name_label: RichTextLabel = $NameFrame/NameLabel
# The label where card's cost is displayed
@onready var _cost_label: RichTextLabel = $CostFrame/CostLabel
# The label where card's description is displayed
@onready var _description_label: RichTextLabel = $DescriptionFrame/DescriptionLabel
# The initial position of this node
@onready var init_pos: Vector2 = global_position

@onready var state_machine: StateMachine = $StateMachine

var mouseover = false
var playable = true
var selected = false;

func _ready() -> void:
	card_events.connect("card_played",Callable(self,"_on_card_played"))
	card_events.connect("card_returned",Callable(self,"_on_card_returned"))
	card_events.connect("card_resolved",Callable(self,"_on_card_resolved"))
	set_skin()
	set_data()

func _process(_delta: float) -> void:
	_selected_frame.visible = selected

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
	_selected_frame.visible = false

func set_data() -> void:
	_name_label.text = resource.name
	_cost_label.bbcode_enabled = true
	_cost_label.text = "[center]" + str(resource.cost) + "[/center]"
	_description_label.bbcode_enabled = true
	_description_label.text = "[center]"
	for effect in resource.effect_resources:
		_description_label.text += effect.description + "\n"
	_description_label.text += "[/center]"

func set_selected(value: bool) -> void:
	selected = value

func _on_Card_mouse_entered():
	mouseover = true

func _on_Card_mouse_exited():
	mouseover = false

func _on_card_played(_card: Card) -> void:
	playable = false
	
func _on_card_returned(_card: Card) -> void:
	playable = true
	selected = false

func _on_card_resolved(card: Card) -> void:
	playable = true
	selected = false
	if self == card:
		if resource.exhaust:
			card_events.emit_signal("card_exhausted", card)
		else:
			card_events.emit_signal("card_discarded", card)
