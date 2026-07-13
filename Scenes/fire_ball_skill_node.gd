extends Button
var learnbutton : Button
var title = "Fire Ball"
var desc = "Fireball (50 MP) - Shoot a ball of magical fire using your magical essence to magically deal 125 base magic damage."
var skilldir = "res://Scenes/fireball.tscn"
var skilltype = "magic"
var cost = 1
var titlelabel : Label
var desclabel : Label
var buttonbeep : Node

func _ready() -> void:
	buttonbeep = $"../../../Button Beep"
	titlelabel = $"../../Node Desc Panel/Title Panel/Title Text"
	desclabel = $"../../Node Desc Panel/Description Panel/Description Text"
	learnbutton = $"../../Node Desc Panel/Learn"

func _on_button_down() -> void:
	learnbutton.grab_focus()

func _on_focus_entered() -> void:
	titlelabel.text = title
	desclabel.text = desc
	if skilldir in GlobalSignals.magics:
		learnbutton.text = "Learned"
	else:
		learnbutton.text = "Learn"
		learnbutton.skilldir = skilldir
		learnbutton.skillcost = cost
		learnbutton.skilltype = skilltype
	buttonbeep.play()

func _on_panel_node_skillshow() -> void:
	self.grab_focus()
