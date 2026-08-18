extends Button
@export var buttonbeep : Node2D
var skilldir : String
var skillcost : int
var skilltype : String
signal cant
signal cando

func _on_focus_entered() -> void:
	buttonbeep.stream = preload("res://Assets/SFX/beep.mp3")
	buttonbeep.play()

func _on_button_down() -> void:
	if self.text == "Learn" and GlobalSignals.skillpoints >= skillcost:#success
		if skilltype == "magic":
			_learnmagic()
	else:#fail
		cant.emit()

func _learnmagic():
	GlobalSignals.magics.append(skilldir)
	GlobalSignals.skillpoints =- skillcost
	self.text = "Learned!"
	cando.emit()
