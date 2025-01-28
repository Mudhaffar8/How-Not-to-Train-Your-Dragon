extends Control

@onready var timer = $Timer


func _ready() -> void:
	timer.start()
	$Timer2.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_go_back_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main_scenes/main.tscn")


func _on_timer_timeout() -> void:
	globals.seconds += 1
	
	if (globals.seconds %  5 == 0):
		globals.food -= 5
		globals.fun -= 4
	
	if (globals.seconds >= 180):
		scene_switcher.switch_scene("res://scenes/endings/goodending.tscn")


func _on_timer_2_timeout() -> void:
	$Sprite2D.visible = false
	$Coins/ErrorLabel.visible = false
