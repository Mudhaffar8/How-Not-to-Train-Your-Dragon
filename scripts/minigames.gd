extends Control


func _on_back_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main.tscn")


func _on_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/flappy_mini.tscn")


func _on_button_5_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main.tscn")


func _on_button_4_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/minigames/coinflip.tscn")
	
func _process(delta: float) -> void:
	if globals.food > 100 || globals.food < 0 || globals.fun < 0 || globals.health < 0:
		scene_switcher.switch_scene("res://scenes/endings/badending.tscn")
