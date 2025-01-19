extends Control

@onready var shop_button = $ButtonPanel/ShopButton
@onready var minigames_button = $ButtonPanel/MinigamesButton

@onready var dragon = $Goober

@onready var food_status : StatusBar = %FoodStatus
@onready var fun_status : StatusBar = %FunStatus
@onready var health_status : StatusBar = %HealthStatus

@onready var progress : Label = $Progress

func _ready() -> void: 
	food_status.set_value(globals.food)
	fun_status.set_value(globals.fun)
	health_status.set_value(globals.health)
	
	print(globals.coins)
	

func _process(delta: float) -> void:
	if globals.food > 100 || globals.food < 0 || globals.fun < 0 || globals.health < 0:
		scene_switcher.switch_scene("res://scenes/endings/badending.tscn")
		
	if globals.seconds < globals.egg_time:
		progress.text = "To Next Level: " + str(globals.seconds) + " / " + str(globals.egg_time)
	
	if globals.seconds >= globals.egg_time:
		progress.text = "To Next Level: " + str(globals.seconds) + " / " + str(globals.baby_time)
		$Goober.play("baby_walk")
		globals.gooberState = "baby"
		$InstructionsLabel.visible = false
		
	if globals.seconds >= globals.baby_time:
		progress.text = "To Next Level: " + str(globals.seconds) + " / " + str(globals.teen_time)
		$Goober.play("teen_walk")
		globals.gooberState = "teen"
		


func _on_shop_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/shopui.tscn")


func _on_minigames_button_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/minigames.tscn")
