extends Label

func _on_character_combo(combo: String) -> void:
	self.text = combo
	$"Popup Timer".start()
	self.text = ""

func _on_popup_timer_timeout() -> void:
	self.text = ""
