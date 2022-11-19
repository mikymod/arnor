class_name CardReturn
extends State

export var root_path: NodePath
onready var root: Node2D = get_node(root_path)

func process(_delta: float) -> void:
	root.global_position = lerp(root.global_position, root.init_pos, 0.1);
	if root.global_position.distance_to(root.init_pos) <= 0.01:
		state_machine.transition_to('Idle')

func _on_Card_input_event(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			state_machine.transition_to('Selected')
