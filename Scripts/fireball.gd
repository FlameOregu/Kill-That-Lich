extends Button
var focus : bool
var fireballdmg = 125

func _ready():
	self.grab_focus()
	await get_tree().create_timer(0.2).timeout

func _input(event):
	if Input.is_action_just_pressed("interact") and focus == true:
		if ($"../../Fight Layer/Character".currentmana - 50) >= 0:
			$"../../Fight Layer/Character"._on_manachange(50)
			$"../../Fight Layer/Enemy"._takedamage(fireballdmg)
			$"../Yes"._outengage()
			hide()
			$"../../Fight Layer/Combo Text"._on_character_combo("Fireball!\n" + str(fireballdmg) + " Dmg")
		else:
			hide()
			$"..".show()
			$"../Text".show()
			$"../Text".text = "You do not have enough mana."
			await get_tree().create_timer(1.5).timeout
			$"..".hide()
			$"../Text".hide()
			$"../Text".text = ""
			$".."._on_cancel()

func _on_focus_entered() -> void:
	focus = true

func _on_focus_exited() -> void:
	focus = false
