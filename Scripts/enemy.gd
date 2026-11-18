extends Node2D
var maxhp = 1500
var currenthp = maxhp
var attacknum = 1
var character : Node
signal endfight #ends the attack
signal endbattle
signal health_changed(currenthp, maxhp)
signal attack
@export var battlecharacter: Player
@export var Dialogue : DialogueResource

func _enter_tree() -> void:
	GlobalSignals.enemy = self

func _ready():
	character = GlobalSignals.character

func _takedamage(damage):
	if (currenthp - damage) <= 0:
		_endbattle()
	currenthp -= damage
	health_changed.emit(currenthp, maxhp)

func _on_engage() -> void:
	attack.emit()

func _endbattle(): #full battle is over, either lost or won
	endbattle.emit()
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _endfight() -> void:
	endfight.emit()
