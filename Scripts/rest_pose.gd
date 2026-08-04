extends Node
var ap_cost = 1
var textbutton : Node
var abilitytext : Node
var actionnode : Node
var character : Node

func _ready():
	character = GlobalSignals.character
	abilitytext = $"../../../../Ability Label"
	actionnode = $"../../../../Action Node"

func _rest() -> void:
	character._on_manachange(-50)
	if character.currentmana > character.maxmana:
		character.currentmana = character.maxmana
	character.currenthealth += 30
	if character.currenthealth > character.maxhealth:
		character.currenthealth = character.maxhealth
	character._on_healthchange(0)
	abilitytext._on_ability("Recovered!\n+30 HP\n+50 MANA")
