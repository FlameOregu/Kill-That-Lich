extends Button
signal on_cancel
signal fight()
var focus : bool
var nofocus : bool

func _on_select_fight():
	self.grab_focus()

func _input(event: InputEvent):
	if Input.is_action_just_pressed("cancel") == true and focus == true:
		on_cancel.emit()
		focus = false
	elif Input.is_action_just_pressed("interact") == true and focus == true:
		$"../../Fight Layer/Character".fighting = true
		on_cancel.emit()
		focus = false
		fight.emit()
	if Input.is_action_just_pressed("interact") == true and nofocus == true:
		on_cancel.emit()
		focus = false

func _on_focus_entered():
	focus = true
