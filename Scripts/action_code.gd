extends Node
var children : Array
var actions : Array
var button : String
var dialogues_completed : int = 0
var dialogue
signal engage
var character : CharacterBody2D
var enemy : Node2D
var dialogue_finished : bool
@export var panel : Node
@export var text : Node
@export var no : Node
@export var yes : Node
@export var skillcont : Node
@export var skillpanel : Node
@export var fightbutton : Node
@export var posebutton : Node
@export var talkbutton : Node
@export var magicbutton : Node

func _ready():
	GlobalSignals.dialogue_terminal_finish.connect(_dialogue_terminal_finish)
	DialogueManager.dialogue_ended.connect(_dialogue_ended)
	character = GlobalSignals.character
	enemy = GlobalSignals.enemy

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
	elif button == "talk":
		talkbutton.grab_focus()
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
		for i in range(len(actions)): #sets the button navigation for the skills
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
	for i in range(len(actions)): #sets the button navigation for the skills
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

func _on_select_talk() -> void:
	if dialogue_finished == true: #If all dialogue seen, will do this
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/no_more_dialogue.dialogue"), "start")
	elif character.action_points > 0: #checks if enough action points, then shows the dialogue based on the dialogues completed
		character._on_ap_change(1)
		DialogueManager.show_dialogue_balloon(enemy.Dialogue, ("D" + str(dialogues_completed)))
	else:
		_show_text(1.5, "Not enough action points.")

func _dialogue_ended(_resource : DialogueManager.DialogueResource):
	dialogues_completed += 1
	talkbutton.grab_focus()

func _showskills():
	panel.show()
	text.show()
	skillpanel.show()
	skillcont.show()

func _engage(): #starts fight screen
	$"../../Fight Layer/Character".infight = true
	_on_cancel("fight")
	engage.emit()

func _dialogue_terminal_finish():
	dialogue_finished = true
	talkbutton.grab_focus()

func _show_text(seconds : float, message : String):
	text.text = message
	panel.show()
	text.show()
	await get_tree().create_timer(seconds).timeout
	panel.hide()
	text.hide()
	
