extends Button
@export var battlecharacter : Player
var focus : bool
var poseselect : bool
signal outengage
signal cancel

func _ready():
	self.position = Vector2(14,11)

func _on_select_pose() -> void:
	show()
	self.grab_focus()
	await get_tree().create_timer(0.2).timeout
	poseselect = true

func _on_focus_entered() -> void:
	focus = true

func _on_focus_exited() -> void:
	focus = false

func _input(event):
	if Input.is_action_just_pressed("interact") and focus == true and poseselect == true:
		outengage.emit()
		battlecharacter.currentmana += 50
		battlecharacter._on_manachange(0)
		if battlecharacter.currentmana > battlecharacter.maxmana:
			battlecharacter.currentmana = battlecharacter.maxmana
		battlecharacter.currenthealth += 30
		if battlecharacter.currenthealth > battlecharacter.maxhealth:
			battlecharacter.currenthealth = battlecharacter.maxhealth
		battlecharacter._on_healthchange(0)
		hide()
		poseselect = false

	elif Input.is_action_just_pressed("cancel"):
		cancel.emit()
		poseselect = false
