extends Label

func _on_character_combo(combo: String) -> void:
	self.text = combo
	await get_tree().create_timer(2.0).timeout
	self.text = ""
