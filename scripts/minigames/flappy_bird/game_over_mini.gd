extends Control

const health_loss = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.coins += globals.coins_earned
	globals.health -= health_loss
	
	$CoinsCollected.text = "Coins collected: " + str(globals.coins_earned)
	$TotalCoins.text = "Total coins: " + str(globals.coins)
	$FunCollected.text = "Fun collected: " + str(globals.coins_earned / 3)
	$HealthLost.text = "Total Health: " + str(globals.health) + " (-%s)" % health_loss


func _on_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/minigames/flappy_bird/flappy_mini.tscn") # Replace with function body.


func _on_button_2_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main_scenes/main.tscn")
