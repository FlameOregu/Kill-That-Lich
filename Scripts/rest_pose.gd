extends Button
var focus : bool

func _ready():
	self.grab_focus()
	await get_tree().create_timer(0.2).timeout

func _on_focus_entered() -> void:
	focus = true

func _on_focus_exited() -> void:
	focus = false

func _input(event):
	if Input.is_action_just_pressed("interact") and focus == true:
		$"../Yes"._outengage()
		$"../../Fight Layer/Character"._on_manachange(-50)
		if $"../../Fight Layer/Character".currentmana > $"../../Fight Layer/Character".maxmana:
			$"../../Fight Layer/Character".currentmana = $"../../Fight Layer/Character".maxmana
		$"../../Fight Layer/Character".currenthealth += 30
		if $"../../Fight Layer/Character".currenthealth > $"../../Fight Layer/Character".maxhealth:
			$"../../Fight Layer/Character".currenthealth = $"../../Fight Layer/Character".maxhealth
		$"../../Fight Layer/Character"._on_healthchange(0)
