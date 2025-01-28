extends Control

func _on_ready():
	print(globals.fun, "\n", globals.food)
	if globals.food < 0:
		$Label4.text = "Goober died from\nlack of food"
	elif globals.food > 100:
		$Label4.text = "Goober died because\nof overfeeding"
	elif globals.fun <= 0:
		$Label4.text = "Goober died from\nlack of fun"
	elif globals.fun > 100:
		$Label4.text = "Goober died from\noverdose with fun"
	elif globals.health <= 0:
		$Label4.text = "Goober died due to\n his health conditions"
	elif globals.coins <= 0:
		$Label4.text = "Goober died because\nhe lost all money"
	else:
		$Label4.text = "idk why tbh"

func _on_restart_pressed() -> void:
	utils.reset_game()
