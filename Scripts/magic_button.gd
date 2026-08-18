extends Button
signal _on_select_magic

func _on_button_down() -> void:
	_on_select_magic.emit()
	self.release_focus()
