extends Button
signal cancel

func _on_button_down() -> void:
	cancel.emit()
