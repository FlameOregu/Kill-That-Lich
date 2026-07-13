extends Button
@export var buttonbeep : Node2D
var skilldir : String
var skillcost : int
var skilltype : String

func _on_focus_entered() -> void:
	buttonbeep.play()

func _on_button_down() -> void:
	if self.text == "Learn" and GlobalSignals.skillpoints >= skillcost:
		if skilltype == "magic":
			_learnmagic()
	else:
		#buttonbeep.stream = preload("")
		buttonbeep.play()

func _learnmagic():
	GlobalSignals.magics.append(skilldir)
	GlobalSignals.skillpoints =- skillcost
	self.text = "Learned!"
	#buttonbeep.stream = preload("")
	buttonbeep.play()
