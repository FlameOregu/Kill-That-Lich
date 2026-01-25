extends Button
signal _on_select_fight

func _on_focus_entered():
	$"../Button Beep".stream = preload("res://Assets/SFX/beep.mp3")
	$"../Button Beep".play()

func _ready():
	self.grab_focus()

func _on_button_down() -> void:
	_on_select_fight.emit()
	self.release_focus()

func _release():
	release_focus()
