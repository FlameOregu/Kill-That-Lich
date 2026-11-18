extends Button
signal on_cancel
signal engage
signal fight
var focus : bool #is focus on yes button
var fightselect : bool #confirms if fight
var button : String

func _on_select_fight():
	self.grab_focus()
	button = "fight"
	fightselect = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("cancel") == true and visible == true:
		_cancel()

func _cancel():
	on_cancel.emit(button)
	button = ""
	fightselect = false

func _fight(): #goes to fight screen in fight mode
	on_cancel.emit(button)
	$"../Action Node"._engage()
	fightselect = false

func _on_button_down() -> void:
	if fightselect == true:
		_fight()
