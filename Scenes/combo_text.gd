extends Label

func _on_character_combo(combo: String) -> void:
	self.text = combo
	await get_tree().create_timer(1.5).timeout
	self.text = ""
