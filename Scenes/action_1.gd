extends Button
signal on_cancel
var focus = false

func _on_select_fight():
	self.grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("cancel") == true and focus == true:
		on_cancel.emit()
		focus = false

func _on_focus_entered():
	focus = true
