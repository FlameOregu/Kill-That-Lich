extends Node
var ap_cost = 1
var basedamage = 125
var totaldmg : int
var textbutton : Node
var actionpanel : Node
var skillpanel : Node
var abilitytext : Node
var actionnode : Node

func _ready():
	abilitytext = $"../../../../Ability Label"
	actionnode = $"../../../../Action Node"

func _fireball():
	totaldmg = basedamage * ((GlobalSignals.buff * 0.5) + 1)
	GlobalSignals.enemy._takedamage(totaldmg)
	abilitytext._on_ability("Fireball!\n" + str(totaldmg) + " Dmg")
