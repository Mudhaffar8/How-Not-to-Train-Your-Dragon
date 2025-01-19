extends Control

@onready var button = $Button
@onready var shop_button = $ButtonPanel/ShopButton
@onready var minigames_button = $ButtonPanel/MinigamesButton

@onready var dragon = $DragonPosition/DragonBuddy

@onready var food_status : StatusBar = $StatusPanel/StatusBarContainer/FoodStatus
@onready var fun_status : StatusBar = $StatusPanel/StatusBarContainer/FunStatus
@onready var health_status : StatusBar = $StatusPanel/StatusBarContainer/HealthStatus

func _ready() -> void: 
	food_status.set_value(globals.food)
	fun_status.set_value(globals.fun)
	health_status.set_value(globals.health)
	
	button.text = "bannana"

func _on_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/scene_2.tscn")


func _on_shop_button_pressed() -> void:
	scene_switcher.switch_scene("")


func _on_minigames_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/minigames.tscn")
