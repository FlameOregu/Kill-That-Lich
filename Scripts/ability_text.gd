extends Label

func _on_ability(text) -> void:
	self.text = text
	$"Popup Timer".start()

func _on_popup_timer_timeout() -> void:
	self.text = ""
