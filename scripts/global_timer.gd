extends Node

@onready var timer = $Timer
@onready var egg_timer = $EggStateTimer


@onready var food_status : StatusBar = %FoodStatus
@onready var fun_status : StatusBar = %FunStatus
@onready var health_status : StatusBar = %HealthStatus


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	egg_timer.start()

func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	globals.seconds += 1
	
	if (globals.seconds %  5 == 0):
		globals.food -= 5
		globals.fun -= 5
		
		# Update Labels
		food_status.set_value(globals.food)
		fun_status.set_value(globals.fun)
		health_status.set_value(globals.health)
		
	if (globals.seconds >= globals.teen_time):
		scene_switcher.switch_scene("res://scenes/endings/goodending.tscn")


func _on_egg_state_timer_timeout() -> void:
	timer.start()
