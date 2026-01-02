extends Panel
var children : Array
var pos = Vector2(14,11)
var actions : Array
var button : String
func _ready():
	_dohide()

func _input(event: InputEvent) -> void:
	if visible == true and Input.is_action_just_pressed("cancel"):
		_on_cancel(button)

func _on_select_fight() -> void:
	button = "fight"
	show()
	$Text.text = "Are you sure you want to attack?"
	$Text.show()
	$Yes.show()
	$No.show()

func _dohide():
	hide()
	children = self.find_children("*", "", true, false)
	for i in children:
		i.hide()

func _on_cancel(button) -> void:
	for i in actions:
		i.queue_free()
		actions.erase(i)
	pos = Vector2(14,11)
	if button == "fight":
		$"../Fight Button".grab_focus()
	elif button == "magic":
		$"../Magic Button".grab_focus()
	elif button == "pose":
		$"../Pose Button".grab_focus()
	elif button == "pose":
		$"../Run Button".grab_focus()
	button = ""
	_dohide()

func _on_select_magic() -> void:
	button = "magic"
	for i in GlobalSignals.magics:
		var scene = load(i).instantiate()
		add_child(scene)
		actions.append(scene)
		scene.position = pos
		if pos == Vector2(656, 11):
			pos = Vector2(14, 60)
		else:
			pos += Vector2(214, 0)
	for i in len(actions):
		if i == 0:
			pass
		else:
			actions[(i-1)].focus_neighbor_bottom = actions[i].get_path()
			actions[i].focus_neighbor_top = actions[(i-1)].get_path()
	show()
	actions[0].grab_focus()

func _on_select_pose() -> void:
	button = "pose"
	for i in GlobalSignals.poses:
		var scene = load(i).instantiate()
		add_child(scene)
		actions.append(scene)
		scene.position = pos
		if pos == Vector2(656, 11):
			pos = Vector2(14, 60)
		else:
			pos += Vector2(214, 0)
	show()

func _on_select_run() -> void:
	button = "run"
	show()
	$Text.text = "Are you sure you want to run?"
	$Text.show()
	$Yes.show()
	$No.show()
