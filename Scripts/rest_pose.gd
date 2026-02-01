extends Node
var textbutton : Node
var combotext : Node
var actionnode : Node
var character : Node

func _ready():
	character = GlobalSignals.character
	combotext = $"../../../../../Fight Layer/Combo Text"
	actionnode = $"../../../../Action Node"

func _rest() -> void:
	actionnode._engage()
	character._on_manachange(-50)
	if character.currentmana > character.maxmana:
		character.currentmana = character.maxmana
	character.currenthealth += 30
	if character.currenthealth > character.maxhealth:
		character.currenthealth = character.maxhealth
	character._on_healthchange(0)
	combotext._on_character_combo("Recovered!\n+30 HP\n+50 MANA")
