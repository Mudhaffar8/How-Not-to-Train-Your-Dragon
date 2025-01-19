extends Control

@onready var shop_button = $ButtonPanel/ShopButton
@onready var minigames_button = $ButtonPanel/MinigamesButton

@onready var dragon = $Goober

@onready var food_status : StatusBar = %FoodStatus
@onready var fun_status : StatusBar = %FunStatus
@onready var health_status : StatusBar = %HealthStatus

func _ready() -> void: 
	food_status.set_value(globals.food)
	fun_status.set_value(globals.fun)
	health_status.set_value(globals.health)
	

func _process(delta: float) -> void:
	if globals.food > 100 || globals.food < 0 || globals.fun < 0 || globals.health < 0:
		scene_switcher.switch_scene("res://scenes/endings/badending.tscn")
	

func _on_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/scene_2.tscn")


func _on_shop_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/shopui.tscn")


func _on_minigames_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/minigames.tscn")
