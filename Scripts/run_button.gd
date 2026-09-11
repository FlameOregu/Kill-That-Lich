extends Button
signal _on_select_talk

func _on_button_down() -> void:
	_on_select_talk.emit()
