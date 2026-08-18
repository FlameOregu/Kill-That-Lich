extends Button
signal _on_select_run

func _on_button_down() -> void:
	_on_select_run.emit()
