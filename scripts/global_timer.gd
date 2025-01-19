extends Node

@onready var timer = $Timer
var elapsed_time: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	
	if elapsed_time >= 10:
		globals.food -= 5
		globals.fun -= 5
		elapsed_time = 0

func _on_timer_timeout() -> void:
	scene_switcher.switch_scene("res://scenes/endings/goodending.tscn")
