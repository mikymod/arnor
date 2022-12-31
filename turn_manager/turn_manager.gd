class_name TurnManager
extends Node2D

export(Resource) var power_resource
export(Resource) var hand_resource
export(Resource) var deck_resource
export(Array) var wave_resource

func _on_Restore_Phase_button_down():
	power_resource.reset_power()

func _on_Draw_Phase_button_down():
	var num_cards_to_draw = min(deck_resource.deck_list.size(), 4)
	for _i in range(num_cards_to_draw):
		deck_resource.draw_card()

func _on_Spawn_Phase_button_down():
	print("must be implemented")
