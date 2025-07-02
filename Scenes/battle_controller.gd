extends Area2D

func _on_area_entered(area:Area2D):
	print("area_entered")
	print($BattleBehaviour.name)

func _on_area_exited(area:Area2D):
	print("area_left")

func _on_character_moving(is_moving:bool):
	$BattleBehaviour.character_is_moving(is_moving)
	
