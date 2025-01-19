extends Control


func _on_back_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main.tscn")


func _on_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/flappy_mini.tscn")


func _on_button_5_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main.tscn")


func _on_button_4_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/minigames/coinflip.tscn")
