extends Button
signal on_cancel
signal engage
signal fight
signal run
var focus : bool #is focus on yes button
var nofocus : bool #is focus on the no button
var fightselect : bool #confirms if fight
var runselect : bool #confirms if run

func _on_select_fight():
	self.grab_focus()
	await get_tree().create_timer(0.2).timeout
	fightselect = true

func _on_select_run() -> void:
	self.grab_focus()
	await get_tree().create_timer(0.2).timeout
	runselect = true

func _input(event: InputEvent):
	if fightselect == true: #fightbutton yes
		if Input.is_action_just_pressed("interact") == true and focus == true:
			on_cancel.emit()
			focus = false
			fight.emit()
			engage.emit()
			fightselect = false
	
	if runselect == true:
		if Input.is_action_just_pressed("interact") == true and focus == true:
			focus = false
			run.emit()

	if Input.is_action_just_pressed("cancel") == true and focus == true:
		on_cancel.emit("fight")
		focus = false
		fightselect = false
		runselect = false
		

	if Input.is_action_just_pressed("interact") == true and nofocus == true:
		on_cancel.emit("fight")
		focus = false
		fightselect = false

func _on_focus_entered():
	focus = true

func _on_no_focus_entered() -> void:
	nofocus = true

func _on_no_focus_exited() -> void:
	nofocus = false

func _outengage():
	$"../../Fight Layer/Character".infight = true
	on_cancel.emit("fight")
	engage.emit()

func _cancel():
	on_cancel.emit()
