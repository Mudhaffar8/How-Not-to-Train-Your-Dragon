extends Node

'''
Timer for counting down Goober attributes.
'''

# Main timer for managing goober stats
@onready var timer = $Timer

# Goober Status Bars
@onready var food_status : StatusBar = %FoodStatus
@onready var fun_status : StatusBar = %FunStatus
@onready var health_status : StatusBar = %HealthStatus


func _on_timer_timeout() -> void:
	globals.seconds += 1
	
	# Decrease goober stats by 5 every 5 seconds
	if (globals.seconds % 5 == 0):
		globals.food -= 5
		globals.fun -= 4
		
		# Update Labels
		food_status.set_value(globals.food)
		fun_status.set_value(globals.fun)
		health_status.set_value(globals.health)
	
	# Beat the Game
	if (globals.seconds >= globals.teen_time):
		scene_switcher.switch_scene("res://scenes/endings/goodending.tscn")
		
	# Lose the game
	if globals.food > 100 || globals.food <= 0 || globals.fun <= 0 || globals.health <= 0:
		scene_switcher.switch_scene("res://scenes/endings/badending.tscn")
