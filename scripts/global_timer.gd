extends Node

@onready var timer = $Timer

@onready var food_status : StatusBar = %FoodStatus
@onready var fun_status : StatusBar = %FunStatus
@onready var health_status : StatusBar = %HealthStatus

var elapsed_time: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	print(elapsed_time) # Debugging
	
	if elapsed_time >= 4: # More testing
		globals.food -= 5
		globals.fun -= 5
		elapsed_time = 0
		
		# Update Labels
		food_status.set_value(globals.food)
		fun_status.set_value(globals.fun)
		health_status.set_value(globals.health)




func _on_timer_timeout() -> void:
	scene_switcher.switch_scene("res://scenes/endings/goodending.tscn")
