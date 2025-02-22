extends Control

@onready var shop_button = $ButtonPanel/ShopButton
@onready var minigames_button = $ButtonPanel/MinigamesButton

@onready var goober : Goober = $Goober

# Goober status bars
@onready var food_status : StatusBar = %FoodStatus
@onready var fun_status : StatusBar = %FunStatus
@onready var health_status : StatusBar = %HealthStatus

# Manages Goober's progress
@onready var progress : Label = $ButtonPanel/Progress


func _ready() -> void: 
	# Reset status Variables
	food_status.set_value(globals.food)
	fun_status.set_value(globals.fun)
	health_status.set_value(globals.health)


func _process(delta: float) -> void:
	if globals.seconds < globals.egg_time:
		globals.main_time = globals.egg_time
	
	if globals.seconds >= globals.egg_time:
		globals.main_time = globals.baby_time
	
	if globals.seconds >= globals.baby_time:
		globals.main_time = globals.teen_time
	
	# Update progress label
	progress.text = "To Next Level: " + str(globals.seconds) + " / " + str(globals.main_time)


func _on_shop_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main_scenes/shopui.tscn")


func _on_minigames_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main_scenes/minigames.tscn")
