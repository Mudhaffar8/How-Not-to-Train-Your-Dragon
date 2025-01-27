extends Node

'''
General use class for storing functions and enums used across differents scenes.
Can be accessed using the "utils" node followed by the attribute name.

Example Use case
-------------------

print(utils.test)
'''

func reset_game():
	globals.food = 50
	globals.health = 50
	globals.fun = 50
	globals.coins = 50
	globals.seconds = 0
	
	scene_switcher.switch_scene("res://scenes/main_scenes/main.tscn")
