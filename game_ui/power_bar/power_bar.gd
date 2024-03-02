extends Control

@export var supply: Supply = preload("res://supplies/gold.tres")
@export var speed: float = 3

var active: bool = false

func _ready() -> void:
	$TextureProgressBar.value = supply.value
	stop()

func _process(delta: float) -> void:
	#if not active: return
	supply.increase(delta * 3)
	$TextureProgressBar.value = supply.value

func start() -> void:
	active = true
	set_process(true)

func stop() -> void:
	active = false
	set_process(false)
	
func _on_card_played(card: Card) -> void:
	var cost = card.card_resource.cost
	supply.decrease(cost * 10)

