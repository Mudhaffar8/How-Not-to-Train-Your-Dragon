extends Control

@onready var timer = $Timer

func _ready() -> void:
	timer.start()


func _on_back_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main_scenes/main.tscn")


func _on_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/minigames/flappy_bird/flappy_mini.tscn")


func _on_button_5_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main_scenes/main.tscn")


func _on_button_4_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/minigames/coinflip.tscn")
	
func _process(delta: float) -> void:
	if globals.food > 100 || globals.food < 0 || globals.fun < 0 || globals.health < 0:
		scene_switcher.switch_scene("res://scenes/endings/badending.tscn")
		
func _on_timer_timeout() -> void:
	globals.seconds += 1
	if (globals.seconds %  5 == 0):
		globals.food -= 5
		globals.fun -= 5
		
	if (globals.seconds >= 180):
		scene_switcher.switch_scene("res://scenes/endings/goodending.tscn")


func _on_button_6_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/minigames/blackjack/blackjack.tscn")
