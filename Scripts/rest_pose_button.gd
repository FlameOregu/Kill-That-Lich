extends Button
signal rest

func _ready():
	self.grab_focus()

func _on_button_down() -> void:
	rest.emit()
