extends Node
var fireballdmg = 125
var textbutton : Node
var actionpanel : Node
var skillpanel : Node
var combotext : Node
var actionnode : Node

func _ready():
	combotext = $"../../../../../Fight Layer/Combo Text"
	actionnode = $"../../../../Action Node"

func _fireball():
	GlobalSignals.enemy._takedamage(fireballdmg)
	actionnode._engage()
	$"..".hide()
	combotext._on_character_combo("Fireball!\n" + str(fireballdmg) + " Dmg")
