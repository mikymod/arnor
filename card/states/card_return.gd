class_name CardReturn
extends State

export var card_path: NodePath
onready var card: Node2D = get_node(card_path)

func process(_delta: float) -> void:
	card.global_position = lerp(card.global_position, card.init_pos, 0.1);
	if card.global_position.distance_to(card.init_pos) <= 0.01:
		state_machine.transition_to('Idle')

func _on_Card_input_event(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			state_machine.transition_to('Selected')
