extends Button
signal _on_select_pose

func _on_button_down() -> void:
	_on_select_pose.emit()
