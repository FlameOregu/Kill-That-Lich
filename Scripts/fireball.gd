extends Node
var ap_cost = 1
var fireballdmg = 125
var textbutton : Node
var actionpanel : Node
var skillpanel : Node
var abilitytext : Node
var actionnode : Node

func _ready():
	abilitytext = $"../../../../Ability Label"
	actionnode = $"../../../../Action Node"

func _fireball():
	GlobalSignals.enemy._takedamage(fireballdmg)
	abilitytext._on_ability("Fireball!\n" + str(fireballdmg) + " Dmg")
