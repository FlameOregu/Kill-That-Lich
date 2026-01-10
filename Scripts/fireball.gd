extends Button
var focus : bool
var fireballdmg = 125
var descript_text = "Fireball (50 MP) - Shoot a ball of magical fire using your magical essence to deal damage."
var textbutton : Node
var actionpanel : Node
var skillpanel : Node
var combotext : Node
var yesbutton : Node

func _ready():
	textbutton = $"../../../Text"
	actionpanel = $"../../.."
	skillpanel = $"../.."
	combotext = $"../../../../Fight Layer/Combo Text"
	yesbutton = $"../../../Yes"

func _input(event):
	if Input.is_action_just_pressed("interact") and focus == true:
		if (GlobalSignals.character.currentmana - 50) >= 0:
			GlobalSignals.character._on_manachange(50)
			GlobalSignals.enemy._takedamage(fireballdmg)
			yesbutton._outengage()
			hide()
			combotext._on_character_combo("Fireball!\n" + str(fireballdmg) + " Dmg")
		else:
			skillpanel.hide()
			textbutton.show()
			textbutton.text = "You do not have enough mana."
			await get_tree().create_timer(1).timeout
			textbutton.hide()
			textbutton.text = ""
			actionpanel._on_cancel("magic")

func _on_focus_entered() -> void:
	textbutton.text = descript_text
	focus = true

func _on_focus_exited() -> void:
	focus = false
