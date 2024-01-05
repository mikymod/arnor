class_name PineTree
extends Node2D

func get_cut_position() -> Node2D:
	return $CutPosition

#func _on_area_2d_body_entered(body: Node2D): 
	#if not body is Pawn:
		#return
	#var left_distance = abs(body.global_position.distance_to($CutArea2D/CutLeftPosition.global_position))
	#var right_distance = abs(body.global_position.distance_to($CutArea2D/CutRightPosition.global_position))
	#var character = body as Pawn
	#if right_distance < left_distance:
		#body.global_position = $CutArea2D/CutRightPosition.global_position
	#else:
		#body.global_position = $CutArea2D/CutLeftPosition.global_position
	#character.cut()
