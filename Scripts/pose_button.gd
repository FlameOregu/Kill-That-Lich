extends Button
signal _on_select_pose

func _on_focus_entered() -> void:
	$"../Button Beep".stream = preload("res://Assets/SFX/beep.mp3")
	$"../Button Beep".play()

func _on_button_down() -> void:
	_on_select_pose.emit()
