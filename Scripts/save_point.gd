extends Node2D
signal start_dialogue
signal show_icon
signal hide_icon
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _ready():
	$Area2D.connect("area_entered", Callable($"../Character","_on_interaction_area_entered"))
	$Area2D.connect("area_exited", Callable($"../Character","_on_interaction_area_exited"))
	_on_hide_icon()

func _on_show_icon() -> void:
	$"Interact Icon".visible = true

func _on_hide_icon() -> void:
	$"Interact Icon".visible = false

func _on_start_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start, [self])

func _save():
	GlobalSignals.char_pos = $"../Character".position
	GlobalSignals._save()
