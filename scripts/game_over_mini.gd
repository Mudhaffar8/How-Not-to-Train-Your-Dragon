extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.coins += globals.coinsFlappy
	$Label.text = "Coins collected: " + str(globals.coinsFlappy)
	$Label3.text = "Fun collected: " + str(globals.coinsFlappy / 5 * 4)
	$Label2.text = "Total coins: " + str(globals.coins)
	$Label4.text = "Health lost: " + str(8)
	globals.health -= 8


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/flappy_mini.tscn") # Replace with function body.


func _on_button_2_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main.tscn")
