class_name Card
extends Area2D

## A Card instance
##
## - instanciated in the deck,
## - placed in hand when it's drawed
## - placed in discard when it's played
## - replaced in deck when the deck is depleted

signal card_played(card)

export var data: Resource

# The sprite in background
onready var _background: Sprite = $Background
# The sprite in foreground
onready var _foreground: Sprite = $Background/Foreground
# The label where card's name is displayed
onready var _name_label: RichTextLabel = $Background/NameLabel
# The label where card's cost is displayed
onready var _cost_label: RichTextLabel = $Background/CostLabel
# The label where card's description is displayed
onready var _description_label: RichTextLabel = $Background/DescriptionLabel
# The initial position of this node
onready var init_pos: Vector2 = global_position

onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
	setup(data)

func setup(res: Resource) -> void:
	data = res
	_background.texture = data.background
	# _foreground.texture = data.foreground
	_name_label.text = data.name
	_cost_label.text = String(data.cost)
	_description_label.text = data.description

func active() -> void:
	state_machine.transition_to('Idle');






