extends Control

@onready var timer = $Timer

func _ready() -> void:
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_go_back_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main.tscn")


func _on_timer_timeout() -> void:
	print(globals.seconds)
	globals.seconds += 1
	if (globals.seconds %  5 == 0):
		globals.food -= 5
		globals.fun -= 5
		
	if (globals.seconds >= 180):
		scene_switcher.switch_scene("res://scenes/endings/goodending.tscn")
