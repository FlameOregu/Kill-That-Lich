extends Node
var children : Array
var actions : Array
var button : String
signal engage
@export var panel : Node
@export var text : Node
@export var no : Node
@export var yes : Node
@export var skillcont : Node
@export var skillpanel : Node
@export var fightbutton : Node
@export var posebutton : Node
@export var runbutton : Node
@export var magicbutton : Node

func _input(event: InputEvent) -> void:
	if panel.visible == true and Input.is_action_just_pressed("cancel"):
		_on_cancel(button)

func _on_select_fight() -> void:
	button = "fight"
	panel.show()
	text.text = "Are you sure you want to attack?"
	text.show()
	yes.show()
	no.show()

func _dohide():
	panel.hide()
	children = panel.find_children("*", "", false, false)
	children.remove_at(0)
	for i in children:
		i.hide()

func _on_cancel(button) -> void:
	for i in actions:
		i.queue_free()
	actions.clear()
	text.text = ""
	_dohide()
	if button == "fight":
		fightbutton.grab_focus()
	elif button == "magic":
		magicbutton.grab_focus()
	elif button == "pose":
		posebutton.grab_focus()
	elif button == "run":
		runbutton.grab_focus()
	button = ""
	

func _on_select_magic() -> void:
	button = "magic"
	for i in GlobalSignals.magics:
		var scene = load(i).instantiate()
		skillcont.add_child(scene)
		actions.append(scene)
	_showskills()
	if GlobalSignals.magics.is_empty():
		pass
	else:
		for i in range(len(actions)):
			if i != 0 and i != len(actions):
				actions[(i-1)].focus_neighbor_right = actions[i].get_path()
				actions[(i-1)].focus_neighbor_left = actions[(i-2)].get_path()
			elif i == 0 and i != len(actions):
				actions[0].focus_neighbor_right = actions[i].get_path()
			elif i == len(actions):
				actions[(i-1)].focus_neighbor_left = actions[(i-2)].get_path()
			actions[0].focus_neighbor_left = actions[0].get_path() #sets the first button in array to select itself when pressed left
			actions[-1].focus_neighbor_right = actions[-1].get_path() #sets the last button in array to select itself when pressed right
			actions[0].grab_focus()

func _on_select_pose() -> void:
	button = "pose"
	for i in GlobalSignals.poses:
		var scene = load(i).instantiate()
		skillcont.add_child(scene)
		actions.append(scene)
	_showskills()
	for i in range(len(actions)):
		if i != 0 and i != len(actions):
			actions[(i-1)].focus_neighbor_right = actions[i].get_path()
			actions[(i-1)].focus_neighbor_left = actions[(i-2)].get_path()
		elif i == 0 and i != len(actions):
			actions[0].focus_neighbor_right = actions[i].get_path()
		elif i == len(actions):
			actions[(i-1)].focus_neighbor_left = actions[(i-2)].get_path()
	actions[0].focus_neighbor_left = actions[0].get_path() #sets the first button in array to select itself when pressed left
	actions[-1].focus_neighbor_right = actions[-1].get_path() #sets the last button in array to select itself when pressed right
	actions[0].grab_focus()

func _on_select_run() -> void:
	button = "run"
	panel.show()
	text.text = "Are you sure you want to run?"
	text.show()
	yes.show()
	no.show()

func _showskills():
	panel.show()
	text.show()
	skillpanel.show()
	skillcont.show()

func _engage(): #starts fight screen
	$"../../Fight Layer/Character".infight = true
	_on_cancel("fight")
	engage.emit()
